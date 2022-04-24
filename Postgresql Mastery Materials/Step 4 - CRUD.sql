-- Copy table
CREATE TABLE sql_hr.office_copy as
SELECT *
FROM sql_hr.office
WHERE id > 10;

-- Insert data
INSERT INTO sql_hr.office(code, address_id)
VALUES ('755-033', 5),
       ('551-233', 2),
       ('553-733', 3);

-- Update data
UPDATE sql_hr.office_copy
SET code = 'NEW CODE'
where address_id = (
    SELECT id
    FROM sql_hr.address
    WHERE address_id = '097fb37a-bd7a-11ec-9cbf-b23ebcbe2c89'
);

-- Delete data
DELETE
from sql_hr.office_copy
WHERE address_id IN (2,3,5);
