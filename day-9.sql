
create database zoom;
use zoom;

-- Userdefined Functions
/*
User -defined functions (UDFs) in MySQL allow you to create your own functions
that can be used in SQL statements, just like built-in functions. UDFs can encapsulate
complex logic, perform calculations, or manipulate data, making your SQL queries
cleaner and more efficient.

To create a user-defined function in MySQL, you use the CREATE FUNCTION statement.

Syntax :

DELIMITER //
CREATE FUNCTION function_name (parameters)
RETURNS return_data_type
DETERMINISTIC
BEGIN
    -- Function logic goes here
    RETURN value;
END
//DELIMITER ;

DELIMITER //:
Changes the statement delimiter to // so that MySQL can recognize the 
end of the function definition.
*/

-- This function adds two integers and returns the sum.
DELIMITER //
CREATE FUNCTION add_numbers(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a + b;
END //

DELIMITER ;

-- Use the Function
SELECT add_numbers(5, 10) AS sum;  -- Returns 15

-- This function subtract two integers and returns the result.
DELIMITER //
CREATE FUNCTION subtract_numbers(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN a - b;
END //

DELIMITER ;

-- Use the Function
SELECT subtract_numbers(5, 10) AS subtract;  -- Returns 15


-- This function concatenates a first name and a last name into a full name.
DELIMITER //

CREATE FUNCTION full_name(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(first_name, ' ', last_name);
END //

DELIMITER ;

-- Use the Function
SELECT full_name('John', 'Doe') AS name;  -- Returns 'John Doe'


-- This function calculates the age of a person based on their birthdate.
DELIMITER //

CREATE FUNCTION calculate_age(birthdate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN YEAR(CURDATE()) - YEAR(birthdate) - (DATE_FORMAT(CURDATE(), '%m%d') 
    < DATE_FORMAT(birthdate, '%m%d'));
END //

DELIMITER ;

-- Use the Function
SELECT calculate_age('2001-09-04') AS age;  -- Returns the age based on the current date


-- This function checks if a number is even or odd.
DELIMITER //

CREATE FUNCTION is_even_or_odd(num INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF num % 2 = 0 THEN
        RETURN 'Even';
    ELSE
        RETURN 'Odd';
    END IF;
END //

DELIMITER ;

-- Use the Function
SELECT is_even_or_odd(7) AS result;  -- Returns 'Odd'
SELECT is_even_or_odd(8) AS result;  -- Returns 'Even'


-- This function calculates the discounted price based on the original price and discount percentage.
DELIMITER //

CREATE FUNCTION discounted_price(original_price DECIMAL(10, 2), discount_percentage DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN original_price * (1 - discount_percentage / 100);
END //

DELIMITER ;

-- Use the Function
SELECT discounted_price(100, 20) AS final_price;  -- Returns 80.00


-- This function calculates the factorial of a number.
DELIMITER //
CREATE FUNCTION factorial(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE result INT DEFAULT 1;
    WHILE n > 1 DO
        SET result = result * n;
        SET n = n - 1;
    END WHILE;
    RETURN result;
END //
DELIMITER ;

-- Use the Function
SELECT factorial(5) AS factorial_of_5;  -- Returns 120


-- This function checks if a string is a palindrome.
DELIMITER //

CREATE FUNCTION is_palindrome(str VARCHAR(255))
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN str = REVERSE(str);
END //

DELIMITER ;

-- Use the Function
SELECT is_palindrome('madam') AS result;  -- Returns 1 (true)
SELECT is_palindrome('hello') AS result;  -- Returns 0 (false)


-- This function extracts a substring from a string based on the start position and length.
DELIMITER //

CREATE FUNCTION SubstringFunction(str VARCHAR(255), start INT, length INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    RETURN SUBSTRING(str, start, length);
END //

DELIMITER ;

-- Use the Function
SELECT SubstringFunction('Hello World', 1, 5) AS substring;  -- Returns 'Hello'


-- This function returns the square of a number.
DELIMITER //

CREATE FUNCTION SquareNumber(num DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
    RETURN num * num;
END //

DELIMITER ;

-- Use the Function
SELECT SquareNumber(4) AS square;  -- Returns 16.00


-- pattern & Regular Expressions
/*
Regular expressions (regex) in MySQL are used to search for patterns in strings. 
MySQL provides the REGEXP operator, which allows you to perform pattern matching using regular 
expressions. This can be particularly useful for validating input, searching for specific formats, 
or filtering data based on patterns.
*/

CREATE TABLE IF NOT EXISTS employees (
    employee_id DECIMAL(6,0) NOT NULL PRIMARY KEY,  
    -- Unique identifier for each employee
    first_name VARCHAR(20) NOT NULL,                 
    -- Employee's first name
    last_name VARCHAR(25) NOT NULL,                  
    -- Employee's last name
    email VARCHAR(50) NOT NULL,                      
    -- Employee's email address
    phone_number VARCHAR(20) DEFAULT NULL,           
    -- Employee's phone number (optional)
    password varchar(20) default null,
    hire_date DATE NOT NULL,                          
    -- Date when the employee was hired
    job_id VARCHAR(10) NOT NULL,                     
    -- Identifier for the employee's job
    salary DECIMAL(8,2) DEFAULT NULL,                
    -- Employee's salary (optional)
    commission_pct DECIMAL(2,2) DEFAULT NULL,       
    -- Commission percentage (optional)
    manager_id DECIMAL(6,0) DEFAULT NULL,            
    -- ID of the employee's manager (optional)
    department_id DECIMAL(4,0) DEFAULT NULL,         
    -- ID of the department (optional)
    
    -- Constraints for various fields
    CONSTRAINT chk_email CHECK (email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$'),  
    -- Valid email format: 
    -- ^                : Start of the string
    -- [a-zA-Z0-9._%+-]+: One or more alphanumeric characters, dots, underscores, percent signs, pluses, or hyphens
    -- @                : Must contain an "@" symbol
    -- [a-zA-Z0-9.-]+   : One or more alphanumeric characters, dots, or hyphens (domain name)
    -- \\.[a-zA-Z]{2,}  : A dot followed by at least two alphabetic characters (top-level domain)
    -- $                : End of the string

    CONSTRAINT chk_phone_number CHECK 
    (phone_number REGEXP '^(\\+\\d{1,3}\\s?)?\\(?\\d{1,4}\\)?[-\\s]?\\d{1,4}[-\\s]?\\d{1,4}$'),  
    -- Valid phone number format:
    -- ^                     : Start of the string
    -- (\\+\\d{1,3}\\s?)?    : Optional country code starting with "+" followed by 1 to 3 digits and 
    -- an optional space
    -- \\(?\\d{1,4}\\)?      : Optional area code in parentheses, consisting of 1 to 4 digits
    -- [-\\s]?               : Optional separator (dash or space)
    -- \\d{1,4}             : 1 to 4 digits (first part of the phone number)
    -- [-\\s]?               : Optional separator (dash or space)
    -- \\d{1,4}             : 1 to 4 digits (second part of the phone number)
    -- $                     : End of the string

    CONSTRAINT chk_password CHECK (password 
    REGEXP '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[A-Za-z0-9!@#$%^&*]{8,}$'),  
    -- Valid password format (if a password field is added):
    -- ^                     : Start of the string
    -- (?=.*[a-z])          : At least one lowercase letter
    -- (?=.*[A-Z])          : At least one uppercase letter
    -- (?=.*[0-9])          : At least one digit
    -- (?=.*[!@#$%^&*])     : At least one special character from the set !@#$%^&*
    -- [A-Za-z0-9!@#$%^&*]{8,} : At least 8 characters that can be letters, digits, or special characters
    -- $                     : End of the string

    CONSTRAINT chk_first_name CHECK (first_name REGEXP '^[A-Z][a-zA-Z]{1,19}$'),  
    -- First name must start with uppercase and be 2-20 characters long:
    -- ^                     : Start of the string
    -- [A-Z]                : First character must be an uppercase letter
    -- [a-zA-Z]{1,19}       : Followed by 1 to 19 letters (uppercase or lowercase)
    -- $                     : End of the string

    CONSTRAINT chk_last_name CHECK (last_name REGEXP '^[A-Z][a-z ]{1,24}$'),    
    -- Last name must start with uppercase and be 2-25 characters long:
    -- ^                     : Start of the string
    -- [A-Z]                : First character must be an uppercase letter
    -- [a-z]{1,24}          : Followed by 1 to 24 lowercase letters
    -- $                     : End of the string

    CONSTRAINT chk_job_id CHECK (job_id REGEXP '^[A-Z]{2,5}-\\d{1,4}$'),          
    -- Job ID format: 2-5 uppercase letters followed by a hyphen and 1-4 digits:
    -- ^                     : Start of the string
    -- [A-Z]{2,5}           : 2 to 5 uppercase letters
    -- -                    : A hyphen
    -- \\d{1,4}             : 1 to 4 digits
    -- $                     : End of the string

    CONSTRAINT chk_salary CHECK (salary REGEXP '^(\\d{1,8}(\\.\\d{2})?)$'),      
    -- Salary must be a number with up to 8 digits and optional 2 decimal places:
    -- ^                     : Start of the string
    -- \\d{1,8}             : 1 to 8 digits
    -- (\\.\\d{2})?         : Optional decimal part with 2 digits
    -- $                     : End of the string

    CONSTRAINT chk_commission CHECK (commission_pct REGEXP '^(0|0\\.\\d{1,2}|[1-9]\\d*(\\.\\d{1,2})?)$'),  
    -- Commission must be between 0 and 100 with up to 2 decimal places:
    -- ^                     : Start of the string
    -- (0|0\\.\\d{1,2}|[1-9]\\d*(\\.\\d{1,2})?) : 0, or 0 followed by 1 to 2 decimal places, or 1 to 9 
    -- followed by any number of digits and optional 1 to 2 decimal places
    -- $                     : End of the string

    CONSTRAINT chk_department_id CHECK (department_id REGEXP '^[1-9][0-9]{0,3}$') 
    -- Department ID must be a number between 1 and 9999:
    -- ^                     : Start of the string
    -- [1-9]                : First digit must be between 1 and 9
    -- [0-9]{0,3}           : Followed by 0 to 3 digits
    -- $                     : End of the string
);

-- Insert 5 records into the employees table
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, password, 
hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', 'P@ssw0rd', '2020-01-01',
    'SALE-1234', 50000.00, 0.10, 2, 10),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', 'P@ssw0rd', '2020-02-01', 
    'DEV-5678', 60000.00, 0.15, 1, 20),
    (3, 'Bob', 'Johnson', 'bob.johnson@example.com', '555-123-4567', 'P@ssw0rd', '2020-03-01', 
    'MARK-9012', 70000.00, 0.20, 3, 30),
    (4, 'Alice', 'Williams', 'alice.williams@example.com', '789-012-3456', 'P@ssw0rd', '2020-04-01', 
    'FIN-3456', 80000.00, 0.25, 4, 40),
    (5, 'Mike', 'Davis', 'mike.davis@example.com', '321-987-6543', 'P@ssw0rd', '2020-05-01', 
    'HR-5678', 90000.00, 0.30, 5, 50);
    
    select * from employees;




-- This function checks if a password is strong based on certain criteria.
DELIMITER //

CREATE FUNCTION IsStrongPassword(password VARCHAR(255)) RETURNS BOOLEAN
BEGIN
    DECLARE strong BOOLEAN;
    SET strong = password REGEXP '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$';
    RETURN strong;
END //

DELIMITER ;

-- Use the Function
SELECT IsStrongPassword('MyP@ssw0rd') AS result;  -- Returns 1 (true)
SELECT IsStrongPassword('mypassword') AS result;  -- Returns 0 (false)


-- This function validates an IP address format.
DELIMITER //

CREATE FUNCTION IsValidIP(ip VARCHAR(255))
RETURNS BOOLEAN
BEGIN
    DECLARE valid BOOLEAN;
    SET valid = ip REGEXP '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';
    RETURN valid;
END //

DELIMITER ;

-- Use the Function
SELECT IsValidIP('192.168.1.1') AS result;  -- Returns 1 (true)
SELECT IsValidIP('256.1.1.1') AS result;  -- Returns 0 (false)


-- This function validates a credit card number format.
DELIMITER //

CREATE FUNCTION IsValidCreditCard(card_number VARCHAR(255))
RETURNS BOOLEAN
BEGIN
    DECLARE valid BOOLEAN;
    SET valid = card_number 
    REGEXP '^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9]{2})[0-9]{12}|3[47][0-9]{13})$';
    RETURN valid;
END //

DELIMITER ;

-- Use the Function
SELECT IsValidCreditCard('4111111111111111') AS result;  -- Returns 1 (true)
SELECT IsValidCreditCard('411111111111111') AS result;  -- Returns 0 (false)


-- This function validates a zip code format.
DELIMITER //

CREATE FUNCTION IsValidZip(zip_code VARCHAR(255))
RETURNS BOOLEAN
BEGIN
    DECLARE valid BOOLEAN;
    SET valid = zip_code REGEXP '^[0-9]{5}(?:-[0-9]{4})?$';
    RETURN valid;
END //

DELIMITER ;

-- Use the Function
SELECT IsValidZip('12345') AS result;  -- Returns 1 (true)
SELECT IsValidZip('1234') AS result;  -- Returns 0 (false)




-- 1. Function to Calculate Annual Salary
DELIMITER //
CREATE FUNCTION CalculateAnnualSalary(salary DECIMAL(8,2))
RETURNS DECIMAL(10,2)
BEGIN
    RETURN salary * 12;  -- Assuming salary is monthly
END //
DELIMITER ;

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    CalculateAnnualSalary(salary) AS annual_salary
FROM employees;


-- 2. Function to Calculate Total Commission
DELIMITER //
CREATE FUNCTION CalculateTotalCommission(salary DECIMAL(8,2), commission_pct DECIMAL(2,2))
RETURNS DECIMAL(10,2)
BEGIN
    RETURN salary * commission_pct;  -- Total commission based on salary and commission percentage
END //
DELIMITER ;

SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    commission_pct,
    CalculateTotalCommission(salary, commission_pct) AS total_commission
FROM employees;

-- 3. Function to Validate Email Format
DELIMITER //
CREATE FUNCTION IsValidEmail(email VARCHAR(50))
RETURNS BOOLEAN
BEGIN
    RETURN email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$';
END //
DELIMITER ;

SELECT
    employee_id,
    first_name,
    last_name,
    email,
    IsValidEmail(email) AS email_valid
FROM employees;

-- delete a function
DROP FUNCTION IF EXISTS IsValidEmail;
