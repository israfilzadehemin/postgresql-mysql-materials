# essential functions
-- ------------------------------------------------------------------------------------------

# numeric
select round(5.677, 1);
#ceiling(), floor(), abs() ...

# string
select length('emin1'); #upper(), lower()
select ltrim('      emi'); #rtrim(), trim()
select left(' Lorem ipsum ', 3); #right(), substring(), replace(), concat()
select locate('' or '', 'Lormie ipsum');

# date
select year(now()); #day(curdate()), minute(curtime())
select extract(day from now());
select date_format(now(), ' % y % Y % m % M % d ');
select time_format(now(), ' % H % i % s % p ');
select date_add(now(), interval 5 day);
#date_sub(), date_diff()

# COALESCE
select order_id, coalesce(shipper_id, comments, ' Not assigned ') as shipper
from sql_store.orders;

# IFNULL
select concat(first_name, '' '', last_name) as customer, ifnull(phone, 'UNKNOWN')
from sql_store.customers;

# IF
select product_id,
       (select name from sql_store.products p where p.product_id = oi.product_id) as name,
       count(order_id)                                                            as orders,
       if(count(order_id) <= 1, 'Once', 'Many times')                             as frequency
from sql_store.order_items oi
group by product_id;

# CASE
select concat(first_name, '' '', last_name) as customer,
       points,
       case
           when c.points <= 1000 then 'Bronze'
           when c.points > 1000 and c.points <= 3000 then 'Silver'
           when c.points > 3000 then 'Gold'
           end                              as category
from sql_store.customers c;
-- ------------------------------------------------------------------------------------------