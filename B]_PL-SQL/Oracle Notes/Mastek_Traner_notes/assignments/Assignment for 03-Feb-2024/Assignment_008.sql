-- 1. Select all students and their grades
SELECT s.student_name, c.course_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id;

-- 2. List courses and their respective faculties
SELECT c.course_name, f.faculty_name
FROM course c
JOIN faculty f ON c.faculty_id = f.faculty_id;

-- 3. Display all grades for a specific course (e.g., "Database Management')
SELECT s.student_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id
WHERE c.course_name = 'Database Management';

-- 4. Show the average grade for each course
SELECT c.course_name, AVG( CASE sg.student_grade
    WHEN 'A' THEN 4
    WHEN 'B' THEN 3
    WHEN 'C' THEN 2
    WHEN 'D' THEN 1
    ELSE 0
END ) AS avg_grade
FROM course c
JOIN students_grade sg ON c.course_id = sg.course_id
GROUP BY c.course_name;

-- 5. List students and their grades for courses taught by a specific faculty (e.g., "Dr. Anderson')
SELECT s.student_name, c.course_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id
JOIN faculty f ON c.faculty_id = f.faculty_id
WHERE f.faculty_name = 'Dr. Anderson';

-- 6. Display the highest grade in each course
SELECT c.course_name, MAX( CASE sg.student_grade
    WHEN 'A' THEN 4
    WHEN 'B' THEN 3
    WHEN 'C' THEN 2
    WHEN 'D' THEN 1
    ELSE 0
END ) AS max_grade
FROM course c
JOIN students_grade sg ON c.course_id = sg.course_id
GROUP BY c.course_name;

-- 7. Show the number of students in each course
SELECT c.course_name, COUNT( sg.student_id ) AS num_students
FROM course c
JOIN students_grade sg ON c.course_id = sg.course_id
GROUP BY c.course_name;

-- 8. List courses with the number of students and average grade
SELECT c.course_name, COUNT( sg.student_id ) AS num_students, AVG( CASE sg.student_grade
    WHEN 'A' THEN 4
    WHEN 'B' THEN 3
    WHEN 'C' THEN 2
    WHEN 'D' THEN 1
    ELSE 0
END ) AS avg_grade
FROM course c
JOIN students_grade sg ON c.course_id = sg.course_id
GROUP BY c.course_name;

-- 9. Retrieve students who scored 'A' in any course
SELECT s.student_name, c.course_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id
WHERE sg.student_grade = 'A';

-- 10. Display courses with more than 2 students and average grade above 80
SELECT c.course_name, COUNT( sg.student_id ) AS num_students, AVG( CASE sg.student_grade
    WHEN 'A' THEN 4
    WHEN 'B' THEN 3
    WHEN 'C' THEN 2
    WHEN 'D' THEN 1
    ELSE 0
END ) AS avg_grade
FROM course c
JOIN students_grade sg ON c.course_id = sg.course_id
GROUP BY c.course_name
HAVING COUNT( sg.student_id ) > 2
AND AVG( CASE sg.student_grade
    WHEN 'A' THEN 4
    WHEN 'B' THEN 3
    WHEN 'C' THEN 2
    WHEN 'D' THEN 1
    ELSE 0
END ) > 4 * (80/100);