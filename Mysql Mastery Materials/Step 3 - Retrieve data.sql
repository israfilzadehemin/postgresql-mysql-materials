# SELECT with arithmetic
select name, unit_price, unit_price * 1.1 as 'new price'
from sql_store.products;

# WHERE with arithmetic
select *
from sql_store.order_items
where order_id = 6
  AND unit_price * quantity > 30;

# WHERE with IN
select *
from sql_store.products
where quantity_in_stock not in (49, 38, 72);

# simple INNER JOIN
select o.order_id, p.name, p.quantity_in_stock, p.unit_price
from sql_store.order_items o
         join sql_store.products p
              on o.product_id = p.product_id;

# SELF JOIN
select e.first_name, m.first_name as manager
from sql_hr.employees e
         join sql_hr.employees m
              on e.reports_to = m.employee_id;

# JOIN multiple table
select p.payment_id, p.date, p.amount, c.name as client_name, pm.name as payment_method
from sql_invoicing.payments p
         join sql_invoicing.clients c
              on p.client_id = c.client_id
         join sql_invoicing.payment_methods pm
              on p.payment_id = pm.payment_method_id;

#  compound JOIN
select *
from sql_store.order_items oi
         join sql_store.order_item_notes oin
              on oi.order_id = oin.order_Id
                  and oi.product_id = oin.product_id;

# implicit JOIN syntax
select *
from sql_store.orders o,
     sql_store.customers c
where o.customer_id = c.customer_id;

# OUTER JOIN
select p.product_id, p.name, o.quantity
from sql_store.products p
         left join sql_store.order_items o
                   on p.product_id = o.product_id;

# OUTER JOIN multiple tables
select o.order_date, o.order_id, c.first_name, s.name as shipper, os.name
from sql_store.orders o
         left join sql_store.customers c
                   on o.customer_id = c.customer_id
         left join sql_store.shippers s
                   on o.shipper_id = s.shipper_id
         left join sql_store.order_statuses os
                   on o.status = os.order_status_id;

# SELF OUTER JOIN
select e.first_name, m.first_name as manager
from sql_hr.employees e
         left join sql_hr.employees m
                   on e.reports_to = m.employee_id;

# USING clause
select p.date, c.name as client, p.amount, pm.name as payment_method
from sql_invoicing.payments p
         join sql_invoicing.clients c using (client_id)
         join sql_invoicing.payment_methods pm
              on p.payment_method = pm.payment_method_id;

# NATURAL JOIN
select o.order_id, c.first_name
from sql_store.orders o
         NATURAL JOIN sql_store.customers c;

# explicit CROSS JOIN
select *
from sql_store.shippers s
         cross join sql_store.products p;

# implicit CROSS JOIN
select *
from sql_store.shippers,
     sql_store.products;

# UNION
select *, 'Bronze' as type
from sql_store.customers
where points < 2000
union
select *, 'Silver' as type
from sql_store.customers
where points BETWEEN 2000 and 3000
union
select *, 'Gold' as type
from sql_store.customers
where points > 3000
order by first_name;
