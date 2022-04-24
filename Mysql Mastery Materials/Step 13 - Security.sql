# CREATE USER
create user new_user
    identified by '123567';

create user moon_app identified by '123';

# view users
select *
from mysql.user;

# DROP USER
drop user new_user;

# SET PASSWORD
set password
    # for new_user
    = '321';

# GRANT privileges
grant select, insert, update, delete, execute
on sql_store.*
to moon_app;

grant all
on *.*
to new_user;

# view privileges
show grants for moon_app;

# REVOKE privileges
revoke delete on sql_store.* from moon_app;

# DROP USER
drop user new_user;
drop user moon_app;