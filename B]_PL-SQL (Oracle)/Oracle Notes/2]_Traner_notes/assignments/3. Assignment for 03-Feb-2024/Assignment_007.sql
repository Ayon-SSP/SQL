--Assignment_007   3-FEB-24
-- ADD RECORDS

-- Student
-- (student, student_name),
-- (101, 'John Smith'),
-- (102, 'Alice Johnson'),
-- (103, 'Bob Miller'),
-- (104, 'Emily Brown'),
-- (105, 'Daniel Kim'),
-- (106, 'Eva Martinez'),
-- (107, 'Gary Wilson'),
-- (108, 'Hannah Lee'),
-- (109, 'Ian Turner'),
-- (110, 'Jessica Hall');

-- Insert data into student table
INSERT INTO student ( student_name ) VALUES ( 'John Smith' );
INSERT INTO student ( student_name ) VALUES ( 'Alice Johnson' );
INSERT INTO student ( student_name ) VALUES ( 'Bob Miller' );
INSERT INTO student ( student_name ) VALUES ( 'Emily Brown' );
INSERT INTO student ( student_name ) VALUES ( 'Daniel Kim' );
INSERT INTO student ( student_name ) VALUES ( 'Eva Martinez' );
INSERT INTO student ( student_name ) VALUES ( 'Gary Wilson' );
INSERT INTO student ( student_name ) VALUES ( 'Hannah Lee' );
INSERT INTO student ( student_name ) VALUES ( 'Ian Turner' );
INSERT INTO student ( student_name ) VALUES ( 'Jessica Hall' );


-- Faculty
-- (faculty_id, faculty_name, faculty_phone),
-- (201, 'Dr. Anderson', '555-1234'),
-- (202, 'Prof. Davis', '555-5678'),
-- (203, 'Dr. White', '555-9876'),
-- (204, 'Prof. Harris', '555-4321'),
-- (205, 'Dr. Robinson', '555-8765'),
-- (206, 'Prof. Garcia', '555-2345'),
-- (207, 'Dr. Baker', '555-6789'),
-- (208, 'Prof. Murphy', '555-3456'),
-- (209, 'Dr. Carter', '555-7890'),
-- (210, 'Prof. Martin', '555-0123');

-- Insert data into faculty table
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Dr. Anderson', '555-1234' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Prof. Davis', '555-5678' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Dr. White', '555-9876' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Prof. Harris', '555-4321' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Dr. Robinson', '555-8765' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Prof. Garcia', '555-2345' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Dr. Baker', '555-6789' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Prof. Murphy', '555-3456' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Dr. Carter', '555-7890' );
INSERT INTO faculty ( faculty_name, faculty_phone ) VALUES ( 'Prof. Martin', '555-0123' );


-- Course
-- (course_id, course_name, faculty_id),
-- (301, 'Database Management', 201),
-- (302, 'Programming Fundamentals', 202),
-- (303, 'Data Structures', 203),
-- (304, 'Web Development', 204),
-- (305, 'Algorithms', 205),
-- (306, 'Network Security', 206),
-- (307, 'Artificial Intelligence', 207),
-- (308, 'Software Engineering', 208),
-- (309, 'Computer Graphics', 209),
-- (310, 'Operating Systems', 210);

-- Insert data into course table
INSERT INTO course ( faculty_id, course_name ) VALUES ( 201, 'Database Management' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 202, 'Programming Fundamentals' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 203, 'Data Structures' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 204, 'Web Development' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 205, 'Algorithms' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 206, 'Network Security' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 207, 'Artificial Intelligence' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 208, 'Software Engineering' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 209, 'Computer Graphics' );
INSERT INTO course ( faculty_id, course_name ) VALUES ( 210, 'Operating Systems' );


-- Grade
-- (student_id, course_id, grade),
-- (101, 301, 'A'),
-- (102, 302, 'B'),
-- (103, 303, 'C'),
-- (104, 304, 'A'),
-- (105, 305, 'B'),
-- (106, 306, 'A'),
-- (107, 307, 'C'),
-- (108, 308, 'B'),
-- (109, 309, 'A'),
-- (110, 310, 'C');

-- Insert data into students_grade table
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 101, 301, 'A' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 102, 302, 'B' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 103, 303, 'C' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 104, 304, 'A' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 105, 305, 'B' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 106, 306, 'A' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 107, 307, 'C' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 108, 308, 'B' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 109, 309, 'A' );
INSERT INTO students_grade ( student_id, course_id, student_grade ) VALUES ( 110, 310, 'C' );

-- Select all data from all tables
SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM course;
SELECT * FROM students_grade;   