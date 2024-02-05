--Assignment_010   3-FEB-24 
--SQL QUERIES 

-- DDL Level 2
-- 1. Create a Sequence: - Create a sequence named 'emp_ld_seq` with a starting value of 100 and an Increment of 1.
CREATE SEQUENCE emp_ld_seq
START WITH 100
INCREMENT BY 1;

SELECT emp_ld_seq.NEXTVAL FROM dual; -- 101
SELECT emp_ld_seq.NEXTVAL FROM dual; -- 102
SELECT emp_ld_seq.NEXTVAL FROM dual; -- 103


-- 2. Add a Foreign Key: - Create a table named 'Department with 
--  columns: 'DeptID' (Primary Key) and 'DeptName'. 
--      Alter the 'Employee table to add a foreign key 
--      constraint on the 'EmpDepartment column referencing the 'Department table.

drop table Employee;
drop table Department;
CREATE TABLE Department(
    DeptID NUMBER(2) PRIMARY KEY,
    DeptName VARCHAR2(50)
);

CREATE TABLE Employee(
    EmpID NUMBER(5) PRIMARY KEY,
    EmpName VARCHAR2(50),
    EmpDepartment NUMBER(2),
    EmpAddress VARCHAR2(100),
    EmpSalary NUMBER(10,2)
);

ALTER TABLE Employee
ADD CONSTRAINT fk_emp_dept
    FOREIGN KEY (EmpDepartment)
    REFERENCES Department(DeptID);


-- 3. Modify Data Type:
-- Modify the data type of the 'EmpSalary column in the 'Employee table to NUMBER(10,2).
ALTER TABLE Employee
MODIFY (EmpSalary NUMBER(10,2));

-- 4. Rename a Column:
-- - Rename the column 'EmpAddress` in the 'Employee' table to 'EmpLocation'.
ALTER TABLE Employee
RENAME COLUMN EmpAddress TO EmpLocation;

-- 5. Create a Unique Constraint:
-- - Add a unique constraint named 'uniq_name` on the 'EmpName' column in the 'Employee table.
ALTER TABLE Employee
ADD CONSTRAINT uniq_name UNIQUE(EmpName);
