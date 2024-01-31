CREATE VIEW employee_yos AS
SELECT first_name || ' ' || last_name AS employee_name, CURRENT_DATE
FROM customers_S2;


CREATE VIEW employee_yos (employee_name, toDay) AS
SELECT first_name || ' ' || last_name AS employee_name, CURRENT_DATE
FROM customers_S2
ORDER BY employee_name;

DROP VIEW employee_yos;


SELECT * FROM employee_yos;

CREATE OR REPLACE VIEW backlogs AS
SELECT 
    product_name,
    EXTRACT( YEAR from order_date) YEAR,
    SUM(quantity * unit_price) amount
FROM orders
INNER JOIN order_items USING(order_id)
INNER JOIN products USING(product_id)
WHERE status = 'Pending'
GROUP BY EXTRACT(YEAR FROM order_data), product_name;


-- update or delete
UPDATE or DELETE employee_yos
[same as tables];

