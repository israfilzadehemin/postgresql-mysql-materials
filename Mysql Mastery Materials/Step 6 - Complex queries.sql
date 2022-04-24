# complex queries
-- ------------------------------------------------------------------------------------------
# 1
select *
from sql_hr.employees
where salary >
      (select avg(salary) from sql_hr.employees);

# 2
select *
from sql_invoicing.clients
where client_id not in
      (select distinct client_id from sql_invoicing.invoices);

# 3
select c.customer_id, o.order_id, oi.product_id
from sql_store.customers c
         join sql_store.orders o
              on c.customer_id = o.customer_id
         join sql_store.order_items oi
              using (order_id)
         join sql_store.products p
              on oi.product_id = p.product_id
where p.product_id = 3;

select customer_id
from sql_store.customers
where customer_id in (
    select customer_id
    from sql_store.orders
    where order_id IN (select order_id
                       from sql_store.order_items
                       where product_id = (select product_id from sql_store.products where name like 'lettuce%')));

# 4
select invoice_id, client_id, invoice_total
from sql_invoicing.invoices i
where invoice_total > (
    select avg(invoice_total)
    from sql_invoicing.invoices
    where i.client_id = client_id
);

# 5
select *
from sql_store.products p
where not exists(
        select product_id
        from sql_store.order_items oi
        where oi.product_id = p.product_id
    );

# 6
select client_id,
       name,
       (select sum(invoice_total) from sql_invoicing.invoices i where c.client_id = i.client_id) as total_sales,
       (select avg(invoice_total) from sql_invoicing.invoices)                                   as average,
       (select total_sales - average)                                                            as difference
from sql_invoicing.clients c;

# 7
select *
from (
         select client_id,
                name,
                (select sum(invoice_total)
                 from sql_invoicing.invoices i
                 where c.client_id = i.client_id)                       as total_sales,
                (select avg(invoice_total) from sql_invoicing.invoices) as average,
                (select total_sales - average)                          as difference
         from sql_invoicing.clients c
     ) as total_sales
where total_sales is not null;
-- ------------------------------------------------------------------------------------------
