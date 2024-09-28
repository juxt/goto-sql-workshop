-- @conn xtdb

-- 👇 Run this first
-- @block
INSERT INTO policies_01 (_id, policy_holder_name, policy_type, premium_amount) VALUES
(1,  'John Doe',      'Health', 1200),
(2,  'Fiona Green',   'Life',   100),
(3,  'Alice Johnson', 'Health', 1500),
(4,  'Bob Brown',     'Home',   250),
(5,  'Evan Foster',   'Health', 1100),
(6,  'Alice Johnson', 'Auto',   560),
(7,  'Evan Foster',   'Auto',   890),
(8,  'Fiona Green',   'Home',   300),
(9,  'George Harris', 'Health', 1300),
(10, 'George Harris', 'Life',   130);

-- Q1. Add a record for 'Bob Brown's health insurance
-- @block
INSERT ...;


-- Q2. Query for all the policies
-- @block
SELECT ...;


-- Q3. Delete the record for 'Fiona Green's home insurance
-- @block
DELETE ...;


-- Q4. Query for all health policies
-- @block
SELECT ...;


-- Q5. How many Health policies are there?
-- @block
SELECT ...;


-- Q6. How many policies does 'Alice Johnson' have?
-- @block
SELECT ...;


-- Q7. Which policy type has the most policies?
-- @block
SELECT ...;


-- Q8. Who has the most policies?
-- @block
SELECT ...;


-- Q9. Presuming no claims, which policy type is the most profitable?
-- @block
SELECT ...;


-- Q10. What's the average premium amount for all policies?
-- @block
SELECT ...;


-- 👇 Run this
-- @block
INSERT INTO policies_types_01 (_id, max_premium_amount) VALUES
('Health', 2000),
('Life',   500),
('Home',   1000),
('Auto',   1000),
('Travel', 50);


-- Q11. Join the two tables together
-- @block
SELECT ...;


-- Q12. Given the max_premium_amount, what is the amount of premium we're "missing out on"?
-- @block
SELECT ...;