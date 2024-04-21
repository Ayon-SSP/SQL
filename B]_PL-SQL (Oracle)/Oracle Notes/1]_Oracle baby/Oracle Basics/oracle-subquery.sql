-- Oracle SQL Subqueries
-- 1. Scalar Subqueries:
SELECT *
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. Correlated Subqueries:
SELECT manager_id, name
FROM managers m
WHERE (SELECT COUNT(*) FROM employees WHERE manager_id = m.manager_id) >
      (SELECT AVG(COUNT(*)) FROM employees GROUP BY department_id);

-- 3. Subqueries in SELECT Clause
SELECT e.employee_id, e.name, d.name AS department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- 4. Subqueries in FROM Clause
SELECT *
FROM orders o
WHERE order_date < (SELECT AVG(order_date) FROM orders);

-- 5. Subqueries in WHERE Clause
SELECT *
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders WHERE order_date < TO_DATE('01-JAN-2023', 'DD-MON-YYYY'));




-- Oracle Subquery
-- A) Oracle subquery in the SELECT clause example
SELECT
    *,
    (subquery) AS avg_list_price
FROM
    inline_view;

-- B) Oracle subquery in the FROM clause example
SELECT * FROM (subquery) [AS] inline_view;

-- C) Oracle subquery with comparison operators example
SELECT *
FROM
    products
WHERE
    list_price > (subquery);

-- D) Oracle subquery with IN and NOT IN operators
SELECT *
FROM
    employees
WHERE
    employee_id IN(subquery)
    -<or>-
    employee_id IN(subquery)
    -<or>-
    (EMPLOYEE_ID, SALARY) INw(SELECT EMPLOYEE_ID, SALARY FROM EMPLOYEES WHERE SALARY > 10000)
ORDER BY attrubutes;

-- E) Oracle subquery with the EXISTS operator
SELECT *
FROM
    employees
WHERE
    EXISTS(subquery);

-- F) Oracle subquery with the ALL operator
SELECT *
FROM
    products
WHERE
    list_price > ALL(subquery);


-- `ROWNUM` <= 3" not supported in subqueries(ROWNUM works in main SELECT statements)