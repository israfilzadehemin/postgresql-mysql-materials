# GROUP BY
select date, pm.name as payment_method, sum(amount) as total_amounts
from sql_invoicing.payments p
         join sql_invoicing.payment_methods pm on p.payment_method = pm.payment_method_id
group by date, payment_method
order by date;

# HAVING
select first_name, last_name, o.customer_id, sum(oi.quantity * oi.unit_price) as 'total_amount'
from sql_store.customers c
         join sql_store.orders o
              on c.customer_id = o.customer_id
         join sql_store.order_items oi
              on o.order_id = oi.order_id
where state = 'VA'
group by first_name, last_name, o.customer_id
having total_amount > 50;

# WITH ROLLUP
select pm.name as payment_method, sum(amount) as total
from sql_invoicing.payments p
         join sql_invoicing.payment_methods pm
              on p.payment_method = pm.payment_method_id
group by pm.name
with rollup;