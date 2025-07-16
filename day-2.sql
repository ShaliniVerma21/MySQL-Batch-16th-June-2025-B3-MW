-- FOREIGN KEY PRACTICE – COMPANY DATABASE

-- ------------------------------------Database Queries ---------------------------------------------

-- 1. Create the database only if it doesn't already exist
CREATE DATABASE IF NOT EXISTS company;

-- 2. Use the company database (switch to it)
USE company;

-- 3. Drop the database only if it exists (use carefully – this deletes all tables and data)
DROP DATABASE IF EXISTS company;

-- -------------------------------------- Foreign Key -------------------------------------------------------------

/*
What is a Foreign Key in SQL?

--> A Foreign Key is a column (or a set of columns) in one table that refers to the Primary Key in another table.
--> It helps establish a parent-child relationship between tables.

It creates a relationship between two tables like:
Employee.department_id → Department.department_id

--> A foreign key ensures that the value in the referencing column must exist in the referenced table's primary key.
--> It is used to enforce referential integrity in the database.

Why Use Foreign Keys?

--> To logically connect related data across multiple tables.
--> To avoid data redundancy and maintain normalized database design.
--> To maintain data accuracy and consistency through relationships.
--> To restrict invalid data entries (e.g., preventing a student being assigned to a non-existent class).

Key Properties of Foreign Key:

--> A foreign key refers to a primary key (or unique key) in another table.
--> Multiple foreign keys can exist in a table.
--> The referencing column can accept NULL values (unless explicitly marked NOT NULL).
--> Prevents insertion of invalid values (i.e., values not present in the parent table).
--> Can use ON DELETE or ON UPDATE rules like CASCADE, SET NULL, RESTRICT, etc.
--> Helps implement one-to-many and many-to-one relationships.

Real-World Example – Company Database Relationships:

| Child Table | Foreign Key                | Parent Table |
| ----------- | -------------------------- | ------------ |
| Employees   | department_id              | → Departments|
| Projects    | client_id                  | → Clients    |
| Tasks       | employee_id                | → Employees  |
| Salaries    | employee_id                | → Employees  |
| Attendance  | employee_id                | → Employees  |
| Leaves      | employee_id                | → Employees  |
| Employees   | manager_id                 | → Managers   |
| Assets      | assigned_to (employee_id)  | → Employees  |
-----------------------------------------------------------

Conclusion:

--> Foreign Keys are essential to maintain structured, connected, and meaningful relational data.
--> They make the database more reliable by enforcing valid references between records.

*/

-- 1. Departments

CREATE TABLE Departments (
  department_id INT PRIMARY KEY,
  dept_name VARCHAR(50) NOT NULL UNIQUE,
  location VARCHAR(50) NOT NULL,
  head VARCHAR(50) NOT NULL,
  established_year INT CHECK(established_year >= 2000)
);

INSERT INTO Departments VALUES
(1, 'HR', 'Delhi', 'Ritika', 2015),
(2, 'Finance', 'Mumbai', 'Manish', 2012),
(3, 'IT', 'Bangalore', 'Amit', 2018),
(4, 'Sales', 'Chennai', 'Divya', 2017),
(5, 'Marketing', 'Kolkata', 'Rohan', 2016);

SELECT * FROM Departments;

-- 2. Managers
CREATE TABLE Managers (
  manager_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  experience INT CHECK(experience > 0),
  salary INT CHECK(salary >= 50000),
  contact VARCHAR(15) UNIQUE NOT NULL
);

INSERT INTO Managers VALUES
(9001, 'Ritika', 10, 90000, '9876543210'),
(9002, 'Manish', 12, 95000, '9812345678'),
(9003, 'Amit', 8, 85000, '9765432101'),
(9004, 'Divya', 9, 88000, '9900112233'),
(9005, 'Rohan', 7, 82000, '9123456789');

SELECT * FROM Managers;

-- 3. Employees

CREATE TABLE Employees (
  employee_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  department_id INT NOT NULL,
  manager_id INT,
  position VARCHAR(50) NOT NULL,
  FOREIGN KEY (department_id) REFERENCES Departments(department_id),
  FOREIGN KEY (manager_id) REFERENCES Managers(manager_id)
);

INSERT INTO Employees VALUES
(101, 'Shalini', 1, 9001, 'HR Executive'),
(102, 'Rahul', 2, 9002, 'Accountant'),
(103, 'Trisha', 3, 9003, 'Developer'),
(104, 'Kavita', 4, 9004, 'Sales Executive'),
(105, 'Jay', 5, 9005, 'Marketing Analyst');

SELECT * FROM Employees;

-- 4. Clients

