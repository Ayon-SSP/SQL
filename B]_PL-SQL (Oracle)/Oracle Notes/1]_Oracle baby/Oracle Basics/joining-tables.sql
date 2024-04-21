-- Join's types
  -- INNER JOIN – show you how to query rows from a table that have matching rows from another table.
  -- LEFT JOIN – introduce you to the left-join concept and learn how to use it to select rows from the left table that have or don’t have the matching rows in the right table.
  -- RIGHT JOIN – explain the right-join concept and show you how to apply it to query rows from the right table that have or don’t have the matching rows in the left table.
  -- FULL OUTER JOIN – describe how to use the full outer join or full join to query data from two tables.
  -- CROSS JOIN – cover how to make a Cartesian product from multiple tables.
-- Join concepts
  -- Equi join:
  -- Non-equi join:
  -- Natural join: - auto select common column
  -- SELF JOIN: – show you how to join a table to itself to query hierarchical data or compare rows within the same table.
  -- Anti join: - same as above but does `not exist`
  -- Semi join: A semi-join in Oracle is a type of join that returns rows from the first table where a matching row `exists` in the second table



-- Natural join:

/*
1. No condition eg( ON employees.department_id = departments.department_id)
2. It will join the tables based on the common column names
3. It will return the rows that have the same values in the common column
4. It will not return the common column twice
5. It will return the rows that have the same values in the common column
employee_id | employee_name | department_id
-------------------------------------------
1           | John          | 1
2           | Alice         | 2
3           | Bob           | 1
4           | Mary          | 2


department_id | department_name
-------------------------------
1             | Engineering
2             | Marketing

SELECT *
FROM employees
NATURAL JOIN departments;

employee_id | employee_name | department_id | department_name
------------------------------------------------------------
1           | John          | 1             | Engineering
2           | Alice         | 2             | Marketing
3           | Bob           | 1             | Engineering
4           | Mary          | 2             | Marketing

First it get's the common column 
  (a b c d) and (c d e f) => (c d)
Then it gets the rows that have the same values in the common column
  c(0 1 2) and d(1 2 3 4) => (1 2)  -> Inner JOIN else cross join
*/

-- CROSS JOIN:
/*
1. It returns the Cartesian product of the sets of rows from the joined tables.
2. It will return all the rows from the left table and all the rows from the right table.
3. It will return the number of rows equal to the number of rows in the left table multiplied by the number of rows in the right table.
4. It will return the common column twice
5. It will return the rows that have the same values in the common column
employee_id | employee_name | department_id
-------------------------------------------
1           | John          | 1
2           | Alice         | 2
3           | Bob           | 1
4           | Mary          | 2


department_id | department_name
-------------------------------
1             | Engineering
2             | Marketing

SELECT *
FROM employees
CROSS JOIN departments;

employee_id | employee_name | department_id | department_id | department_name
---------------------------------------------------------------------------
1           | John          | 1             | 1             | Engineering
1           | John          | 1             | 2             | Marketing
2           | Alice         | 2             | 1             | Engineering
2           | Alice         | 2             | 2             | Marketing
3           | Bob           | 1             | 1             | Engineering
3           | Bob           | 1             | 2             | Marketing
4           | Mary          | 2             | 1             | Engineering
4           | Mary          | 2             | 2             | Marketing

First it gets the common column 
  (a b c d) and (c d e f) => (a b c d c d e f)
Then it gets the rows that have the same values in the common column
  (0 1 2) and (1 2 3 4) => (*all)  -> Inner JOIN else cross join
*/

-- SELF JOIN: 
/*
1. It is a regular join, but the table is joined with itself.
2. It is used to join a table to itself as if the table were two tables, temporarily renaming at least one table in the SQL statement.
3. It is used to compare values in a column with other values in the same column in the same table.
4. It is used to query hierarchical data or compare rows within the same table.
5. It is used to compare rows within the same table.

employee_id | employee_name | manager_id
---------------------------------------
1           | John          | 3
2           | Alice         | 3
3           | Bob           | NULL
4           | Mary          | 3

SELECT e1.employee_name employee, e2.employee_name manager
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id;

employee | manager
------------------
John     | Bob
Alice    | Bob
Bob      | NULL
Mary     | Bob
*/

-- Anti join:
/*
1. It returns the rows from the first table that do not have a match in the second table.
2. It is used to find rows in the first table that do not have corresponding rows in the second table.
3. It is used to compare the values in the columns of the first table with the values in the columns of the second table.
4. It is used to query rows from the first table that do not have matching rows in the second table.


SELECT table1.*
FROM table1
LEFT JOIN table2 ON table1.department_id = table2.department_id
WHERE table2.department_id IS NULL;


*/

-- Equi join:
/*
1. It returns the rows from the first table that have matching rows in the second table.
2. equality operator (=)
*/

-- SEMI JOIN: It's like asking "Does at least one match exist?" rather than "What are the matches?"
/*
| Employee_ID | Name     | Department |
|-------------|----------|------------|
| 1           | Alice    | Sales      |
| 2           | Bob      | Marketing  |
| 3           | Charlie  | Sales      |

| Employee_ID | Sales_Amount |
|-------------|--------------|
| 1           | 5000         |
| 3           | 7000         |

*/

SELECT *
FROM Employees e
WHERE EXISTS (
    SELECT 1
    FROM Sales s
    WHERE e.Employee_ID = s.Employee_ID
);


/*
| Employee_ID | Name   | Department |
|-------------|--------|------------|
| 1           | Alice  | Sales      |
| 3           | Charlie| Sales      |
*/


-- INNER JOIN suppliers s USING (supplierid)