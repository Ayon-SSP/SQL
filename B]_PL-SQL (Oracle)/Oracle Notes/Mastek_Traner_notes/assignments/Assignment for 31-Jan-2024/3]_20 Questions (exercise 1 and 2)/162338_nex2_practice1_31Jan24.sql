-- Create department table
CREATE TABLE department (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2( 50 ) NOT NULL
);

-- Create project table
CREATE TABLE project (
    proj_id NUMBER PRIMARY KEY,
    proj_name VARCHAR2( 50 ) NOT NULL
);

-- Create employee table
CREATE TABLE employee (
    empl_id NUMBER PRIMARY KEY,
    empl_name VARCHAR2( 50 ) NOT NULL,
    dept_id NUMBER NOT NULL,               -- fk
    CONSTRAINT fk_employee_dept_id 
        FOREIGN KEY( dept_id )
        REFERENCES department( dept_id ) 
        ON DELETE SET NULL
);

-- Create works_on table
CREATE TABLE works_on (
    empl_id NUMBER NOT NULL,              -- fk
    proj_id NUMBER NOT NULL,              -- fk
    hours NUMBER NOT NULL,
    CONSTRAINT pk_works_on 
        PRIMARY KEY ( empl_id, proj_id ),
    CONSTRAINT fk_works_on_empl_id 
        FOREIGN KEY( empl_id )
        REFERENCES employee( empl_id ) 
        ON DELETE CASCADE,
    CONSTRAINT fk_works_on_proj_id 
        FOREIGN KEY( proj_id )
        REFERENCES project( proj_id ) 
        ON DELETE CASCADE
);

-- Insert data into department table
INSERT INTO department ( dept_id, dept_name ) VALUES ( 10, 'Finance' );
INSERT INTO department ( dept_id, dept_name ) VALUES ( 14, 'R&D' );

-- Insert data into project table
INSERT INTO project ( proj_id, proj_name ) VALUES ( 27, 'alpha' );
INSERT INTO project ( proj_id, proj_name ) VALUES ( 25, 'beta' );
INSERT INTO project ( proj_id, proj_name ) VALUES ( 22, 'gamma' );
INSERT INTO project ( proj_id, proj_name ) VALUES ( 26, 'pail' );
INSERT INTO project ( proj_id, proj_name ) VALUES ( 21, 'hill' );

-- Insert data into employee table
INSERT INTO employee ( empl_id, empl_name, dept_id ) VALUES ( 1, 'Huey', 10 );
INSERT INTO employee ( empl_id, empl_name, dept_id ) VALUES ( 5, 'Dewey', 10 );
INSERT INTO employee ( empl_id, empl_name, dept_id ) VALUES ( 11, 'Louie', 10 );
INSERT INTO employee ( empl_id, empl_name, dept_id ) VALUES ( 2, 'Jack', 14 );
INSERT INTO employee ( empl_id, empl_name, dept_id ) VALUES ( 4, 'Jill', 14 );

-- Insert data into works_on table
INSERT INTO works_on ( empl_id, proj_id, hours ) VALUES ( 1, 27, 4.5 );
INSERT INTO works_on ( empl_id, proj_id, hours ) VALUES ( 5, 25, 3 );
INSERT INTO works_on ( empl_id, proj_id, hours ) VALUES ( 11, 22, 7 );
INSERT INTO works_on ( empl_id, proj_id, hours ) VALUES ( 2, 26, 8 );
INSERT INTO works_on ( empl_id, proj_id, hours ) VALUES ( 4, 21, 9 );

-- Practice Questions ⚠️ Don't consider the Questions. Just practice the queries
--Q1. Display works_on empl_id,proj_id,hours in asc order of empl_id
SELECT empl_id,proj_id,hours
FROM works_on
ORDER BY empl_id;

--Q2. Display works_on empl_id,proj_id,hours in asc order of proj_id
SELECT empl_id,proj_id,hours
FROM works_on
ORDER BY proj_id;

--Q3. Display works_on empl_id,proj_id,hours in asc order of hours
SELECT empl_id,proj_id,hours
FROM works_on
ORDER BY hours;

--Q4. Display works_on empl_id,proj_id,hours in asc order of empl_id,proj_id
SELECT empl_id,proj_id,hours
FROM works_on
ORDER BY empl_id,proj_id;

--Q5. Display works_on empl_id,proj_id,hours in asc order of empl_id,proj_id,hours
SELECT empl_id,proj_id,hours
FROM works_on
ORDER BY empl_id,proj_id,hours;

--Q6. Display works_on empl_id,proj_id,hours in asc order of proj_id,hours
SELECT empl_id,proj_id,hours
FROM works_on
ORDER BY proj_id,hours;

--Q7. Fetch 5 top works_on earning highest
SELECT * FROM works_on
ORDER BY hours DESC
FETCH FIRST 5 ROWS ONLY;

--Q8. Fetch 2nd Highest salaried works_on details
SELECT * FROM works_on
ORDER BY hours DESC
OFFSET 1 ROW FETCH FIRST 1 ROWS ONLY;

--Q9. Display list of all works_on working in department 2
SELECT * FROM works_on
WHERE empl_id = 2;

--Q10. Display list of all works_on working in department 3
SELECT * FROM works_on
WHERE empl_id = 3;

--Q11. Display list of all works_on working in department 4
SELECT * FROM works_on
WHERE empl_id = 4;

-- Q12. Display list of all works_on working as ANALYST
SELECT * FROM works_on
WHERE hours = 4.5;

-- Q13. Display list of all works_on working as CLERK
SELECT * FROM works_on
WHERE hours = 3;

-- Q14. Display list of all works_on working as SALESMAN
SELECT * FROM works_on
WHERE hours = 7;

-- Q15. Display list of all works_on working as PRESIDENT
SELECT * FROM works_on
WHERE hours = 8;

-- Q16. Display list of all works_on EARNING SAL BETWEEN 500 TO 4000
SELECT * FROM works_on
WHERE hours BETWEEN 4.5 AND 8;

-- Q17. Display list of all works_on EARNING SAL NOT BETWEEN 500 TO 4000
SELECT * FROM works_on
WHERE hours NOT BETWEEN 4.5 AND 8;

-- Q18. COMPARISON
-- Q18.A. Display list of all works_on EARNING SAL >500
SELECT * FROM works_on
WHERE hours > 4.5;

-- Q18.B. Display list of all works_on EARNING SAL <500
SELECT * FROM works_on
WHERE hours < 4.5;

-- Q18.C. Display list of all works_on EARNING SAL <=500
SELECT * FROM works_on
WHERE hours <= 4.5;

-- Q18.D. Display list of all works_on EARNING SAL <=500
SELECT * FROM works_on
WHERE hours >= 4.5;

-- Q18.E. Display list of all works_on EARNING SAL !=800
SELECT * FROM works_on
WHERE hours != 4.5;

-- Q18.F. Display list of all works_on EARNING SAL =5000
SELECT * FROM works_on
WHERE hours = 4.5;

-- Q19. LOGICAL OPERATOR AND OR NOT/LIKE/IN/NOT IN/BETWEEN NOT BETWEEN
-- Q19.A DISPLAY EMPLOYEE WORKING IN DEPARTMENT 10 AS CLERK
SELECT * FROM works_on
WHERE empl_id = 1 AND proj_id = 27;

-- Q20. DISPLAY UNIUE JOB FROM EMPLOYE TABLE
SELECT DISTINCT proj_id
FROM works_on;