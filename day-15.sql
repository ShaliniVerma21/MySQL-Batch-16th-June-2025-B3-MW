use zoom;

-- Window Functions
/*
Definition:
Window functions are a type of SQL function that perform calculations across a set of table rows
that are somehow related to the current row. Unlike regular aggregate functions, which return a single
value for a group of rows, window functions return a value for each row in the result set.

Key Characteristics:
1. They do not collapse rows; each row retains its identity.
2. They are often used for running totals, moving averages, ranking, and other calculations
that require access to multiple rows.

Types of Window Functions :
1. Aggregate Functions: These functions perform calculations across a set of rows and return a single value.
Examples include SUM(), AVG(), COUNT(), etc.

2. Ranking Functions: These functions assign a rank to each row within a partition of a result set.
Examples include ROW_NUMBER(), RANK(), and DENSE_RANK().

3. Value Functions: These functions return a value from a specific row in the result set.
Examples include LEAD(), LAG(), FIRST_VALUE(), and LAST_VALUE().

4. Analytic Functions: These functions perform calculations across a set of rows related to the current row,
similar to aggregate functions but without collapsing the result set. Examples include NTILE().

The general syntax for a window function is as follows:
function_name(column_name) OVER (
    [PARTITION BY partition_expression]
    [ORDER BY order_expression]
    [ROWS or RANGE frame_specification]
)

Note ---
Window functions are powerful tools in SQL that enable advanced data analysis without losing
the context of individual rows. They are particularly useful in reporting and analytical queries.

*/

-- Step 1: Create the emp11 Table
CREATE TABLE emp11 (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Step 2: Insert 10 Records into emp11
INSERT INTO emp11 (employee_name, department, salary) VALUES
('Alice Johnson', 'HR', 60000.00),
('Bob Smith', 'IT', 75000.00),
('Charlie Brown', 'IT', 80000.00),
('David Wilson', 'Finance', 70000.00),
('Eva Green', 'HR', 65000.00),
('Frank White', 'Finance', 72000.00),
('Grace Lee', 'IT', 78000.00),
('Hannah Scott', 'Marketing', 50000.00),
('Ian Black', 'Marketing', 52000.00),
('Jack Brown', 'Finance', 71000.00);

select * from emp11;

-- Step 3: Write Queries Using Window Functions

-- Example 1: Using ROW_NUMBER()
-- Assign a unique sequential integer to each row within a partition of a result set.
SELECT
    employee_id,
    employee_name,
    department,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS ranks
FROM
    emp11;

-- Example 2: Using RANK()
-- Ranks employees within each department based on their salary. 
-- If two employees have the same salary, they receive the same rank, and the next rank is skipped.
SELECT
    employee_id,
    employee_name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM
    emp11;
   
-- Example 3: Using DENSE_RANK()
-- Similar to RANK(), but without gaps in the ranking.
SELECT
    employee_id,
    employee_name,
    department,
    salary,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_salary_rank
FROM
    emp11;
   
-- Example 4: Using LAG()
-- Get the salary of the previous employee in the same department.
SELECT
    employee_id,
    employee_name,
     department,
    salary,
    LAG(salary, 1) OVER (PARTITION BY department ORDER BY salary) AS previous_salary
FROM
    emp11;
   
-- Example 5: Using LEAD()
-- Get the salary of the next employee in the same department.
SELECT
    employee_id,
    employee_name,
     department,
    salary,
    LEAD(salary, 1) OVER (PARTITION BY department ORDER BY salary) AS next_salary
FROM
    emp11;
   
-- Example 6: Using SUM()
-- Calculate a running total of salaries within each department.
SELECT
    employee_id,
    employee_name,
     department,
    salary,
    SUM(salary) OVER (PARTITION BY department ORDER BY employee_id) AS running_total
FROM
    emp11;
   
-- Example 7: Using AVG()
-- Calculate the average salary within each department.
SELECT
    employee_id,
    employee_name,
     department,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS average_salary
FROM
    emp11;
   
-- Example 8: Using NTILE()
-- Divide employees into quartiles based on their salary.
SELECT
    employee_id,
    employee_name,
     department,
    salary,
    NTILE(4) OVER (ORDER BY salary) AS salary_quartile
FROM
    emp11;
   
-- Example 9: Using FIRST_VALUE()
-- Retrieve the first salary in each department.
SELECT
    employee_id,
    employee_name,
    department,
    salary,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary) AS first_salary
FROM
    emp11;
   
-- Example 10: Using LAST_VALUE()
-- Retrieve the last salary in each department.
SELECT
    employee_id,
    employee_name,
    department,
    salary,
    LAST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary
                              ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_salary
FROM
    emp11;
   
