--Assignment_003   2-FEB-24
-- ADD RECORDS: https://www.geeksengine.com/database/problem-solving/northwind-queries-part-2.php

-- product_info
-- product_id(pk)	product_desc	product_price
-- 101              Laptop	        1200.00
-- 102              Smartphone	    700.00
-- 103              Headphones	    50.00
-- 104              Tablet	        300.00
-- 105              Printer	        200.00

-- Insert data into product_info table
INSERT ALL
    INTO product_info (product_desc, product_price) VALUES ('Laptop', 1200.00)
    INTO product_info (product_desc, product_price) VALUES ('Smartphone', 700.00)
    INTO product_info (product_desc, product_price) VALUES ('Headphones', 50.00)
    INTO product_info (product_desc, product_price) VALUES ('Tablet', 300.00)
    INTO product_info (product_desc, product_price) VALUES ('Printer', 200.00)
SELECT 1 FROM DUAL;

-- customer_info		
-- customer_id(pk)	customer_name	customer_state
-- 201              John Smith	    California
-- 202              Alice Johnson	New York
-- 203              Bob Miller	    Texas
-- 204              Emily Brown	    Florida
-- 205              Daniel Kim	    Illinois

-- Insert data into customer_info table
INSERT ALL
    INTO customer_info (customer_name, customer_state) VALUES ('John Smith', 'California')
    INTO customer_info (customer_name, customer_state) VALUES ('Alice Johnson', 'New York')
    INTO customer_info (customer_name, customer_state) VALUES ('Bob Miller', 'Texas')
    INTO customer_info (customer_name, customer_state) VALUES ('Emily Brown', 'Florida')
    INTO customer_info (customer_name, customer_state) VALUES ('Daniel Kim', 'Illinois')
SELECT 1 FROM DUAL;



-- order_info		
-- order_id(pk)     order_date	    customer_id(fk) 
-- 301	            2024-02-01      201
-- 302	            2024-02-02      202
-- 303	            2024-02-03      203
-- 304	            2024-02-04      204
-- 305	            2024-02-05      205

-- Insert data into order_info table
INSERT ALL
    INTO order_info (order_date, customer_id) VALUES (TO_DATE('2024-02-01', 'YYYY-MM-DD'), 201)
    INTO order_info (order_date, customer_id) VALUES (TO_DATE('2024-02-02', 'YYYY-MM-DD'), 202)
    INTO order_info (order_date, customer_id) VALUES (TO_DATE('2024-02-03', 'YYYY-MM-DD'), 203)
    INTO order_info (order_date, customer_id) VALUES (TO_DATE('2024-02-04', 'YYYY-MM-DD'), 204)
    INTO order_info (order_date, customer_id) VALUES (TO_DATE('2024-02-05', 'YYYY-MM-DD'), 205)
SELECT 1 FROM DUAL;


-- order_Product		
-- product_id(fk)   order_id(fk)     quantity
-- 101	            301               2
-- 103	            301               1
-- 102	            302               3
-- 105	            303               1
-- 104	            304               2
-- 101	            305               1
-- 103	            305               2

-- Insert data into order_Product table
INSERT ALL
    INTO order_Product (product_id, order_id, quantity) VALUES (101, 301, 2)
    INTO order_Product (product_id, order_id, quantity) VALUES (103, 301, 1)
    INTO order_Product (product_id, order_id, quantity) VALUES (102, 302, 3)
    INTO order_Product (product_id, order_id, quantity) VALUES (105, 303, 1)
    INTO order_Product (product_id, order_id, quantity) VALUES (104, 304, 2)
    INTO order_Product (product_id, order_id, quantity) VALUES (101, 305, 1)
    INTO order_Product (product_id, order_id, quantity) VALUES (103, 305, 2)
SELECT 1 FROM DUAL;
