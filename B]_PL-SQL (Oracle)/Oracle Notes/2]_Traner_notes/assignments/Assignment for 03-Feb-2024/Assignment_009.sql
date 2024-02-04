-- 1. For each question, provide the SQL query that answers the question.
-- 2. Include comments in your queries to explain the purpose of each query.
-- 3. Test your queries on the provided tables.
-- 4. Submit the queries and the output for verification.


-- DDL Level 1 Assignment :
-- 1. Create a Table:
-- - Create a table named 'Employee with columns: 'EmpID (Primary Key), 'EmpName`, `EmpSalary, and 'EmpDepartment.
CREATE TABLE Employee (
    EmpID INT PRIMARY ,
    EmpName VARCHAR(100),
    EmpSalary DECIMAL(10, 2),
    EmpDepartment VARCHAR(100)
);

-- 2. Add a Column:
-- - Alter the 'Employee table to add a new column named 'EmpAddress` of data type VARCHAR(100).
ALTER TABLE Employee
ADD EmpAddress VARCHAR(100);

-- 3. Create an Index:
-- - Create an Index named 'Idx_salary' on the 'EmpSalary column In the 'Employee table.
CREATE INDEX Idx_salary
ON Employee (EmpSalary);

-- 4. Define a Primary Key:
-- - Define 'EmpID` as the primary key for the 'Employee table.
ALTER TABLE Employee
ADD CONSTRAINT PK_Employee_EmpID PRIMARY KEY (EmpID);

-- 5. Remove a Table:
-- Drop the 'Employee table if it exists.
-- DROP TABLE IF EXISTS Employee; -- ⚠️ oracle database does not support IF EXISTS clause for create as well as drop table statement.

DECLARE
    table_exists NUMBER;
BEGIN
    SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'Employee';

    IF table_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE Employee';
        DBMS_OUTPUT.PUT_LINE('Table dropped successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Table does not exist.');
    END IF;
END;
/


