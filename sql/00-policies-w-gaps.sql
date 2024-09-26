-- @conn xtdb
-- Given the following policies
-- @block
INSERT INTO InsurancePolicies (
    _id,
    PolicyHolderName,
    PolicyType,
    PolicyDetails,
    _valid_from,
    _valid_to,
    PremiumAmount,
    CoverageAmount
) VALUES
    ('POL123456', 'John Doe',      'Health', {dob: DATE '1980-01-01'}, DATE '2024-01-01', DATE '2025-01-01', 1200.50, 100000.00),
    ('POL123457', 'Jane Smith',    'Auto',   {dob: DATE '1985-02-02'}, DATE '2024-02-01', DATE '2025-02-01', 900.75,  50000.00),
    ('POL123458', 'Alice Johnson', 'Life',   {dob: DATE '1970-03-03'}, DATE '2024-03-01', DATE '2044-03-01', 1500.00, 200000.00),
    ('POL123459', 'Bob Brown',     'Home',   {dob: DATE '1990-04-04'}, DATE '2024-04-01', DATE '2025-04-01', 800.00,  150000.00),
    ('POL123460', 'Charlie Davis', 'Health', {dob: DATE '1982-05-05'}, DATE '2024-05-01', DATE '2025-05-01', 1100.25, 120000.00),
    ('POL123461', 'Diana Evans',   'Auto',   {dob: DATE '1988-06-06'}, DATE '2024-06-01', DATE '2025-06-01', 950.50,  60000.00),
    ('POL123462', 'Evan Foster',   'Life',   {dob: DATE '1975-07-07'}, DATE '2024-07-01', DATE '2044-07-01', 1600.75, 250000.00),
    ('POL123463', 'Fiona Green',   'Home',   {dob: DATE '1992-08-08'}, DATE '2024-08-01', DATE '2025-08-01', 850.00,  175000.00),
    ('POL123464', 'George Harris', 'Health', {dob: DATE '1978-09-09'}, DATE '2024-09-01', DATE '2025-09-01', 1150.00, 130000.00),
    ('POL123465', 'Hannah Jones',   'Auto',  {dob: DATE '1983-10-10'}, DATE '2024-10-01', DATE '2025-10-01', 1000.00, 70000.00);

-- Which policy has nearly expired? (next 6 months say)
-- @block
SELECT _id, _valid_to
FROM InsurancePolicies FOR VALID_TIME ALL
WHERE _valid_to - INTERVAL 'P6M' < CURRENT_DATE;

-- John Doe wants to buy insurance for 2025 now so that he doesn't have a period of no insurance
-- How would you insert this new policy?
-- @block
INSERT INTO InsurancePolicies (
    _id,
    PolicyHolderName,
    PolicyType,
    PolicyDetails,
    _valid_from,
    _valid_to,
    PremiumAmount,
    CoverageAmount
) VALUES
    ('TODO');

-- Answer:
-- @block
INSERT INTO InsurancePolicies (
    _id,
    PolicyHolderName,
    PolicyType,
    PolicyDetails,
    _valid_from,
    _valid_to,
    PremiumAmount,
    CoverageAmount
) VALUES
    ('POL123456', 'John Doe', 'Health', {dob: DATE '1980-01-01'}, DATE '2025-01-01', DATE '2026-01-01', 1200.50, 100000.00);

-- Some others decide to buy policies also:
-- @block
INSERT INTO InsurancePolicies (
    _id,
    PolicyHolderName,
    PolicyType,
    PolicyDetails,
    _valid_from,
    _valid_to,
    PremiumAmount,
    CoverageAmount
) VALUES
    ('POL123457', 'Jane Smith',    'Auto',   {dob: DATE '1985-02-02'}, DATE '2025-03-01', DATE '2026-02-01', 900.75,  50000.00),
    ('POL123458', 'Alice Johnson', 'Life',   {dob: DATE '1970-03-03'}, DATE '2044-03-01', DATE '2084-03-01', 1500.00, 200000.00),
    ('POL123459', 'Bob Brown',     'Home',   {dob: DATE '1990-04-04'}, DATE '2025-04-02', DATE '2026-04-01', 800.00,  150000.00),
    ('POL123460', 'Charlie Davis', 'Health', {dob: DATE '1982-05-05'}, DATE '2025-05-01', DATE '2027-04-01', 1100.25, 120000.00);

-- Write a query to list policies that have been renewed
-- @block
SELECT p.*
FROM InsurancePolicies FOR VALID_TIME ALL AS p
JOIN InsurancePolicies FOR VALID_TIME ALL AS p_before
    ON p._id = p_before._id
        AND p_before._valid_time PRECEDES p._valid_time
ORDER BY p._id;

-- When have gaps in their policy, and low long?
-- @block
SETTING DEFAULT VALID_TIME ALL
SELECT p._id, p._valid_from - p_before._valid_to
FROM InsurancePolicies AS p
JOIN InsurancePolicies AS p_before
    ON p._id = p_before._id
        AND p_before._valid_time PRECEDES p._valid_time
WHERE NOT p_before._valid_time IMMEDIATELY PRECEDES p._valid_time;