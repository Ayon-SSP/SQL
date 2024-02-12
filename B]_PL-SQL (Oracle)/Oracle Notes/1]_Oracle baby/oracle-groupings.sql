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
GROUP BY ROLLUP(Region, Product);

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