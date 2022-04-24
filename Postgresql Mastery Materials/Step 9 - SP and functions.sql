-- Procedure for insert
CREATE OR REPLACE PROCEDURE sql_hr.insert_employee(
    p_full_name VARCHAR(100),
    p_job_title VARCHAR(100),
    p_salary DECIMAL(8, 2)
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    IF p_full_name IS NULL THEN
        RAISE EXCEPTION 'Full name must not be null' ;
    END IF;
    IF p_job_title IS NULL THEN
        RAISE EXCEPTION 'Job title must not be null' ;
    END IF;

    INSERT INTO sql_hr.employee(full_name, job_title, salary, reports_to)
    VALUES (p_full_name,
            p_job_title,
            p_salary,
            CASE
                WHEN p_salary <= 5000 THEN (SELECT employee_id from sql_hr.employee WHERE id = 1)
                WHEN p_salary > 5000 AND p_salary <= 10000 THEN (SELECT employee_id from sql_hr.employee WHERE id = 2)
                WHEN p_salary > 10000 THEN (SELECT employee_id from sql_hr.employee WHERE id = 3)
                END);

END
$$;

CALL sql_hr.insert_employee('Emin Israfilzadeh 9', 'Developer', 7500);

-- Function to get data
CREATE OR REPLACE FUNCTION sql_hr.get_salary_sum_by_title(
    p_title VARCHAR
)
    RETURNS DECIMAL(8, 2)
AS
$$
BEGIN
    RETURN (SELECT sum(salary)
            FROM sql_hr.employee
            WHERE job_title LIKE concat('%', p_title, '%'));
END
$$
    LANGUAGE plpgsql;

SELECT sql_hr.get_salary_sum_by_title('Junior');

