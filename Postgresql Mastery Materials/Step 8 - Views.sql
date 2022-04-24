-- Create view
CREATE OR REPLACE VIEW sql_hr.all_required_data AS
SELECT e.id,
       e.employee_id,
       e.full_name,
       e.job_title,
       e.salary,
       m.full_name                            AS reports_to,
       o.code                                 AS office_code,
       a.address                              AS address,
       a.city                                 AS address_city,
       coalesce(a.state, '***UNAVAILABLE***') AS address_state
FROM sql_hr.employee e
         LEFT JOIN sql_hr.employee m ON e.reports_to = m.employee_id
         LEFT JOIN sql_hr.office o ON e.office_id = o.id
         LEFT JOIN sql_hr.address a ON o.address_id = a.id
ORDER BY e.job_title, e.full_name
LIMIT 100 OFFSET 50;

-- Create view with check option
CREATE OR REPLACE VIEW sql_hr.view_with_check as
    SELECT *
FROM sql_hr.office
WITH CHECK OPTION;

-- Create materialized view
CREATE MATERIALIZED VIEW IF NOT EXISTS sql_hr.all_required_data_materialized AS
SELECT e.id,
       e.employee_id,
       e.full_name,
       e.job_title,
       e.salary,
       m.full_name                            AS reports_to,
       o.code                                 AS office_code,
       a.address                              AS address,
       a.city                                 AS address_city,
       coalesce(a.state, '***UNAVAILABLE***') AS address_state
FROM sql_hr.employee e
         LEFT JOIN sql_hr.employee m ON e.reports_to = m.employee_id
         LEFT JOIN sql_hr.office o ON e.office_id = o.id
         LEFT JOIN sql_hr.address a ON o.address_id = a.id
ORDER BY e.job_title, e.full_name
LIMIT 100 OFFSET 50;

-- Refresh materialized view
REFRESH MATERIALIZED VIEW sql_hr.all_required_data_materialized;

-- Drop view
DROP VIEW sql_hr.view_with_check;
DROP MATERIALIZED VIEW sql_hr.all_required_data_materialized;