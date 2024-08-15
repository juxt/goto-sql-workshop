-- @conn postgres

-- @block Create a table
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    salary INTEGER
);

-- @block Insert sample data
INSERT INTO employees (name, department, salary) VALUES
    ('John Doe', 'IT', 75000),
    ('Jane Smith', 'HR', 65000),
    ('Bob Johnson', 'Finance', 80000),
    ('Alice Brown', 'Marketing', 70000),
    ('Charlie Davis', 'IT', 85000);

-- @block
DROP TABLE employees