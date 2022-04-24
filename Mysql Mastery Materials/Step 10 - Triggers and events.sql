# CREATE TRIGGER
delimiter $$
create trigger payments_after_insert
    after insert
    on sql_invoicing.payments
    for each row
begin
    update sql_invoicing.invoices
    set payment_total = payment_total + NEW.amount
    where invoice_id = new.invoice_id;

    insert into payments_audit
    values (new.client_id, new.date, new.amount, 'INSERT', now());
end $$
delimiter ;

# SHOW TRIGGERS
show triggers like 'payments%';

# DROP TRIGGER
drop trigger if exists payments_after_insert;

# create event
delimiter $$
create event yearly_delete_stale_audit_rows
    on schedule
-- at '2022-30-03
        every 1 year
            starts '2022-03-30' # optional
            ends '2092-03-31' # optional
    do begin
    delete
    from payments_audit
    where action_date < now() - interval 1 year;
end $$
delimiter ;

# SHOW EVENTS
show events;

# DROP EVENT
drop event if exists yearly_delete_stale_audit_rows;

# ALTER EVENT
delimiter $$
alter event yearly_delete_stale_audit_rows
    on schedule
        -- at '2022-30-03
        every 1 year
            starts '2022-03-30' # optional
            ends '2092-03-31' # optional
    do begin
    delete
    from payments_audit
    where action_date < now() - interval 1 year;
end $$
delimiter ;

# DISABLE event
alter event yearly_delete_stale_audit_rows disable;
