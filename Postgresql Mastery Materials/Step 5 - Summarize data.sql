-- Aggregate functions
SELECT round(max(salary), 2)          AS max_salary,
       round(min(salary), 2)          AS min_salary,
       round(avg(salary), 2)          AS average_salary,
       round(sum(salary), 2)          AS total_salary,
       round(sum(DISTINCT salary), 2) AS total_distincted_salary,
       count(*)                       AS count
FROM sql_hr.employee;

-- Grouping data
SELECT e.office_id, o.code, sum(salary) AS total_salary
FROM sql_hr.employee e
         JOIN sql_hr.office o
              ON e.office_id = o.id
GROUP BY ROLLUP (o.code, e.office_id)
HAVING sum(salary) >= 300000;
