
-- Modifying data

-- INSERT – learn how to insert a row into a table.
INSERT INTO table_name (column_list)
VALUES( value_list);

INSERT INTO discounts(discount_name, amount, start_date, expired_date)
VALUES('Summer Promotion', 9.5, DATE '2017-05-01', DATE '2017-08-31');


-- INSERT INTO SELECT – insert data into a table from the result of a query.
INSERT INTO target_table [(col1, col2, col3)]
SELECT 
    col1,
    col2,
    col3
FROM source_table
WHERE condition;

-- INSERT ALL – discuss multitable insert statement to insert multiple rows into a table or multiple tables.
INSERT ALL
    INTO table_name(col1,col2,col3) VALUES(val1,val2, val3)
    INTO table_name(col1,col2,col3) VALUES(val4,val5, val6)
    INTO table_name(col1,col2,col3) VALUES(val7,val8, val9)
Subquery; -- SELECT * FROM dual;

CREATE TABLE medium_orders AS
SELECT *
FROM small_orders;


-- ALL: In this example, if both condition1 and condition2 are true for a row in the source_table, INSERT ALL will insert that row into both table_1 and table_2.
INSERT ALL
    WHEN condition1 THEN
        INTO table_1 (column_list) VALUES (value_list)
    WHEN condition2 THEN 
        INTO table_2 (column_list) VALUES (value_list)
    ELSE
        INTO table_3 (column_list) VALUES (value_list)
SELECT * FROM source_table;

-- FIRST: In this example, if both condition1 and condition2 are true for a row in the source_table, only the INSERT INTO clause corresponding to condition1 will be executed, and the row will be inserted into table_1.
INSERT FIRST
    WHEN condition1 THEN
        INTO table_1 (column_list) VALUES (value_list)
    WHEN condition2 THEN 
        INTO table_2 (column_list) VALUES (value_list)
    ELSE
        INTO table_3 (column_list) VALUES (value_list)
SELECT * FROM source_table;

INSERT ALL
    WHEN amount < 10000 THEN
        INTO small_orders
    WHEN amount >= 10000 AND amount <= 30000 THEN
        INTO medium_orders
    WHEN amount > 30000 THEN
        INTO big_orders
        
SELECT 
    order_id,
    customer_id,
    (quantity * unit_price) amount
FROM orders
INNER JOIN order_items USING(order_id);
