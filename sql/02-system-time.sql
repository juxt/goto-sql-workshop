-- @conn

-- Q: Run this, what do you see?
-- @block
SELECT *, _system_from
FROM policies_01;


-- Q: Insert some more rows into policies
-- @block
INSERT ...;


-- Q: How has the _system_from changed?
-- @block
SELECT ...;


-- Q: Try out this query
-- @block
SELECT *, _system_from
FROM policies_01 FOR SYSTEM_TIME ALL;


-- 👇 Run this
-- @block
INSERT INTO test_02 (_id, my_value)
VALUES
(1, 'foo');


-- Q: What will this return?
-- @block
SELECT *, _system_from
FROM test_02 FOR SYSTEM_TIME ALL;


-- 👇 Run this
-- @block
UPDATE test_02
SET my_value = 'bar'
WHERE _id = 1;


-- Q: What will this return?
-- @block
SELECT *, _system_from
FROM test_02 FOR SYSTEM_TIME ALL;


-- Q: How can we tell which row is the current value?
-- The lastest _system_from
-- The one returned by FOR SYSTEM_TIME AS OF NOW


-- Q: What will this return?
-- @block
SELECT *, _system_from, _system_to
FROM test_02 FOR SYSTEM_TIME ALL;



-- Q: Write a query to show what `test_02` looked like 5 minutes ago
-- @block
SELECT ...;


-- Q: Write a query to show all changes made today in the `policies_01` table
-- @block
SELECT ...;


-- Q: What do you think this returns:
-- @block
SELECT *, _system_time
FROM test_02 FOR SYSTEM_TIME ALL;