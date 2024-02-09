/*

* refere gaurav's notes romee
* view's are also called as virtual tables 
*     (Virtual/logical table) or 
*     (database object) 
*     (virtual entity) 
*     (no space is taken, extract data from table) 
*     (slow results because it renders the info from the exst table)
*     dependent logical object
*     may or may not allow DML
* only the definition of a view is stored in the data dictionary, it doew not actually exist as a separate tables
* Oracle allows the creation of an object called view
* Types of Views
*     Simple View: contains only one table, no group by, no aggregate functions, no subqueries
*     Complex View: contains more than one table, group by, aggregate functions, subqueries
*     Read Only View(Non-updatable view): (only allows SELECT)does not allow DML operations
*     Updatable View: allows DML operations
*           (INSERT, UPDATE, DELETE are actually happening on the table on which it is created), 
*           (thease view contains pk and all not null columns of the base table)  
*           syntzx: WITH CHECK OPTION;
*     Inline View: a subquery in the FROM clause of a SELECT statement
*     Materialized View: stores the result of a query in a table, stores the definition and data, if changed then replaced
*           oracle uses materialized view it creates a snapshorts in prior.
            create materialized view mview as select ...;

*/
CREATE VIEW employee_yos AS
SELECT first_name || ' ' || last_name AS employee_name, CURRENT_DATE
FROM customers_S2;


CREATE OR REPLACE VIEW employee_yos (employee_name, toDay) AS
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


-- create a materialized view emp
CREATE MATERIALIZED VIEW MempView AS
SELECT * FROM emp; -- base tables and stored on the disk

-- faster in execution



-- Inline View in Oracle
-- a subquery in the FROM clause of a SELECT statement
