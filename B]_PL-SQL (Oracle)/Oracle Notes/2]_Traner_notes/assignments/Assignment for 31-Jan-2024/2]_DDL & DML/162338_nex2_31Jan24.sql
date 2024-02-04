-- DDL/DML for the following ER diagram

-- department
-- dept_id	dept_name
-- 10	    Finance
-- 14	    R&D

-- project
-- proj_id(pk)	proj_name
-- 27	        alpha
-- 25	        beta
-- 22	        gamma
-- 26	        pail
-- 21	        hill

-- employee
-- empl_id(pk)	empl_name	dept_id*
-- 1	        Huey	    10
-- 5	        Dewey	    10
-- 11	        Louie	    10
-- 2	        Jack	    14
-- 4	        Jill	    14

-- works_on
-- (empl_id*  proj_id*)pk	hours
-- 1	      27	        4.5
-- 5	      25	        3
-- 11	      22	        7
-- 2	      26	        8
-- 4	      21	        9

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

-- Select all data from all tables
SELECT * FROM department;
SELECT * FROM project;
SELECT * FROM employee;
SELECT * FROM works_on;

-- Drop the tables
DROP TABLE works_on;
DROP TABLE employee;
DROP TABLE project;
DROP TABLE department;