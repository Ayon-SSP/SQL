-- DDL/DML for the following ER diagram

-- student
-- student_id(pk)	student_name
-- 1	            Adams
-- 2	            Jones
-- 3	            Smith
-- 4	            Baker

-- faculty
-- faculty_id(pk)	faculty_name	faculty_phone
-- 1	            Howser	        60192
-- 2	            Langley	        45869

-- course
-- course_id(pk) faculty_id*	 course_name
-- IS318		 1            Database
-- IS301		 2            EC

-- students_grade
-- (student_id*	course_id*)pk	student_grade
-- 1	        IS318	        A
-- 1	        IS301	        B
-- 2	        IS318	        A
-- 3	        IS318	        B
-- 4	        IS301	        A
-- 4	        IS318	        B


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