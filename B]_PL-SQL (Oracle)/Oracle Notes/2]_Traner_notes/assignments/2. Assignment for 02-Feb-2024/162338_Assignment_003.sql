--Assignment_003   2-FEB-24
-- ADD RECORDS

-- product_info
-- product_id(pk)	product_desc	product_price
-- 101              Laptop	        1200.00
-- 102              Smartphone	    700.00
-- 103              Headphones	    50.00
-- 104              Tablet	        300.00
-- 105              Printer	        200.00

-- Insert data into product_info table
INSERT INTO product_info (product_desc, product_price)
VALUES ('Laptop', 1200.00);
INSERT INTO product_info (product_desc, product_price)
VALUES ('Smartphone', 700.00);
INSERT INTO product_info (product_desc, product_price)
VALUES ('Headphones', 50.00);
INSERT INTO product_info (product_desc, product_price)
VALUES ('Tablet', 300.00);
INSERT INTO product_info (product_desc, product_price)
VALUES ('Printer', 200.00);


-- customer_info		
-- customer_id(pk)	customer_name	customer_state
-- 201              John Smith	    California
-- 202              Alice Johnson	New York
-- 203              Bob Miller	    Texas
-- 204              Emily Brown	    Florida
-- 205              Daniel Kim	    Illinois

-- Insert data into customer_info table
INSERT INTO customer_info (customer_name, customer_state)
VALUES ('John Smith', 'California');
INSERT INTO customer_info (customer_name, customer_state)
VALUES ('Alice Johnson', 'New York');
INSERT INTO customer_info (customer_name, customer_state)
VALUES ('Bob Miller', 'Texas');
INSERT INTO customer_info (customer_name, customer_state)
VALUES ('Emily Brown', 'Florida');
INSERT INTO customer_info (customer_name, customer_state)
VALUES ('Daniel Kim', 'Illinois');



-- order_info		
-- order_id(pk)     order_date	    customer_id(fk) 
-- 301	            2024-02-01      201
-- 302	            2024-02-02      202
-- 303	            2024-02-03      203
-- 304	            2024-02-04      204
-- 305	            2024-02-05      205

-- Insert data into order_info table
INSERT INTO order_info (order_date, customer_id)
VALUES (TO_DATE('2024-02-01', 'YYYY-MM-DD'), 201);
INSERT INTO order_info (order_date, customer_id)
VALUES (TO_DATE('2024-02-02', 'YYYY-MM-DD'), 202);
INSERT INTO order_info (order_date, customer_id)
VALUES (TO_DATE('2024-02-03', 'YYYY-MM-DD'), 203);
INSERT INTO order_info (order_date, customer_id)
VALUES (TO_DATE('2024-02-04', 'YYYY-MM-DD'), 204);
INSERT INTO order_info (order_date, customer_id)
VALUES (TO_DATE('2024-02-05', 'YYYY-MM-DD'), 205);


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
INSERT INTO order_Product (product_id, order_id, quantity)
VALUES (101, 301, 2);
INSERT INTO order_Product (product_id, order_id, quantity)
VALUES (103, 301, 1);
INSERT INTO order_Product (product_id, order_id, quantity)
VALUES (102, 302, 3);
INSERT INTO order_Product (product_id, order_id, quantity)
VALUES (105, 303, 1);
INSERT INTO order_Product (product_id, order_id, quantity)
VALUES (104, 304, 2);
INSERT INTO order_Product (product_id, order_id, quantity)
VALUES (101, 305, 1);
INSERT INTO order_Product (product_id, order_id, quantity)
VALUES (103, 305, 2);