-- Example 11: Using SUM() with a Frame Specification
-- Calculate a moving average of salaries over the last 3 employees in each department.
SELECT
    employee_id,
    employee_name,
    department,
    salary,
    AVG(salary) OVER (PARTITION BY department ORDER BY employee_id
                      ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM
    emp11;
   
-- Example 12: Using COUNT() for Cumulative Count
-- Count the number of employees in each department cumulatively.
SELECT
    employee_id,
    employee_name,
    department,
    COUNT(employee_id) OVER (PARTITION BY department ORDER BY employee_id
                              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_count
FROM
    emp11;


-- types of cascades in mysql

-- ER-Diagram


-- ------------------------ More Examples to understand DCL Properly -----------------------

-- Table Setup

-- Step 1: Create the Employee1 table
CREATE TABLE Employee1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments1(id)
);

-- Step 2: Create the Departments1 table
CREATE TABLE Departments1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Step 3: Create the Project1 table
CREATE TABLE Project1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    budget DECIMAL(10, 2) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments1(id)
);

-- Step 4: Create the Event1 table
CREATE TABLE Event1 (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- Step 5: Create the Clients table
CREATE TABLE Clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(100) NOT NULL
);

-- Step 6: Insert Sample Data into Departments1 Table
INSERT INTO Departments1 (name) VALUES
('Finance'),
('Sales'),
('IT'),
('Customer Support'),
('Legal');

-- Step 7: Insert Sample Data into Employee1 Table
INSERT INTO Employee1 (name, position, salary, department_id) VALUES
('Rajesh Kumar', 'Finance Manager', 90000.00, 1),
('Sneha Patel', 'Sales Executive', 50000.00, 2),
('Amit Sharma', 'Software Engineer', 75000.00, 3),
('Neha Singh', 'Customer Support Specialist', 40000.00, 4),
('Vikram Mehta', 'Legal Advisor', 85000.00, 5),
('Ravi Verma', 'Sales Manager', 95000.00, 2),
('Pooja Rani', 'HR Executive', 45000.00, 1),
('Karan Bhatia', 'IT Support', 55000.00, 3),
('Deepika Joshi', 'Marketing Manager', 70000.00, 3),
('Suresh Nair', 'Finance Analyst', 60000.00, 1);

-- Step 8: Insert Sample Data into Project1 Table
INSERT INTO Project1 (name, budget, department_id) VALUES
('Project C', 150000.00, 3),  -- IT
('Project D', 200000.00, 1),  -- Finance
('Project E', 75000.00, 2);    -- Sales

-- Step 9: Insert Sample Data into Event1 Table
INSERT INTO Event1 (name, date, location) VALUES
('Quarterly Review', '2023-10-15', 'Conference Room B'),
('Diwali Celebration', '2023-11-12', 'Rooftop Garden'),
('Annual Picnic', '2023-12-20', 'City Park');

-- Step 10: Insert Sample Data into Clients Table
INSERT INTO Clients (name, contact_info) VALUES
('Client A', 'clientA@company.com'),
('Client B', 'clientB@company.com'),
('Client C', 'clientC@company.com'),
('Client D', 'clientD@company.com'),
('Client E', 'clientE@company.com');

-- Example 1: Granting Permissions to Users

-- Step 1: Create new users
CREATE USER 'hr_user'@'localhost' IDENTIFIED BY 'hr_pass';
CREATE USER 'dev_user'@'localhost' IDENTIFIED BY 'dev_pass';
CREATE USER 'marketing_user'@'localhost' IDENTIFIED BY 'marketing_pass';
CREATE USER 'client_user'@'localhost' IDENTIFIED BY 'client_pass';

-- Step 2: Grant Permissions
GRANT SELECT, INSERT, UPDATE, DELETE ON Employee1 TO 'hr_user'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON Departments1 TO 'hr_user'@'localhost';

GRANT SELECT, INSERT, UPDATE ON Project1 TO 'dev_user'@'localhost';

GRANT SELECT ON Employee1 TO 'dev_user'@'localhost';

GRANT SELECT, INSERT ON Event1 TO 'marketing_user'@'localhost';

GRANT SELECT ON Clients TO 'marketing_user'@'localhost';

GRANT SELECT ON Clients TO 'client_user'@'localhost';

-- Step 3: Verify Permissions
SHOW GRANTS FOR 'hr_user'@'localhost';
SHOW GRANTS FOR 'dev_user'@'localhost';
SHOW GRANTS FOR 'marketing_user'@'localhost';
SHOW GRANTS FOR 'client_user'@'localhost';

-- Example 2: Using Roles for Group Permissions

-- Step 1: Create Roles
CREATE ROLE 'HR_role';
CREATE ROLE 'Dev_role';
CREATE ROLE 'Marketing_role';

-- Step 2: Grant Permissions to Roles
GRANT SELECT, INSERT, UPDATE, DELETE ON Employee1 TO 'HR_role';
GRANT SELECT, INSERT, UPDATE ON Project1 TO 'Dev_role';
GRANT SELECT, INSERT ON Event1 TO 'Marketing_role';

-- Step 3: Assign Roles to Users
GRANT 'HR_role' TO 'hr_user'@'localhost';
GRANT 'Dev_role' TO 'dev_user'@'localhost';
GRANT 'Marketing_role' TO 'marketing_user'@'localhost';

