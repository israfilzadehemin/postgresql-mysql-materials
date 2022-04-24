-- Create function for trigger
CREATE OR REPLACE FUNCTION sql_hr.insert_log()
    RETURNS trigger
AS
$$
BEGIN
    INSERT INTO sql_hr.log(table_name, operation, username, date_time)
    VALUES('EMPLOYEE', 'INSERT', user, now());
    RETURN NULL;
END
$$
    LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER after_insert
    AFTER INSERT
    ON sql_hr.employee
    FOR EACH ROW
    EXECUTE FUNCTION sql_hr.insert_log();

-- Drop trigger
DROP TRIGGER IF EXISTS after_insert on sql_hr.employee;

-- Check trigger
INSERT INTO sql_hr.employee(full_name, job_title, salary)
VALUES ('E I', 'Dev', 5000);