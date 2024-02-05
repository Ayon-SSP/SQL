--Assignment_004   2-FEB-24
--SQL QUERIES

-- 1. Select all products with a price greater than $100
SELECT product_id, product_id
FROM product_info 
WHERE product_price > 100;

-- 2. Retrieve orders placed after '2024-02-02' //and also give the product_desc whith it's product_id
SELECT *
FROM order_info
WHERE order_date > TO_DATE('2024-02-02', 'YYYY-MM-DD');
-- -<or>-
SELECT order_info.order_id, order_product.product_id, product_info.product_desc
FROM order_info
JOIN order_Product
ON order_info.order_id = order_Product.order_id
JOIN product_info
ON order_Product.product_id = product_info.product_id
WHERE order_date > TO_DATE('2024-02-02', 'YYYY-MM-DD');


-- 3. List customers from 'New York'
SELECT customer_name
FROM customer_info
WHERE customer_state = 'New York';

-- 4. Show products and their quantities where quantity is not null
SELECT product_id, quantity
from  order_Product
WHERE quantity IS NOT NULL;

-- 5. Retrieve orders placed by customers from 'California'
SELECT *
FROM customer_info
WHERE customer_state = 'California';
-- -<or>-
SELECT *
FROM product_info
WHERE product_id IN (
    SELECT product_id
    FROM order_Product
    WHERE order_id IN (
        SELECT order_id
        FROM order_info
        WHERE customer_id IN (
            SELECT customer_id 
            FROM customer_info 
            WHERE customer_state = 'California'
        )
    )
);

-- 6. Find products with a price less than or equal to $200 and in stock
SELECT *
FROM product_info
WHERE product_price <= 200;

-- 7. Calculate the total quantity of products in all orders
SELECT SUM(quantity) AS total_quantity
FROM order_Product;

-- 8. Display distinct product descriptions
SELECT DISTINCT product_desc
FROM product_info;

-- 9. Find the average price of products
SELECT AVG(product_price) AS average_price
FROM product_info;

-- 10. Show products and their quantities, replacing null quantities with 0 
SELECT product_id, NVL(quantity, 0) AS quantity
FROM order_Product;

-- 11. Retrieve the first 5 products in the Product_Info table
SELECT *
FROM product_info
WHERE ROWNUM <= 5;

-- 12. Display orders with quantities sorted in descending order:
SELECT order_id, quantity
FROM order_Product
ORDER BY quantity DESC;
-- -<or>-
SELECT order_id, quantity
FROM order_Product
FETCH FIRST 5 ROWS ONLY;

-- 13. Retrieve products with descriptions containing 'Phone'
SELECT product_id, product_desc
FROM product_info
WHERE product_desc LIKE '%Phone%';

-- 14. Find customers in 'California' or 'New York'
SELECT customer_name, customer_state
FROM customer_info
WHERE customer_state IN ('California', 'New York');

-- 15. Show products with prices between $100 and $500
SELECT product_id, product_desc, product_price
FROM product_info
WHERE product_price BETWEEN 100 AND 500;

-- 16. List orders placed between '2024-02-02' and '2024-02-05'
SELECT order_id, order_date
FROM order_info
WHERE order_date BETWEEN TO_DATE('2024-02-02', 'YYYY-MM-DD') AND TO_DATE('2024-02-05', 'YYYY-MM-DD');

-- 17. Retrieve orders with quantities not between 1 and 5
SELECT order_id, quantity
FROM order_Product
WHERE quantity NOT BETWEEN 1 AND 5;

-- 18. Display products with prices increased by 10%, handling null prices
SELECT product_id, product_desc, 
        CASE WHEN product_price IS NULL THEN NULL
          ELSE product_price * 1.1
        END AS increased_price
FROM product_info;
-- END: ed8c6549bwf9

-- 19. Find the average quantity of products in orders
SELECT AVG(quantity) AS average_quantity
FROM order_Product;

-- 20. Show orders with dates one week ahead of '2024-02-01'
SELECT order_id, order_date
FROM order_info
WHERE order_date BETWEEN TO_DATE('2024-02-01', 'YYYY-MM-DD') AND TO_DATE('2024-02-01', 'YYYY-MM-DD') + 7;
