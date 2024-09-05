-- @conn xtdb

-- Let's denormalise our Policies table and create a Users table:
-- @block
INSERT INTO Users (_id, UserName, DateOfBirth, _valid_from) VALUES
    (1, 'John Doe', DATE '1980-01-01', DATE '2024-01-01'),
    (2, 'Jane Smith', DATE '1985-02-02', DATE '2024-01-01'),
    (3, 'Alice Johnson', DATE '1970-03-03', DATE '2024-01-01'),
    (4, 'Bob Brown', DATE '1990-04-04', DATE '2024-01-01'),
    (5, 'Charlie Davis', DATE '1982-05-05', DATE '2024-01-01'),
    (6, 'Diana Evans', DATE '1988-06-06', DATE '2024-01-01'),
    (7, 'Evan Foster', DATE '1975-07-07', DATE '2024-01-01'),
    (8, 'Fiona Green', DATE '1992-08-08', DATE '2024-01-01'),
    (9, 'George Harris', DATE '1978-09-09', DATE '2024-01-01'),
    (10, 'Hannah Jones', DATE '1983-10-10', DATE '2024-01-01');

-- Our Policies table now looks like this:
-- @block
INSERT INTO Policies (
    _id, 
    UserId,
    PolicyType, 
    _valid_from, 
    _valid_to, 
    PremiumAmount, 
    CoverageAmount
) VALUES
    ('POL123456', 1, 'Health', DATE '2024-01-01', DATE '2025-01-01', 1200.50, 100000.00),
    ('POL123457', 2, 'Auto', DATE '2024-02-01', DATE '2025-02-01', 900.75, 50000.00),
    ('POL123458', 3, 'Life', DATE '2024-03-01', DATE '2044-03-01', 1500.00, 200000.00),
    ('POL123459', 4, 'Home', DATE '2024-04-01', DATE '2025-04-01', 800.00, 150000.00),
    ('POL123460', 5, 'Health', DATE '2024-05-01', DATE '2025-05-01', 1100.25, 120000.00),
    ('POL123461', 6, 'Auto', DATE '2024-06-01', DATE '2025-06-01', 950.50, 60000.00),
    ('POL123462', 7, 'Life', DATE '2024-07-01', DATE '2044-07-01', 1600.75, 250000.00),
    ('POL123463', 8, 'Home', DATE '2024-08-01', DATE '2025-08-01', 850.00, 175000.00),
    ('POL123464', 9, 'Health', DATE '2024-09-01', DATE '2025-09-01', 1150.00, 130000.00),
    ('POL123465', 10, 'Auto', DATE '2024-10-01', DATE '2025-10-01', 1000.00, 70000.00);

-- NOTE: this would be more interesing if it was something that would affect the premium
-- Now, let's say a user got married on the 20th May 2024, how would you update the user table?
-- @block
UPDATE Users FOR PORTION OF VALID_TIME FROM DATE '2024-05-20' TO NULL
SET UserName = 'Alice Williams'
WHERE _id = 3;

-- Now let's check that:
-- @block
SELECT *
FROM Users
ORDER BY _id;

-- How can we get a complete view of every time either table changed for each user?
-- Bonus: When was each of these changes valid?
-- Double Bonus: How would you extend this to join onto a third table? Say the Claims table?
-- @block
SETTING DEFAULT VALID_TIME ALL
SELECT Users.UserName, Policies.PolicyType--, Users._valid_time * Policies._valid_time
FROM Users
JOIN Policies
    ON Policies.UserId = Users._id
WHERE Users._valid_time OVERLAPS Policies._valid_time
ORDER BY Users._id

-- Double bonus answer:
-- @block
SETTING DEFAULT VALID_TIME ALL
SELECT Users.UserName, Policies.PolicyType--, Users._valid_time * Policies._valid_time * Claims._valid_time
FROM Users
JOIN Policies
    ON Policies.UserId = Users._id
JOIN Claims
    ON Claims.PolicyId = Policies._id
WHERE OVERLAPS(Users._valid_time, Policies._valid_time, Claims._valid_time)
ORDER BY Users._id
