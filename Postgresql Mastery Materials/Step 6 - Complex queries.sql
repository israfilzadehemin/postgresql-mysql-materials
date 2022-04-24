-- Complex queries
SELECT *
FROM sql_hr.employee
WHERE salary >=
      (SELECT avg(salary)
       FROM sql_hr.employee);

select *
FROM sql_hr.employee
WHERE office_id NOT IN
      (SELECT office_id
       FROM sql_hr.employee
       WHERE office_id BETWEEN 7 AND 15);

SELECT id,
       full_name,
       salary,
       office_id
FROM sql_hr.employee e
WHERE salary = (
    SELECT max(salary)
    FROM sql_hr.employee
    WHERE e.office_id = office_id
);

SELECT e.id,
       e.full_name,
       (SELECT code FROM sql_hr.office o WHERE e.office_id = o.id) AS office_code
FROM sql_hr.employee e;

SELECT *
FROM (SELECT *
      FROM sql_hr.employee
      WHERE salary > (
          SELECT avg(salary)
          FROM sql_hr.employee
      )
     ) AS high_salaries;