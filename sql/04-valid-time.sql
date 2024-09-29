-- @conn xtdb

-- 👇 Run this first
-- @block
INSERT INTO users (_id, address, phone_number, email) VALUES
('John Doe',      '123 Evergreen Row', '555-1234', 'john.doe@example.com'),
('Fiona Green',   '456 Maple Street',  '555-5678', 'fiona.green@example.com'),
('Alice Johnson', '789 Oak Avenue',    '555-8765', 'alice.johnson@example.com'),
('Bob Brown',     '101 Pine Road',     '555-4321', 'bob.brown@example.com'),
('Evan Foster',   '202 Birch Lane',    '555-6789', 'evan.foster@example.com'),
('George Harris', '303 Cedar Drive',   '555-9876', 'george.harris@example.com');

-- Q: Fiona has changed her phone number to '666-8683', update the table:
-- @block
UPDATE ...;

-- Q: Write a query to show how her phone number has changed over time and when in valid time
-- @block
SELECT ...;

-- Q: A user joined us a year ago, insert them into the database from when they joined in valid time with the details:
-- Name: 'Tony Felonius', email `tony.felonius@example.com`, phone number `666-1111` and the address '404 Elm Street'
-- @block
INSERT ...;

-- Q: Later they tell us that they were actually lived at the address '1234 Maple Lane' since 3 months ago, update the database
-- @block
UPDATE ...;

-- Q: 'Alice Johnson' has told us that her address is going to change in 3 months to '5678 Oakwood Avenue', update the database in the future
-- @block
UPDATE ...;