-- [ChatGPT](https://chat.openai.com/c/b9353eb4-fce8-45d9-ad2c-f1456d96034f)
-- https://youtu.be/CCm4IY-Ntfw?si=v5JxQ_b-tFjCsoEB
-- Groupings
-- Grouping sets – introduce you to the grouping set concepts and show you how to generate multiple grouping sets in a query.
    -- GROUP BY
    -- GROUPING SETS(
    --     (), 
    --     (c1), 
    --     (c2), 
    --     (c1,c2), 
    --     (c1,c2,c3)
    -- )
/*
| Region  | Product | Sales |
|---------|---------|-------|
| North   | A       | 100   |
| North   | B       | 150   |
| South   | A       | 200   |
| South   | B       | 250   |



SELECT Region, Product, SUM(Sales) AS TotalSales
FROM sales
GROUP BY GROUPING SETS ((Region, Product), (Region), ());



| Region  | Product | TotalSales |
|---------|---------|------------|
| North   | A       | 100        |
| North   | B       | 150        |
| South   | A       | 200        |
| South   | B       | 250        |
| North   | NULL    | 250        |  -- Subtotal for North
| South   | NULL    | 450        |  -- Subtotal for South
| NULL    | NULL    | 700        |  -- Grand Total

*/

CREATE TABLE sales (
    region VARCHAR2(50),
    product VARCHAR2(50),
    amount NUMBER
);

INSERT INTO sales (region, product, amount) VALUES ('North', 'Product A', 100);
INSERT INTO sales (region, product, amount) VALUES ('North', 'Product B', 200);
INSERT INTO sales (region, product, amount) VALUES ('South', 'Product A', 150);
INSERT INTO sales (region, product, amount) VALUES ('South', 'Product B', 250);
INSERT INTO sales (region, product, amount) VALUES ('East', 'Product A', 300);
INSERT INTO sales (region, product, amount) VALUES ('West', 'Product B', 100);
INSERT INTO sales (region, product, amount) VALUES ('West', 'Product C', 200);
INSERT INTO sales (region, product, amount) VALUES ('North', 'Product A', 1);

SELECT SUM(amount) AS total
FROM sales
-- GROUP BY GROUPING SETS ((region, product));
-- -<or>-
-- GROUP BY GROUPING SETS ((region, product), (region), ());

select job, sum(sal) from EMP group by grouping sets((job));




-- ROLLUP – describe how to calculate multiple levels of subtotals across a specified group of dimensions.
    -- gives the subtotals with group by granttotal
/*
| Region  | Product | Sales |
|---------|---------|-------|
| North   | A       | 100   |
| North   | B       | 150   |
| South   | A       | 200   |
| South   | B       | 250   |

SELECT Region, Product, SUM(Sales) AS TotalSales
FROM sales
GROUP BY ROLLUP((Region, Product),(Region),(Product),());

| Region  | Product | TotalSales |
|---------|---------|------------|
| North   | A       | 100        |
| North   | B       | 150        |
| North   | NULL    | 250        |  -- Subtotal for North
| South   | A       | 200        |
| South   | B       | 250        |
| South   | NULL    | 450        |  -- Subtotal for South
| NULL    | NULL    | 700        |  -- Grand Total
*/

SELECT Region, SUM(amount) AS TotalSales
FROM Sales
GROUP BY ROLLUP(Region);

SELECT Region, Product, MAX(amount) AS TotalSales
FROM Sales
GROUP BY ROLLUP(Region, Product); -- ROLLUP: gp by ((Region, Product),(Region),()); - but for cube gp by ((Region, Product),(Region),(Product),());

-- ROLLUP: a, b, c, d -> a, b, c, d || a, b, c || a, b || a
-- CUBE: a, b, c, d -> a, b, c, d || a, b, c || b, c d || a, b d || a, c, d || b, c || a, d || b, d || c, d || a, b || a, c || a, d || b, c || b, d || c, d || a || b || c || d || ()



select * from sales;



-- CUBE – learn how to use CUBE to generate subtotals for all possible combinations of a specified group of dimensions.
/*
| Region  | Product | Sales |
|---------|---------|-------|
| North   | A       | 100   |
| North   | B       | 150   |
| South   | A       | 200   |
| South   | B       | 250   |

SELECT Region, Product, SUM(Sales) AS TotalSales
FROM sales
GROUP BY CUBE(Region, Product);

| Region  | Product | TotalSales |
|---------|---------|------------|
| North   | A       | 100        |
| North   | B       | 150        |
| South   | A       | 200        |
| South   | B       | 250        |
| North   | NULL    | 250        |  -- Subtotal for North
| South   | NULL    | 450        |  -- Subtotal for South
| NULL    | A       | 300        |  -- Subtotal for A
| NULL    | B       | 400        |  -- Subtotal for B
| NULL    | NULL    | 700        |  -- Grand Total

*/
SELECT Region, Product, SUM(amount) AS TotalSales
FROM Sales
GROUP BY CUBE(Region, Product);




-- PIVOT – show you how to transpose rows to columns to make the crosstab reports.
/*
| Region  | Product | Sales |
|---------|---------|-------|
| North   | A       | 100   |
| North   | B       | 150   |
| South   | A       | 200   |
| South   | B       | 250   |

SELECT *
FROM (
    SELECT Region, Product, Sales
    FROM sales
)
PIVOT (
    SUM(Sales)
        FOR Product IN ('A' AS A_Sales, 'B' AS B_Sales)
);

| REGION | A_SALES | B_SALES |
|--------|---------|---------|
| North  | 100     | 150     |
| South  | 200     | 250     |

another Eg: 
| Employee | Month   | Sales |
|----------|---------|-------|
| John     | January | 100   |
| John     | February| 150   |
| John     | March   | 200   |
| Alice    | January | 120   |
| Alice    | February| 180   |
| Alice    | March   | 220   |

SELECT *
FROM (
    SELECT Employee, Month, Sales
    FROM employee_sales
)
PIVOT (
    SUM(Sales)
    FOR Month IN ('January' AS Jan_Sales, 'February' AS Feb_Sales, 'March' AS Mar_Sales)
);





| EMPLOYEE | JAN_SALES | FEB_SALES | MAR_SALES |
|----------|-----------|-----------|-----------|
| John     | 100       | 150       | 200       |
| Alice    | 120       | 180       | 220       |
*/

-- create and inset
-- | Employee | Month   | Sales |
-- |----------|---------|-------|
-- | John     | January | 100   |
-- | John     | February| 150   |
-- | John     | March   | 200   |
-- | Alice    | January | 120   |
-- | Alice    | February| 180   |
-- | Alice    | March   | 220   |
-- | John     | January | 1     |
-- | John     | February| 5     |

-- EMPL JAN FEB MAY
-- JOHN 100 150 200
-- ALICE 120 180 220

DROP TABLE employee_sales;
CREATE TABLE employee_sales (
    Employee VARCHAR2(50),
    Month VARCHAR2(50),
    Sales NUMBER
);

INSERT ALL 
    INTO employee_sales (Employee, Month, Sales) VALUES ('John', 'January', 100)
    INTO employee_sales (Employee, Month, Sales) VALUES ('John', 'February', 150)
    INTO employee_sales (Employee, Month, Sales) VALUES ('John', 'March', 200)
    INTO employee_sales (Employee, Month, Sales) VALUES ('Alice', 'January', 120)
    INTO employee_sales (Employee, Month, Sales) VALUES ('Alice', 'February', 180)
    INTO employee_sales (Employee, Month, Sales) VALUES ('Alice', 'March', 220)
    INTO employee_sales (Employee, Month, Sales) VALUES ('John', 'January', 1)
    INTO employee_sales (Employee, Month, Sales) VALUES ('John', 'February', 5)
SELECT * FROM dual;

CREATE VIEW employee_sales_vw AS
SELECT *
FROM (
    SELECT Employee, Month, Sales
    FROM employee_sales
)
PIVOT (
    SUM(Sales)
    FOR Month IN (
        'January' AS Jan_Sales, 
        'February' AS Feb_Sales, 
        'March' AS Mar_Sales
    )
);


SELECT *
FROM (
    SELECT *
    FROM (
        SELECT Employee, Month, Sales
        FROM employee_sales
    )
    PIVOT (
        COUNT(Sales)
        FOR Month IN (
            'January' AS Jan,
            'February' AS Feb,
            'March' AS Mar
        )
    )
)
UNPIVOT (
    sales
    for monthesin in (
        -- OR we can write a subquery hear (select months from month_table)
        Jan,
        Feb,
        Mar
    )
);




-- https://www.oracletutorial.com/oracle-basics/oracle-pivot/
SELECT * FROM order_stats
PIVOT(
    COUNT(order_id) orders,
    SUM(order_value) sales
    FOR category_name
    IN ( 
        'CPU' CPU,
        'Video Card' VideoCard, 
        'Mother Board' MotherBoard,
        'Storage' Storage
    )
)
ORDER BY status;



































-- UNPIVOT – a guide to rotating columns into rows.
/*
| Employee | Jan_Sales | Feb_Sales | Mar_Sales |
|----------|-----------|-----------|-----------|
| John     | 100       | 150       | 200       |
| Alice    | 120       | 180       | 220       |


SELECT Employee, Month, Sales
FROM (
    SELECT *
    FROM employee_sales
) UNPIVOT (
    Sales FOR Month IN (Jan_Sales AS 'January', Feb_Sales AS 'February', Mar_Sales AS 'March')
);

| EMPLOYEE | MONTH    | SALES |
|----------|----------|-------|
| John     | January  | 100   |
| John     | February | 150   |
| John     | March    | 200   |
| Alice    | January  | 120   |
| Alice    | February | 180   |
| Alice    | March    | 220   |
*/

SELECT *
FROM employee_sales_vw;

SELECT *
FROM employee_sales_vw
UNPIVOT (
    sales 
    FOR month_sales IN (Jan_Sales, Feb_Sales, Mar_Sales)
);


-- https://www.oracletutorial.com/oracle-basics/oracle-unpivot/
SELECT * FROM sale_stats
UNPIVOT (
    (quantity, amount)
    FOR product_code
    IN (
        (a_qty, a_value) AS 'A', 
        (b_qty, b_value) AS 'B'        
    )
);