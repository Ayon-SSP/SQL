--Assignment_005   2-FEB-24
--SQL QUERIES

-- 21. List customers with names in uppercase
SELECT UPPER(customer_name) AS customer_name
FROM customer_info;

-- 22. Retrieve products with descriptions starting with 'Lap'
SELECT product_id, product_desc
FROM product_info
WHERE product_desc LIKE 'Lap%';
-- 23. Find customers with names ending in 'son'
SELECT customer_name
FROM customer_info
WHERE customer_name LIKE '%son';

-- 24. Display orders placed on the last day of each month
SELECT *
FROM order_info
WHERE  EXTRACT(DAY FROM order_date  + 1) = 1;
-- using last_day function
SELECT *
FROM order_info
WHERE order_date = LAST_DAY(order_date);

-- 25. Show products with prices rounded to the nearest integer
SELECT product_id, product_desc, ROUND(product_price) AS rounded_price
FROM product_info;

-- 26. Retrieve customers with states replaced by their first two characters
SELECT customer_name, SUBSTR(customer_state, 1, 2) AS state
FROM customer_info;

-- 27. List orders with quantities multiplied by 2
SELECT order_id, quantity * 2 AS multiplied_quantity
FROM order_Product;