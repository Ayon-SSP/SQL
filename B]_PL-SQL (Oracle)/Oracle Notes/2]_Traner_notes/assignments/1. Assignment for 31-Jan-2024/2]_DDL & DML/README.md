# 🧩🪛🧬🧮 Schema
![schema](https://github.com/Ayon-SSP/SQL/assets/80549753/5eb5ad5e-11b2-4867-b6df-904d19741b90)

## 📝 **Assignment** 
- 🏫 School schema
> DDL/DML for the following ER diagram
```sql
-- Create student table
CREATE TABLE student (
    student_id NUMBER GENERATED BY DEFAULT AS IDENTITY
    START WITH 1 PRIMARY KEY,
    student_name VARCHAR2( 50 ) NOT NULL
);

-- Create faculty table
CREATE TABLE faculty (
    faculty_id NUMBER GENERATED BY DEFAULT AS IDENTITY
    START WITH 1 PRIMARY KEY,
    faculty_name VARCHAR2( 50 ) NOT NULL,
    faculty_phone VARCHAR2( 20 ) NOT NULL
);

-- Create course table
CREATE TABLE course (
    course_id VARCHAR2( 5 ) PRIMARY KEY,
    faculty_id NUMBER NOT NULL,               -- fk
    course_name VARCHAR2( 50 ) NOT NULL,
    CONSTRAINT fk_course_faculty 
        FOREIGN KEY( faculty_id )
        REFERENCES faculty( faculty_id ) 
        ON DELETE SET NULL
);

-- Create students_grade table
CREATE TABLE students_grade (
    student_id NUMBER NOT NULL,              -- fk
    course_id VARCHAR2( 5 ) NOT NULL,         -- fk
    student_grade VARCHAR2( 2 ) NOT NULL,
    CONSTRAINT pk_students_grade 
        PRIMARY KEY ( student_id, course_id ),
    CONSTRAINT fk_students_grade_student_id 
        FOREIGN KEY( student_id )
        REFERENCES student( student_id ) 
        ON DELETE CASCADE,
    CONSTRAINT fk_students_grade_course_id 
        FOREIGN KEY( course_id )
        REFERENCES course( course_id ) 
        ON DELETE CASCADE
);

-- Insert data into student table
INSERT INTO student ( student_name ) VALUES ( 'Adams' );
INSERT INTO student ( student_name ) VALUES ( 'Jones' );
INSERT INTO student ( student_name ) VALUES ( 'Smith' );
INSERT INTO student ( student_name ) VALUES ( 'Baker' );

-- Insert data into faculty table
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Howser', '60192' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Langley', '45869' );

-- Insert data into course table
INSERT INTO course ( course_id, faculty_id, course_name ) VALUES ( 'IS318', 1, 'Database' );
INSERT INTO course ( course_id, faculty_id, course_name ) VALUES ( 'IS301', 2, 'EC' );

-- Insert data into students_grade table
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 1, 'IS318', 'A' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 1, 'IS301', 'B' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 2, 'IS318', 'A' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 3, 'IS318', 'B' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 4, 'IS301', 'A' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 4, 'IS318', 'B' );


-- Select all data from all tables
SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM course;
SELECT * FROM students_grade;

-- Drop the tables
DROP TABLE students_grade;
DROP TABLE course;
DROP TABLE faculty;
DROP TABLE student;
```


- 👷‍♂️ Office schema
> DDL/DML for the following ER diagram
```sql
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
```