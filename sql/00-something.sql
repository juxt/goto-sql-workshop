-- @conn xtdb
-- We have a bunch of data where in one case

-- We have a repeating policy:
-- @block
INSERT INTO Policies (
    _id, 
    UserId,
    PolicyType, 
    _valid_from, 
    _valid_to
) VALUES
    ('POL123456', 1, 'Health', DATE '2019-01-01', DATE '2020-01-01'),
    ('POL123456', 1, 'Health', DATE '2020-01-01', DATE '2021-01-01'),
    ('POL123456', 1, 'Health', DATE '2021-02-01', DATE '2022-01-01'), -- NOTE: There's a gap here as the user renewed it late
    ('POL123456', 1, 'Health', DATE '2022-01-01', DATE '2023-01-01'),
    ('POL123456', 1, 'Health', DATE '2023-01-01', DATE '2024-01-01'),
    ('POL123456', 1, 'Health', DATE '2024-01-01', DATE '2025-01-01');

-- Let's check for gaps:
-- @block
SELECT p._id, _valid_from, _valid_to
FROM Policies FOR VALID_TIME ALL AS p
WHERE EXISTS(
    SELECT 1
    FROM Policies FOR VALID_TIME ALL AS p_before
    WHERE p_before._id = p._id
        AND p_before._valid_time IMMEDIATELY PRECEDES p._valid_time
        OR NOT p_before._valid_time PRECEDES p._valid_time
)
ORDER BY _valid_from;

-- @block
WITH data AS (
    SELECT _id, MIN(_valid_from) AS _valid_from, MAX(_valid_to) AS _valid_to
    FROM Policies FOR VALID_TIME ALL AS p
    GROUP BY _id
)
SELECT 

-- Later, for some reason the timeline is changed **incorrectly**
-- @block
INSERT INTO Policies (
    _id, 
    UserId,
    PolicyType, 
    _valid_from, 
    _valid_to
) VALUES
    ('POL123456', 1, 'Health', DATE '2021-01-01', DATE '2022-01-01');

-- @block
SELECT p._id, _valid_from
FROM Policies FOR VALID_TIME ALL AS p
WHERE NOT EXISTS(
    SELECT 1
    FROM Policies FOR VALID_TIME ALL AS p_before
    WHERE p_before._id = p._id
        AND p_before._valid_time IMMEDIATELY PRECEDES p._valid_time
        OR NOT p_before._valid_time PRECEDES p._valid_time
)
ORDER BY _valid_from;

-- @block
SETTING DEFAULT SYSTEM_TIME AS OF TIMESTAMP '2024-09-11 15:07:34.374292+00:00'
SELECT p._id, _valid_from
FROM Policies FOR VALID_TIME ALL AS p
WHERE NOT EXISTS(
    SELECT 1
    FROM Policies FOR VALID_TIME ALL AS p_before
    WHERE p_before._valid_time IMMEDIATELY PRECEDES p._valid_time
        OR NOT p_before._valid_time PRECEDES p._valid_time
)
ORDER BY _valid_from;


-- @block
SELECT p._id, _valid_from, _system_from
FROM Policies FOR VALID_TIME ALL AS p

-- @block
ERASE FROM policies