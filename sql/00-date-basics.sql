-- @conn xtdb
-- Given the following data
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

-- Here's how you get the dob:
-- @block
SELECT _id, (PolicyDetails).dob
FROM InsurancePolicies
ORDER BY _id;

-- Here's how you extract the month from a date:
-- @block
SELECT _id, EXTRACT(MONTH FROM _valid_from)
FROM InsurancePolicies
ORDER BY _id;

-- Here's how you calcualte the interval between two dates:
-- @block
SELECT _id, AGE(_valid_to, _valid_from)
FROM InsurancePolicies
ORDER BY _id;

-- Challenge: Calculate the current age in years of each policy owner
-- @block
SELECT _id, 40 AS years_old
FROM InsurancePolicies
ORDER BY _id;

-- Answer:
-- @block
SELECT _id, EXTRACT(YEAR FROM AGE(CURRENT_DATE, (PolicyDetails).dob)) AS years_old
FROM InsurancePolicies
ORDER BY _id;