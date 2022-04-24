-- Transaction with commit
START TRANSACTION;
INSERT INTO sql_hr.office(code, address_id) VALUES ('321AZE-535', 1);
INSERT INTO sql_hr.log(table_name, operation, username, date_time) VALUES ('OFFICE', 'INSERT', user, now());
COMMIT;

-- Transaction with rollback
START TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; -- READ COMMITTED, REPEATABLE READ, SERIALIZABLE
INSERT INTO sql_hr.office(code, address_id) VALUES ('323AZE-535', 1);
SELECT * FROM sql_hr.office;
INSERT INTO sql_hr.log(table_name, operation, username, date_time) VALUES ('OFFICE', 'INSERT', user, now());
ROLLBACK;
