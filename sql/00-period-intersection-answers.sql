-- Question 1.
-- NOTE: this would be more interesing if it was something that would affect the premium
-- @block 
INSERT INTO Users
SELECT * EXCLUDE UserName, 'Alice Williams' AS UserName, DATE '2024-05-20' AS _valid_from  FROM Users
WHERE UserName = 'Alice Johnson'


-- How can we get a complete view of every time the Users table changed?
-- @block
SELECT *, _valid_from
FROM Users FOR VALID_TIME ALL
ORDER BY _id;

-- How can we get a complete view of every time either table changed for each user?
-- @block
SETTING DEFAULT VALID_TIME ALL
SELECT Users._id, Users.UserName, Policies.PolicyType
FROM Users
JOIN Policies ON Policies.UserId = Users._id
WHERE Users._valid_time OVERLAPS Policies._valid_time
ORDER BY Users._id;

-- Bonus: When was each of these changes valid?
-- @block
SETTING DEFAULT VALID_TIME ALL
SELECT Users.UserName, Policies.PolicyType--, Users._valid_time * Policies._valid_time
FROM Users
JOIN Policies
    ON Policies.UserId = Users._id
WHERE Users._valid_time OVERLAPS Policies._valid_time
ORDER BY Users._id;

-- Double Bonus: How would you extend this to join onto a third table? Say the Claims table?
-- @block
SETTING DEFAULT VALID_TIME ALL
SELECT Users.UserName, Policies.PolicyType--, Users._valid_time * Policies._valid_time * Claims._valid_time
FROM Users
JOIN Policies
    ON Policies.UserId = Users._id
JOIN Claims
    ON Claims.PolicyId = Policies._id
WHERE OVERLAPS(Users._valid_time, Policies._valid_time, Claims._valid_time)
ORDER BY Users._id;
