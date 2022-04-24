# index types
-- prefix
-- full text
-- composite

# CREATE INDEX
create index idx_points on sql_store.customers (points);
create index idx_lastname on sql_store.customers (last_name(20)); # prefix
create fulltext index idx_name on sql_store.customers (first_name, last_name); # fulltext
create index idx_state_points on sql_store.customers (state, points);
# composite


# SHOW INDEXES
show indexes in sql_store.customers;

# fulltext index MATCH
select *, match(first_name, last_name) against('emin isra') as relevance
from sql_store.customers
where match(first_name, last_name) against('emin -isra' in boolean mode);
