# INSERT
insert into sql_store.customers
    (first_name, last_name, birth_date, address, phone, city, state)
values ('Emin', 'Israfilzadeh', '1995-08-15', 'Bakuuu', '705595656', 'Bakuu', 'Az'),
       ('Emin1', 'Israfilzadeh1', '1995-08-15', 'Bakuuu', '705595656', 'Bakuu', 'Az');

# INSERT hierarchical rows
insert into sql_store.orders(customer_id, order_date, status)
values (1, '2019-01-02', 1);

insert into sql_store.order_items
values (LAST_INSERT_ID(), 1, 1, 2.95),
       (LAST_INSERT_ID(), 2, 1, 2.95);

# copy table
create table invoices_archived as
select invoice_id,
       i.number,
       c.name as client,
       i.invoice_total,
       i.payment_total,
       i.invoice_date,
       i.payment_date
from sql_invoicing.invoices i
         join sql_invoicing.clients c
              using (client_id)
where payment_date is not null;

# UPDATE
update sql_store.customers
set points = points + points * 1.5
where birth_date > '1990-01-01';

# UPDATE with subqueries
update sql_store.orders
set comments = 'GOLD'
where customer_id in (
    select customer_id
    from sql_store.customers
    where points > 3000);

# DELETE
delete
from sql_invoicing.invoices
where client_id = (select client_id from sql_invoicing.clients where name = 'Myworks');

# aggregate funcs
select max(invoice_total)      as highest,
       min(invoice_total)      as minimum,
       avg(invoice_total)      as average,
       sum(invoice_total)      as minimum,
       sum(distinct client_id) as total_records,
       count(invoice_total)    as count
from sql_invoicing.invoices;