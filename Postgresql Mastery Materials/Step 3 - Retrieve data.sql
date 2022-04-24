-- Retrieve data from a single table
SELECT id,
       full_name,
       job_title,
       salary                  AS salary_in_azn,
       ROUND(salary / 1.70, 2) AS salary_in_usd
FROM sql_hr.employee;

SELECT id
                                  full_name,
       job_title,
       salary                  AS salary_in_azn,
       ROUND(salary / 1.70, 2) AS salary_in_usd
FROM sql_hr.employee
WHERE salary >= 10000;

SELECT *
FROM sql_hr.employee
WHERE job_title
    IN ('Design Engineer', 'Internal Auditor')
   OR (job_title
           NOT IN ('VP Marketing', 'Account Executive', 'Environmental Tech')
    AND
       id > 500);

SELECT *
FROM sql_hr.employee
WHERE salary BETWEEN 5000 AND 10500;

SELECT *
FROM sql_hr.employee
WHERE upper(job_title) LIKE '%JUNIOR%'
   OR upper(job_title) LIKE '%MARKETING'
   OR upper(job_title) LIKE '________ OF SALES';

SELECT *
FROM sql_hr.employee
WHERE full_name ~ '^[A-Z][a-z].*$'
  AND job_title IS NOT NULL
ORDER BY full_name
LIMIT 100 OFFSET 50;

-- Retrieve data from multiple table
SELECT e.id   as employee_id,
       e.full_name,
       o.code as office_code,
       a.address,
       a.city,
       a.state
FROM sql_hr.employee as e
         JOIN sql_hr.office o
              ON e.office_id = o.id
         JOIN sql_hr.address a
              ON o.address_id = a.id;

SELECT e.id   as employee_id,
       e.full_name,
       o.code as office_code,
       a.address,
       a.city,
       a.state
FROM sql_hr.employee as e
         LEFT JOIN sql_hr.office o
                   ON e.office_id = o.id
         RIGHT JOIN sql_hr.address a
                    ON o.address_id = a.id;

SELECT e.full_name as employee,
       r.full_name as manager
from sql_hr.employee e
         JOIN sql_hr.employee r
              ON e.reports_to = r.employee_id;

SELECT *
FROM sql_hr.employee as e
         FULL JOIN sql_hr.office o
                   ON e.office_id = o.id

SELECT e.full_name,
       o.code
FROM sql_hr.employee e
         CROSS JOIN sql_hr.office o;

SELECT full_name,
       salary,
       'HIGH PAID' as status
from sql_hr.employee
WHERE salary >= 10000
UNION ALL
SELECT full_name,
       salary,
       'AVERAGE PAID' as status
from sql_hr.employee
WHERE salary BETWEEN 5000 AND 10000
UNION DISTINCT
SELECT full_name,
       salary,
       'LOW PAID' as status
from sql_hr.employee
WHERE salary <= 5000
ORDER BY full_name;
