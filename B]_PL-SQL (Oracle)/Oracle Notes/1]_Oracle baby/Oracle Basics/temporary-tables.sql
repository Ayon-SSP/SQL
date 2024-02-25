-- Temporary Tables
/*
Oracle Global Temporary Table:
    - structure of the table accessible to all users but not the data, every user has their own data

*/

-- Create a Global Temporary Table
CREATE GLOBAL TEMPORARY TABLE temp_orders (
    order_id NUMBER,
    product_name VARCHAR2(100),
    quantity NUMBER
) ON COMMIT DELETE ROWS;

-- Insert data into the temporary table
INSERT INTO temp_orders (order_id, product_name, quantity)
VALUES (1, 'Product A', 10);

-- Select data from the temporary table
SELECT * FROM temp_orders;

-- Output:
-- ORDER_ID   PRODUCT_NAME   QUANTITY
-- 1          Product A      10

-- Data in the temporary table will be automatically deleted at the end of the session or when explicitly deleted.


-- Oracle Private Temporary Table
CREATE PRIVATE TEMPORARY TABLE table_name(
    column_definition,
    ...
) ON COMMIT [DROP DEFINITION | PRESERVE DEFINITION];
-- ON COMMIT DROP DEFINITION/ON COMMIT PRESERVE DEFINITION