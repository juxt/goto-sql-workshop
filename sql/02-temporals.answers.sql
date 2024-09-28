-- @conn xtdb

-- Q: Construct date, time, timestamp and timestamp with Europe/Copenhagen
-- @block
SELECT
    DATE '2024-01-01',
    TIME '14:30:00',
    TIMESTAMP '2024-01-01T00:00:00[Europe/Copenhagen]';

-- Q: Construct a period and an interval
-- @block
SELECT
    PERIOD(TIMESTAMP '2024-01-01T00:00:00[Europe/Copenhagen]',
           TIMESTAMP '2024-01-02T00:00:00[Europe/Copenhagen]'),
    INTERVAL 'P1MT1M';


-- Q: Calculate the difference between the 13th of January and the 20th of March
-- @block
SELECT
    AGE(TIMESTAMP '2024-03-20T00:00:00[Europe/Copenhagen]', TIMESTAMP '2024-01-13T00:00:00[Europe/Copenhagen]');


-- Q: What month of the year is TIMESTAMP '2024-03-20T00:00:00[Europe/Copenhagen]'
-- @block
SELECT
    EXTRACT(
        MONTH FROM AGE(TIMESTAMP '2024-03-20T00:00:00[Europe/Copenhagen]', TIMESTAMP '2024-01-13T00:00:00[Europe/Copenhagen]')
    );


-- Q: Trucate a date to the month
-- @block
SELECT
    DATE_TRUNC(MONTH, TIMESTAMP '2024-03-20T00:00:00[Europe/Copenhagen]');


-- Q: Trucate a date to the month
-- @block
SELECT
    DATE_TRUNC(MONTH, TIMESTAMP '2024-03-20T00:00:00[Europe/Copenhagen]');