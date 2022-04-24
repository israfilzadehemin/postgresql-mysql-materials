-- Numeric functions
SELECT round(5.666, 2),
       ceil(5.631),
       floor(5.675),
       abs(-777);

-- String functions
SELECT length('         Lorem ipsum dolor sit ame         '),
       upper('         Lorem ipsum dolor sit ame         '),
       lower('         Lorem ipsum dolor sit ame         '),
       ltrim('         Lorem ipsum dolor sit ame         '),
       rtrim('         Lorem ipsum dolor sit ame         '),
       trim('         Lorem ipsum dolor sit ame         '),
    left ('         Lorem ipsum dolor sit ame         ', 25),
    right ('         Lorem ipsum dolor sit ame         ', 25),
    substring ('         Lorem ipsum dolor sit ame         ', 15),
    replace('         Lorem ipsum dolor sit ame         ', 'ore', 'hahaha'),
    concat('         Lorem ipsum dolor sit ame         ', ' hahaha'),
    position ('dolor' IN '         Lorem ipsum dolor sit ame         ');

-- Date functions
SELECT extract(YEAR FROM now())              AS year_of_now,
       extract(DAY FROM current_date)        AS day_of_current_date,
       extract(MINUTE FROM current_time)     AS minute_of_current_time,
       to_char(now(), 'DD.MM.YYYY HH:MI:ss') AS formatted_date_time,
       current_date + INTERVAL '3 DAY' AS current_date_plus_day,
    now() - INTERVAL '5 MINUTE' AS now_minus_minute,
    date_part('HOUR', now()) - date_part('HOUR', now() + INTERVAL '5 HOUR') AS difference_in_hours;

SELECT (DATE_PART('year', '2012-01-01'::date) - DATE_PART('year', '2011-10-02'::date)) * 12 +
       (DATE_PART('month', '2012-01-01'::date) - DATE_PART('month', '2011-10-02'::date));

-- Assign value for null cases
SELECT coalesce(state, city, 'UNKNOWN') AS state_ifnull_city_ifnull_unknown
FROM sql_hr.address
WHERE address_id = '095e7f02-bd7a-11ec-9cbf-b23ebcbe2c89';

-- Case
SELECT address_id,
       CASE
           WHEN state IS NOT NULL THEN concat('STATE: ', state)
           WHEN city IS NOT NULL THEN concat('CITY: ', city)
           END
           AS location
from sql_hr.address;