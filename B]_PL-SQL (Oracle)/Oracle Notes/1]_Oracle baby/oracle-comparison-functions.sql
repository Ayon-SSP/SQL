-- *Oracle Comparison Functions
-- *    COALESCE – function to return the first non-null arguments in a list.
-- *    DECODE – learn how to add if-then-else logic to a SQL query.
-- *    NVL – return the first argument if it is not null, otherwise, returns the second argument.
-- *    NVL2 – show you how to substitute a null value with various options.(1,2,3)
-- *    NULLIF – return a null if the first argument equals the second one, otherwise, returns the first argument.


-- coalesce: return the first non-null value in a list
SELECT COALESCE(NULL, NULL, NULL, 'A', 'B', 'C') FROM dual; -- A
SELECT COALESCE(NULL, NULL, NULL, NULL, NULL, NULL) FROM dual; -- null

-- nvl(a, b): 
-- If a is not null, then nvl(a, b) returns a.
-- nvl(a, b) returns b.

SELECT NVL(100,200)
FROM dual; -- 100

SELECT NVL(NULL, 'a is null && i"m b')
FROM dual;


SELECT
    order_id,
    NVL(first_name, 'Not Assigned')
FROM
    orders
LEFT JOIN employees
ON
    employee_id = salesman_id
WHERE
    EXTRACT(YEAR FROM order_date) = 2016
ORDER BY
    order_date;


SELECT
    order_id,
    CASE
        WHEN first_name IS NOT NULL
        THEN first_name
        ELSE 'Not Assigned'
    END
FROM
    orders
LEFT JOIN employees
    ON employee_id = salesman_id
WHERE
    EXTRACT(YEAR FROM order_date) = 2016
ORDER BY
    order_date;  

-- nvl2(a, b, c) - ternary operator but not experession:
SELECT NVL2(condition if true 1 else 2, 1, 2) FROM dual;  --1
SELECT NVL2('not null', 1, 2) FROM dual;  --1
SELECT NVL2(NULL, 1, 2) FROM dual;  --2


-- nullif(a, b): return a if not equal else null:
SELECT NULLIF(10,'20')
FROM dual;

SELECT NULLIF(100,100) -- null
FROM dual;

SELECT NULLIF(100,200) -- null
FROM dual;

-- decode(a, b, c): if a = b then c else a
SELECT DECODE(1, 1, 'One')
FROM dual; -- One
SELECT DECODE(2, 1, 'One',  2, 'Two')
FROM dual; -- Two

DECODE(NULL,NULL,'Equal','Not equal')

DECODE(country_id, 
    'US','United States', 
    'UK', 'United Kingdom', 
    'JP','Japan', 
    'CA', 'Canada', 
    'CH','Switzerland', 
    'IT', 'Italy', country_id) AS country

SELECT customer_id,
    DECODE(credit_rating,
            'A', 'Excellent',
            'B', 'Good',
            'C', 'Fair',
            'D', 'Needs Improvement',
            'Other', 'Unknown') AS credit_status
FROM customers;




DECLARE
  my_constant CONSTANT NUMBER := NULL;
BEGIN
  -- Attempting to change the value of the constant will result in a compilation error
--   my_constant := 10;
    DBMS_OUTPUT.PUT_LINE('The value of my_constant is ' || my_constant);
END;



select 1234 from dual
UNION ALL
select 1234 from dual
union
select 1234 from dual
union
select 1234 from dual
INTERSECT
select 1234 from dual
union
select 1234 from dual;