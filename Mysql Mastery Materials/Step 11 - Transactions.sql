# START TRANSACTION
start transaction;
insert into sql_store.orders (customer_id, order_date, status)
values (1, '2019-01-01', 1);

insert into sql_store.order_items
values (last_insert_id(), 1, 1, 1);
commit;
# ROLLBACK

# SET TRANSACTION ISOLATION LEVEL
set session transaction isolation level
    read uncommitted;
# read committed
# repeatable read
# serializable
