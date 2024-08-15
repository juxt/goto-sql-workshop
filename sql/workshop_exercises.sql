-- @conn postgres

-- @block
-- Exercise 1: Basic SELECT
-- Retrieve all employees from the IT department
SELECT * FROM employees WHERE department = 'IT';

-- @block
-- Exercise 2: Aggregation
-- Calculate the average salary for each department
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department;

-- @block
-- Exercise 3: Joins (assuming we add another table)
-- Create a departments table
CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    budget INTEGER
);

INSERT INTO departments (name, budget) VALUES
    ('IT', 500000),
    ('HR', 300000),
    ('Finance', 700000),
    ('Marketing', 400000);

-- @block
-- Join employees with departments to get department budgets
SELECT e.name, e.department, d.budget
FROM employees e
JOIN departments d ON e.department = d.name;

-- @block
-- Exercise 4: Subqueries
-- Find employees who earn more than the average salary
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
