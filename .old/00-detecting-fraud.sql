-- @conn xtdb
-- Bitemporal
-- In this example, we believed that charlie was a smoker.
-- We then found he was a smoker.
-- We did a historic update and then were able to reconcile this.

-- Let's say we have our Users table:
-- @block
INSERT INTO Users (_id, UserName, DateOfBirth, IsSmoker) VALUES
    (1, 'John Doe', DATE '1980-01-01', false),
    (2, 'Jane Smith', DATE '1985-02-02', true),
    (3, 'Alice Johnson', DATE '1970-03-03', false),
    (4, 'Bob Brown', DATE '1990-04-04', false),
    (5, 'Charlie Davis', DATE '1982-05-05', false),
    (6, 'Diana Evans', DATE '1988-06-06', false),
    (7, 'Evan Foster', DATE '1975-07-07', true),
    (8, 'Fiona Green', DATE '1992-08-08', true),
    (9, 'George Harris', DATE '1978-09-09', false),
    (10, 'Hannah Jones', DATE '1983-10-10', false);

-- And a table for claims:
-- @block
INSERT INTO Claims (
    _id,
    UserId,
    _valid_from, 
    ClaimAmount, 
    ClaimStatus, 
    Description
) VALUES 
    ('CLM123456', 1, DATE '2024-01-15', 5000.00, 'Pending', 'Car accident damage'), -- John Doe
    ('CLM123457', 1, DATE '2024-02-10', 2000.00, 'Approved', 'Windshield replacement'), -- John Doe
    ('CLM123458', 2, DATE '2024-02-20', 3000.00, 'Approved', 'Medical expenses'), -- Jane Smith
    ('CLM123459', 2, DATE '2024-03-05', 1500.00, 'Pending', 'Minor collision repair'), -- Jane Smith
    ('CLM123460', 5, DATE '2024-04-01', 2500.00, 'Approved', 'Dental surgery'), -- Charlie Davis
    ('CLM123461', 6, DATE '2024-04-10', 7000.00, 'Pending', 'Life insurance claim'), -- Diana Evans
    ('CLM123462', 8, DATE '2024-05-15', 4000.00, 'Denied', 'Roof repair due to storm damage'); -- Fiona Green

-- How might we go about detecting fraud?
-- There are many different kinds, but let's say we're specifically for cases when:
-- - Someone makes a claim
-- - Soon after they update their information
-- - This change would affect their cover/premium
-- - While we learned the information after the claim, the change was actually made before the claim

-- Let's simulate that so we have something to query for
-- Let's pick Charlie's claim:
-- @block
SELECT * FROM Claims WHERE Claims.UserId = 5;

-- He's already submitted the claim so now let's say he's actually picked up smoking and that would affect his dental claim
-- He picked it up in Febuary so let's update the database:
-- @block
-- INSERT INTO Users (
--   SELECT
--     * EXCLUDE IsSmoker,
--     true AS IsSmoker,
--     DATE '2024-02-01' AS _valid_from
--   FROM Users
--   WHERE _id = 5
-- );
INSERT INTO Users (_id, UserName, DateOfBirth, IsSmoker, _valid_from) VALUES
    (5, 'Charlie Davis', DATE '1982-05-05', true, DATE '2024-02-01');

-- What does our table say about Charlie's historic smoking status?
-- @block
SELECT UserName, IsSmoker, _valid_from
FROM Users
WHERE _id = 5
ORDER BY _valid_from;
-- Great, now our history for Charlie is correct

-- Let's check his Claims
-- @block
SELECT *, _valid_from
FROM Claims
WHERE UserId = 5;
-- Looks like Charlie was approved for Dental surgery, that doesn't sound right now we know he's a smoker...

-- So now, how can we detect that updates were made?
-- First let's try and see all the changes made to the Users table:
-- @block
SELECT UserName, IsSmoker, _valid_from, _valid_to
FROM Users FOR SYSTEM_TIME ALL
WHERE _id = 5
ORDER BY _valid_from;
-- There are two rows in system_time!
-- The valid_time's overlap though!

-- Let's take a look at the _system_time columns:
-- @block
SELECT UserName, IsSmoker, _valid_from, _system_from, _system_to
FROM Users FOR SYSTEM_TIME ALL
WHERE _id = 5
ORDER BY _valid_from;


-- Here we can see how the state of the world has changed over time
-- Question: Why did we have to use SYSTEM_TIME here instead of VALID_TIME?
-- Answer: We did a historic update to a fact in the database
--         This means that we overwrote the fact in VALID_TIME

-- Now, back to his claim
-- What did we know about Charlie when he made the claim?
-- @block
SELECT
  Users.*,
  Claims._valid_from AS claims_valid_from,
  Claims._valid_to   AS claims_valid_to, 
  Users._system_from  AS users_system_from,
  Users._system_to    AS users_system_to
FROM Users FOR SYSTEM_TIME ALL
JOIN Claims ON Claims.UserId = Users._id
WHERE Users._id = 5;

-- @block
SELECT Users._id, _valid_from, _valid_to
FROM Users FOR VALID_TIME ALL
WHERE Users._id = 5;

-- NOTE: Have a simple "function" which would approve or not approve a claim
--       Then we can run this on different versions of history

-- Why did we originally approve the claim?
-- @block
SELECT Users.*, Claims._id AS ClaimId, Users._system_from
FROM Users FOR SYSTEM_TIME ALL
JOIN Claims ON Claims.UserId = Users._id
WHERE
  Users._valid_from < Users._system_from
  AND Users._valid_from < Claims._valid_from;

-- Would we approve the claim now, knowing what we know now?
-- @block
SELECT Users.*, Claims._id AS ClaimId, Users._system_from
FROM Users FOR VALID_TIME ALL
JOIN Claims ON Claims.UserId = Users._id
WHERE
  Users._valid_from < Users._system_from
  AND Users._valid_from < Claims._valid_from;


-- @block
ERASE FROM Users;