-- Step 4: Verify Role Grants
SHOW GRANTS FOR 'hr_user'@'localhost';
SHOW GRANTS FOR 'dev_user'@'localhost';
SHOW GRANTS FOR 'marketing_user'@'localhost';


-- Example 3: Revoking All Permissions
-- Step 1: Revoke All Permissions from a User
REVOKE ALL PRIVILEGES ON Clients FROM 'client_user'@'localhost';

-- Step 2: Verify Revoked Permissions
SHOW GRANTS FOR 'client_user'@'localhost';


-- Example 4: Granting Permissions with Conditions

-- Hypothetical syntax for granting permissions with conditions (not supported in MySQL)
GRANT SELECT ON Employee1 TO 'hr_user'@'localhost' WHERE department_id = 1;


-- Example 5: Dropping Roles and Users

-- Step 1: Drop Roles
DROP ROLE 'HR_role';
DROP ROLE 'Dev_role';
DROP ROLE 'Marketing_role';

-- Step 2: Drop Users
DROP USER 'hr_user'@'localhost';
DROP USER 'dev_user'@'localhost';
DROP USER 'marketing_user'@'localhost';
DROP USER 'client_user'@'localhost';


-- Example 6: Creating Views for Restricted Access

-- Create a view for HR to see employee details without salary
CREATE VIEW EmployeeView AS SELECT id, name, position, department_id FROM Employee1;

-- Grant HR user access to the view
GRANT SELECT ON EmployeeView TO 'hr_user'@'localhost';


-- Example 7: Granting Permissions on Multiple Tables

-- Grant SELECT permission on multiple tables to the developer user
GRANT SELECT ON Employee1 TO 'dev_user'@'localhost';
GRANT SELECT ON Project1 TO 'dev_user'@'localhost';
GRANT SELECT ON Event1 TO 'dev_user'@'localhost';


-- Example 8: Revoking Permissions from Multiple Tables

-- Revoke SELECT permission from the developer user on the Event1 table
REVOKE SELECT ON Event1 FROM 'dev_user'@'localhost';


-- Example 9: Granting Permissions to a Group of Users

-- Create a new user for the marketing team
CREATE USER 'marketing_team_user'@'localhost' IDENTIFIED BY 'team_pass';

-- Grant the same permissions as the marketing user to the marketing team user
GRANT SELECT, INSERT ON Event1 TO 'marketing_team_user'@'localhost';
GRANT SELECT ON Clients TO 'marketing_team_user'@'localhost';


-- Example 10: Checking User Privileges

-- Check all privileges for a specific user
SHOW GRANTS FOR 'marketing_team_user'@'localhost';


-- Example 11: Using Stored Procedures for Permission Management

-- Create a stored procedure to grant permissions
DELIMITER //
CREATE PROCEDURE GrantPermissions(IN username VARCHAR(100))
BEGIN
    SET @sql = CONCAT('GRANT SELECT ON Employee1 TO ', username, '@'localhost'');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END
// DELIMITER ;

-- Call the stored procedure to grant permissions
CALL GrantPermissions('dev_user');


-- Example 12: Auditing Permissions

-- Create a table to log permission changes
CREATE TABLE PermissionAudit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    action VARCHAR(100), table_name VARCHAR(100),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Example of logging a permission change
INSERT INTO PermissionAudit (username, action, table_name) VALUES ('hr_user', 'GRANT', 'Employee1');


-- Example 13: Revoking All Permissions from a Role

-- Revoke all permissions from the marketing role
REVOKE ALL PRIVILEGES ON Event1 FROM 'Marketing_role';


-- Example 14: Granting Permissions with Time Constraints (Hypothetical)

-- Grant SELECT permission with a condition (hypothetical)
GRANT SELECT ON Employee1 TO 'hr_user'@'localhost' WHERE department_id = 1;


-- Example 16: Creating a Role Hierarchy

-- Step 1: Create Roles
CREATE ROLE 'Manager_role';
CREATE ROLE 'Employee_role';

-- Step 2: Grant Permissions to Roles
GRANT SELECT, INSERT, UPDATE ON Employee1 TO 'Employee_role';
GRANT SELECT, INSERT, UPDATE, DELETE ON Departments1 TO 'Manager_role';
GRANT 'Employee_role' TO 'Manager_role';  -- Manager inherits Employee permissions

-- Step 3: Assign Roles to Users
CREATE USER 'manager_user'@'localhost' IDENTIFIED BY 'manager_pass';
CREATE USER 'employee_user'@'localhost' IDENTIFIED BY 'employee_pass';

GRANT 'Manager_role' TO 'manager_user'@'localhost';
GRANT 'Employee_role' TO 'employee_user'@'localhost';

-- Step 4: Verify Role Grants
SHOW GRANTS FOR 'manager_user'@'localhost';
SHOW GRANTS FOR 'employee_user'@'localhost';


-- Example 17: Revoking Specific Permissions

-- Step 1: Revoke INSERT permission from the HR user
REVOKE INSERT ON Employee1 FROM 'hr_user'@'localhost';

-- Step 2: Verify Permissions
SHOW GRANTS FOR 'hr_user'@'localhost';
