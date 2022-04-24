-- Create user
CREATE USER emin WITH PASSWORD '123';

-- Show users
select *
from pg_user;

-- Update password
ALTER USER emin WITH PASSWORD 'new';

-- Grant privileges
GRANT SELECT, UPDATE, DELETE
    ON sql_hr.employee
    TO emin;

-- Revoke privileges
REVOKE DELETE, UPDATE
    ON sql_hr.employee
    FROM emin;

-- View privileges
SELECT *
FROM information_schema.table_privileges
where grantee = 'emin';