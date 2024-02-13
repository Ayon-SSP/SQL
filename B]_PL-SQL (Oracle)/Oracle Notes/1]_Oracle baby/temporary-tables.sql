
-- 0. Global Temporary Tables:
CREATE GLOBAL TEMPORARY TABLE temp1(
    id INT,
    description VARCHAR2(100)
) ON COMMIT DELETE ROWS;


INSERT INTO temp1(id,description)
VALUES(1,'Transaction specific global temp table');

SELECT id, description 
FROM temp1;


COMMIT;

DROP TABLE temp1;


-- 1.Inline Temporary Tables (WITH clause):
-- Define an inline temporary table using the WITH clause
WITH temp_orders AS (
    SELECT order_id, order_date, total_amount
    FROM orders
    WHERE order_date >= DATE '2024-01-01' AND order_date < DATE '2024-02-01'
)
-- Query the inline temporary table
SELECT * FROM temp_orders;


SELECT user_id, COUNT(*)
FROM MovieRating
-- // Remove the unnecessary GROUP BY clause
-- // GROUP BY user_id
FETCH FIRST 1 ROWS ONLY;