-- Insert data into product_info table
INSERT INTO product_info (product_id, product_desc, product_price) VALUES (101, 'Laptop', 1200.00);
INSERT INTO product_info (product_id, product_desc, product_price) VALUES (102, 'Smartphone', 700.00);
INSERT INTO product_info (product_id, product_desc, product_price) VALUES (103, 'Headphones', 50.00);
INSERT INTO product_info (product_id, product_desc, product_price) VALUES (104, 'Tablet', 300.00);
INSERT INTO product_info (product_id, product_desc, product_price) VALUES (105, 'Printer', 200.00);

-- Insert data into customer_info table
INSERT INTO customer_info (customer_id, customer_name, customer_state) VALUES (201, 'John Smith', 'California');
INSERT INTO customer_info (customer_id, customer_name, customer_state) VALUES (202, 'Alice Johnson', 'New York');
INSERT INTO customer_info (customer_id, customer_name, customer_state) VALUES (203, 'Bob Miller', 'Texas');
INSERT INTO customer_info (customer_id, customer_name, customer_state) VALUES (204, 'Emily Brown', 'Florida');
INSERT INTO customer_info (customer_id, customer_name, customer_state) VALUES (205, 'Daniel Kim', 'Illinois');

-- Insert data into order_info table
INSERT INTO order_info (order_id, order_date, customer_id) VALUES (301, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 201);
INSERT INTO order_info (order_id, order_date, customer_id) VALUES (302, TO_DATE('2024-02-02', 'YYYY-MM-DD'), 202);
INSERT INTO order_info (order_id, order_date, customer_id) VALUES (303, TO_DATE('2024-02-03', 'YYYY-MM-DD'), 203);
INSERT INTO order_info (order_id, order_date, customer_id) VALUES (304, TO_DATE('2024-02-04', 'YYYY-MM-DD'), 204);
INSERT INTO order_info (order_id, order_date, customer_id) VALUES (305, TO_DATE('2024-02-05', 'YYYY-MM-DD'), 205);

-- Insert data into order_Product table
INSERT INTO order_Product (product_id, order_id, quantity) VALUES (101, 301, 2);
INSERT INTO order_Product (product_id, order_id, quantity) VALUES (103, 301, 1);
INSERT INTO order_Product (product_id, order_id, quantity) VALUES (102, 302, 3);
INSERT INTO order_Product (product_id, order_id, quantity) VALUES (105, 303, 1);
INSERT INTO order_Product (product_id, order_id, quantity) VALUES (104, 304, 2);
INSERT INTO order_Product (product_id, order_id, quantity) VALUES (101, 305, 1);
INSERT INTO order_Product (product_id, order_id, quantity) VALUES (103, 305, 2);
