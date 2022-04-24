# CREATE or REPLACE VIEW
create or replace view clients_balance as
select c.client_id, c.name, sum(i.invoice_total) - sum(i.payment_total) as balance
from sql_invoicing.clients c
         join sql_invoicing.invoices i
              on i.client_id = c.client_id
group by c.client_id, c.name;

# DROP VIEW
drop view clients_balance;

# WITH OPTION CHECK
create or replace view invoices_with_balance as
select invoice_id,
       number,
       client_id,
       invoice_total,
       payment_total,
       invoice_total - payment_total as balance,
       invoice_date,
       due_date,
       payment_date
from sql_invoicing.invoices
where (invoice_total - payment_total) > 0
with check option;