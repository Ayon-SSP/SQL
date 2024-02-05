# Ouput 🔳
## Database Relational Tables
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/0d840088-72b1-474f-834a-4c6e4abfea24)

## Assignment_006 & 007

```sql
-- Select all data from all tables
SELECT * FROM student;
SELECT * FROM faculty;
SELECT * FROM course;
SELECT * FROM students_grade;
```
Output:

| STUDENT_ID | STUDENT_NAME |
|------------|--------------|
| 101        | John Smith   |
| 102        | Alice Johnson|
| 103        | Bob Miller   |
| 104        | Emily Brown  |
| 105        | Daniel Kim   |
| 106        | Eva Martinez |
| 107        | Gary Wilson  |
| 108        | Hannah Lee   |
| 109        | Ian Turner   |
| 110        | Jessica Hall |

...



```sql
--Assignment_008   3-FEB-24 
--SQL QUERIES 

-- 1. Select all students and their grades
SELECT s.student_name, c.course_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id;
-- can also use ROLEUP to show the average grade of each student.
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/d16e9138-a48a-430c-a8a7-0bf62b81be40)

```sql
-- 2. List courses and their respective faculties
SELECT c.course_name, f.faculty_name
FROM course c
JOIN faculty f ON c.faculty_id = f.faculty_id;
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/f22c9f94-3078-4a49-b354-a274444711f5)

```sql
-- 3. Display all grades for a specific course (e.g., "Database Management')
SELECT s.student_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id
WHERE c.course_name = 'Database Management';
```
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/23e778bd-c796-4c8a-a163-6e835a1b0e9c)

```sql
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
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/ed2e5976-e07f-4ad0-8b3e-ce7c6af029f5)


```sql
-- 5. List students and their grades for courses taught by a specific faculty (e.g., "Dr. Anderson')
SELECT s.student_name, c.course_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id
JOIN faculty f ON c.faculty_id = f.faculty_id
WHERE f.faculty_name = 'Dr. Anderson';
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/f0307dc5-5b3b-4f00-959e-306ded8b2f7d)


```sql
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
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/a3ec3c57-f0cf-4640-a85b-a9296fc423bf)

```sql
-- 7. Show the number of students in each course
SELECT c.course_name, COUNT( sg.student_id ) AS num_students
FROM course c
JOIN students_grade sg ON c.course_id = sg.course_id
GROUP BY c.course_name;
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/80883343-15da-452f-9799-fa294a04b15b)

```sql
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
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/21a03f55-5e99-4e63-8023-50fb990025f8)

```sql
-- 9. Retrieve students who scored 'A' in any course
SELECT s.student_name, c.course_name, sg.student_grade
FROM student s
JOIN students_grade sg ON s.student_id = sg.student_id
JOIN course c ON sg.course_id = c.course_id
WHERE sg.student_grade = 'A';
```
OUTPUT:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/33d06700-dc7c-47c0-88f4-6605151986bf)

```sql
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
HAVING 
    COUNT( sg.student_id ) > 2
    AND AVG( CASE sg.student_grade
        WHEN 'A' THEN 100
        WHEN 'B' THEN 90
        WHEN 'C' THEN 80
        WHEN 'D' THEN 70
        WHEN 'F' THEN 60

        ELSE 0
    END ) > 80;
```
output:
![image](https://github.com/Ayon-SSP/Ayon-SSP/assets/80549753/80ff0d80-d7ca-4f03-978d-988f5813c39f)