CREATE TABLE Clients (
  client_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  company VARCHAR(50) NOT NULL,
  contact VARCHAR(15) UNIQUE NOT NULL,
  email VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO Clients VALUES
(601, 'Mr. Roy', 'Tata', '9876543211', 'roy@tata.com'),
(602, 'Ms. Nisha', 'Infosys', '9876543212', 'nisha@infosys.com'),
(603, 'Mr. Khan', 'Reliance', '9876543213', 'khan@reliance.com'),
(604, 'Mr. Mehta', 'HCL', '9876543214', 'mehta@hcl.com'),
(605, 'Ms. Sharma', 'IBM', '9876543215', 'sharma@ibm.com');

SELECT * FROM Clients;

--  5. Projects

CREATE TABLE Projects (
  project_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  client_id INT NOT NULL,
  budget INT CHECK(budget > 100000),
  start_date DATE,
  FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

INSERT INTO Projects VALUES
(501, 'ERP System', 601, 500000, '2025-06-01'),
(502, 'CRM App', 602, 400000, '2025-06-10'),
(503, 'E-Commerce', 603, 450000, '2025-06-15'),
(504, 'Payroll System', 604, 300000, '2025-06-20'),
(505, 'HR Portal', 605, 250000, '2025-06-25');

SELECT * FROM Projects;

-- 6. Salaries

CREATE TABLE Salaries (
  salary_id INT PRIMARY KEY,
  employee_id INT NOT NULL UNIQUE,
  basic INT CHECK(basic >= 25000),
  hra INT,
  bonus INT,
  FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Salaries VALUES
(201, 101, 30000, 5000, 2000),
(202, 102, 35000, 6000, 2500),
(203, 103, 40000, 7000, 3000),
(204, 104, 28000, 4500, 1500),
(205, 105, 32000, 4800, 1800);

SELECT * FROM Salaries;

-- 7. Attendance

CREATE TABLE Attendance (
  attendance_id INT PRIMARY KEY,
  employee_id INT NOT NULL,
  date DATE,
  status VARCHAR(10) CHECK(status IN ('Present', 'Absent', 'Leave')),
  shift VARCHAR(10),
  FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Attendance VALUES
(301, 101, '2025-07-15', 'Present', 'Day'),
(302, 102, '2025-07-15', 'Absent', 'Night'),
(303, 103, '2025-07-15', 'Present', 'Day'),
(304, 104, '2025-07-15', 'Present', 'Day'),
(305, 105, '2025-07-15', 'Leave', 'Night');

SELECT * FROM Attendance;

--  8. Leaves

CREATE TABLE Leaves (
  leave_id INT PRIMARY KEY,
  employee_id INT NOT NULL,
  from_date DATE,
  to_date DATE,
  reason VARCHAR(50),
  FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Leaves VALUES
(401, 101, '2025-07-01', '2025-07-03', 'Personal'),
(402, 102, '2025-07-05', '2025-07-07', 'Medical'),
(403, 103, '2025-07-10', '2025-07-11', 'Family Function'),
(404, 104, '2025-07-12', '2025-07-13', 'Emergency'),
(405, 105, '2025-07-14', '2025-07-14', 'One-day leave');

SELECT * FROM Leaves;


-- 9. Tasks

CREATE TABLE Tasks (
  task_id INT PRIMARY KEY,
  employee_id INT NOT NULL,
  task_name VARCHAR(50) NOT NULL,
  status VARCHAR(20) DEFAULT 'Pending',
  deadline DATE,
  FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Tasks VALUES
(701, 101, 'Resume Shortlisting', 'Completed', '2025-07-10'),
(702, 102, 'Invoice Checking', 'In Progress', '2025-07-20'),
(703, 103, 'API Development', 'Pending', '2025-07-25'),
(704, 104, 'Sales Pitch', 'Completed', '2025-07-12'),
(705, 105, 'Ad Campaign Plan', 'In Progress', '2025-07-18');

SELECT * FROM Tasks;

-- 10. Assets

CREATE TABLE Assets (
  asset_id INT PRIMARY KEY,
  asset_name VARCHAR(50) NOT NULL,
  assigned_to INT,
  status VARCHAR(20) CHECK(status IN ('Working', 'Damaged', 'Under Repair')),
  issue_date DATE,
  FOREIGN KEY (assigned_to) REFERENCES Employees(employee_id)
);

INSERT INTO Assets VALUES
(801, 'Laptop', 101, 'Working', '2025-07-01'),
(802, 'Mobile', 102, 'Damaged', '2025-06-28'),
(803, 'Headset', 103, 'Working', '2025-07-05'),
(804, 'Projector', 104, 'Under Repair', '2025-07-03'),
(805, 'Tablet', 105, 'Working', '2025-07-07');

SELECT * FROM Assets;
