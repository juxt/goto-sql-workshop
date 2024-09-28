-- @conn xtdb

-- Exercise 1: Basic SELECT
-- Retrieve all employees from the IT department
-- @block
SELECT * FROM employees;

-- Exercise 2: Aggregation
-- Calculate the average salary for each department
-- @block
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department;

-- Exercise 3: Joins (assuming we add another table)
-- Create a departments table
-- @block
INSERT INTO departments (_id, name, budget) VALUES
    (1, 'IT', 500000),
    (2, 'HR', 300000),
    (3, 'Finance', 700000),
    (4, 'Marketing', 400000);

-- Join employees with departments to get department budgets
-- @block
SELECT e.name, e.department, d.budget
FROM employees e
JOIN departments d ON e.department = d.name;

-- Exercise 4: Subqueries
-- Find employees who earn more than the average salary
-- @block
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
