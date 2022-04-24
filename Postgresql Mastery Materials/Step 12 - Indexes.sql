-- Create index
CREATE INDEX idx_fullname on sql_hr.employee(full_name);

-- Show index
SELECT * FROM pg_indexes WHERE tablename LIKE '%employee%';
