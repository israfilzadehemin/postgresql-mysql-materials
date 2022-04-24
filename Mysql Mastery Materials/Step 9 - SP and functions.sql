# CREATE PROCEDURE
delimiter $$
create procedure get_invoices_with_balance()
BEGIN
    select * from sql_invoicing.invoices_with_balance;
END$$

delimiter ;
call get_invoices_with_balance();

# DROP PROCEDURE
drop procedure if exists get_invoices_with_balance;

# PROCEDURE with param
delimiter $$
create procedure get_invoices_by_client(client_id int)
begin
    select * from sql_invoicing.invoices i where i.client_id = client_id;
end $$

delimiter ;
call get_invoices_by_client(5);

# PROCEDURE with param with default value
delimiter $$
create procedure get_payments_by_client_and_method(client_id int, payment_method_id tinyint)
begin
    select *
    from sql_invoicing.payments p
    where p.client_id = ifnull(client_id, p.client_id)
      and p.payment_method = ifnull(payment_method_id, p.payment_method);
end $$

delimiter ;
call get_payments_by_client_and_method(3, 1);

# PROCEDURE param validation
delimiter $$
create procedure update_amount_and_date_by_id(
    invoice_id int,
    payment_amount decimal(9, 2),
    payment_date date
)
begin
    if payment_amount <= 0 then
        signal sqlstate '22003' set message_text = 'Payment amount must be positive value';
    end if;

    update sql_invoicing.payments p
    set p.amount = payment_amount,
        p.date   = payment_date
    where p.invoice_id = invoice_id;
end $$

delimiter ;
call update_amount_and_date_by_id(11, 300, '2022-10-25');

select *
from sql_invoicing.payments
where invoice_id = 11;

# PROCEDURE with OUT params
delimiter $$
create procedure get_count_and_total_by_client(
    client_id int,
    out invoice_count int,
    out invoice_total decimal(9, 2))
begin
    select count(*), sum(invoice_total)
    into invoice_count, invoice_total
    from sql_invoicing.invoices i
    where i.client_id = client_id;
end $$

delimiter ;

select i.invoice_total, i.invoice_date
from sql_invoicing.invoices i
where i.invoice_id = 1;

# variable
set @invoice_count = 0;
set @invoice_total = 0;
call get_count_and_total_by_client(3, @invoice_count, @invoice_total); -- invoice_total issue
select @invoice_count, @invoice_total;

# function
delimiter $$
create function get_risk_factor_for_client(client_id int)
    returns integer
    #   deterministic
    #   modifies sql data
    reads sql data
begin

    declare risk_factor decimal(6, 2) default 0;
    declare invoices_total decimal(6, 3);
    declare invoices_count int;

    select count(*), sum(invoice_total)
    into invoices_count, invoices_total
    from sql_invoicing.invoices i
    where i.client_id = client_id;

    set risk_factor = invoices_total / invoices_count * 5;

    return ifnull(risk_factor, 0);
end $$

delimiter ;

select c.client_id,
       c.name,
       get_risk_factor_for_client(c.client_id) as risk_factor
from sql_invoicing.clients c;
