--Assignment   14-FEB-24 
--SQL QUERIES: Using Grouping Additional Functions: Grouping sets, grouping, Grouping_Id, cube, rolup, pivot, unpivote 

-- 1. Calculate the total sales amount for each employee along with a flag indicating if the employee has more than 50 orders
SELECT 
    E.EmployeeID,
    COUNT(O.OrderID) AS TotalOrders,
    -- ROUND(SUM((OD.Quantity * OD.UnitPrice) * (1 - OD.Discount)), 2) AS TotalSales,
    ROUND(SUM((OD.Quantity * OD.UnitPrice)), 2) AS TotalSales,
    CASE 
        WHEN COUNT(O.OrderID) > 50 THEN 'MORE THAN 50 ORDERS'
        WHEN COUNT(O.OrderID) < 50 THEN 'LESS THAN 50 ORDERS'
        ELSE '50'
    END AS Orders_more_than50
FROM Employees E
LEFT JOIN Orders O ON E.EmployeeID = O.EmployeeID
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY GROUPING SETS((E.EmployeeID))
ORDER BY E.EmployeeID;

-- 2. Calculate the total number of orders and total sales amount for each customer who has placed orders in 1997
SELECT 
    C.CustomerID,
    COUNT(DISTINCT O.OrderID) AS TotalOrders,
    ROUND(SUM(OD.Quantity * OD.UnitPrice), 2) AS TotalSalesAmount
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
WHERE EXTRACT(YEAR FROM O.OrderDate) = '1997'
GROUP BY GROUPING SETS((C.CustomerID))
ORDER BY C.CustomerID;

-- 3. Count the number of orders for each product category, and include a summary row showing the total number of orders for all categories
SELECT 
    CT.CategoryName,
    COUNT(OD.OrderID) AS TotalOrders
FROM Categories CT
LEFT JOIN Products P ON CT.CategoryID = P.CategoryID
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY GROUPING SETS((CT.CategoryName));

-- 4. Calculate the total sales amount for each product category, and indicate if the total sales amount is greater than $1000 
SELECT 
    CT.CategoryName,
    COUNT(OD.OrderID) AS TotalOrders,
    ROUND(SUM(OD.Quantity * OD.UnitPrice), 2) AS TotalSalesAmount,
    CASE
        WHEN ROUND(SUM(OD.Quantity * OD.UnitPrice), 2) > 1000 THEN 'YES'
        ELSE 'NO'
    END
FROM Categories CT
LEFT JOIN Products P ON CT.CategoryID = P.CategoryID
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY GROUPING SETS((CT.CategoryName));

-- 5. Calculate the average order value for each customer, and include a summary row for the overall average order value
SELECT
    C.CustomerID,
    ROUND(SUM(OD.Quantity * OD.UnitPrice)/COUNT(DISTINCT O.OrderID), 2) AS TotalSalesAmount
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY GROUPING SETS((C.CustomerID))
ORDER BY C.CustomerID;

-- 6. Calculate the total sales amount for each employee along with subtotals by country(customers) and a grand total
SELECT
    E.EmployeeID,
    C.Country,
    ROUND(SUM(OD.Quantity * OD.UnitPrice), 2) AS TotalSalesAmount
FROM Employees E
INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY ROLLUP(E.EmployeeID, C.Country);

-- 7. Count the total number of orders for each product category, subtotaled by year, and provide a grand total: 
SELECT 
  CT.CategoryName,
  EXTRACT(YEAR FROM O.OrderDate) AS OrderYear,
  COUNT(O.OrderID) AS TotalOrder
FROM Categories CT
LEFT JOIN Products P ON CT.CategoryID = P.CategoryID
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
LEFT JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY ROLLUP(
  CT.CategoryName,
  EXTRACT(YEAR FROM O.OrderDate)
)
ORDER BY CT.CategoryName;

-- 8. Calculate the total sales amount for each shipper, subtotaled by region, and a grand total
SELECT *
FROM (SELECT 
  S.CompanyName AS SHIPPER,
  O.Shipregion AS REGION,
SUM(OD.UnitPrice * OD.Quantity) AS TotalSalesAmount
FROM Shippers S
INNER JOIN Orders O ON S.ShipperID = O.shipvia
INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY ROLLUP(S.CompanyName, O.Shipregion));

-- 9. Count the total number of orders for each customer, subtotaled by month, and provide a grand total 
SELECT 
  C.CustomerID,
  EXTRACT(MONTH FROM O.Orderdate) AS OrderMonth,
  COUNT(O.OrderID) AS TotalOrders
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY ROLLUP(
  C.CustomerID,
  EXTRACT(MONTH FROM O.OrderDate)
)
ORDER BY C.CustomerID;

-- 10. Calculate the total sales amount for each product, subtotaled by country, and provide a grand total
SELECT
  P.ProductName,
  O.Shipcountry AS Country,
  SUM(OD.Quantity * OD.UnitPrice) AS TotalSalesAmount
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY ROLLUP(
  P.ProductName, 
  O.ShipCountry
);

-- 11. Calculate the total sales amount for each product category and year
WITH category_year_sales AS (
  SELECT
    C.CategoryName,
    EXTRACT(YEAR FROM O.OrderDate) AS SaleYear,
    SUM(OD.UnitPrice * OD.Quantity) AS TotalSalesAmount
  FROM Categories C
  INNER JOIN Products P ON C.CategoryID = P.CategoryID
  INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
  INNER JOIN Orders O ON OD.OrderID = O.OrderID
  GROUP BY GROUPING SETS((C.CategoryName, Extract(year from o.orderdate)))
)

SELECT *
FROM category_year_sales
PIVOT(
  SUM(TotalSalesAmount)
  FOR SaleYear IN (
      1996 AS "1996",
      1997 AS "1997",
      1998 AS "1998",
      1999 AS "1999",
      2000 AS "2000"

  )
)
ORDER BY CategoryName;

-- 12. Calculate the total quantity sold for each product category and month 
WITH category_month_sales AS (
  SELECT
    C.CategoryName,
    SUM(OD.Quantity) AS quantity_sum,
    TO_CHAR(O.OrderDate, 'Mon') AS order_month
  FROM Categories C
  INNER JOIN Products P ON C.CategoryID = P.CategoryID
  INNER JOIN OrderDetails OD ON P.ProductID = OD.ProductID
  INNER JOIN Orders O ON OD.OrderID = O.OrderID
  GROUP BY GROUPING SETS((C.CategoryName, TO_CHAR(O.OrderDate, 'Mon')))
)

SELECT *
FROM category_month_sales
PIVOT(
  SUM(quantity_sum)
  FOR order_month IN (
    'Jan' as "Jan",
    'Feb' as "Feb",
    'Mar' as "Mar",
    'Apr' AS "Apr",
    'May' AS "May",
    'Jun' AS "Jun",
    'Jul' AS "Jul",
    'Aug' AS "Aug",
    'Sep' AS "Sep",
    'Oct' AS "Oct",
    'Nov' AS "Nov",
    'Dec' AS "Dec"
  )
)
ORDER BY CategoryName;

-- 13. Count the total number of orders for each shipper and country
WITH cnt_com_ordercount AS (
  SELECT
    S.CompanyName,
    O.ShipCountry AS Country,
    COUNT(O.OrderID) AS OrderCount
  FROM Shippers S
  INNER JOIN Orders O ON S.ShipperID = O.ShipVia
  GROUP BY GROUPING SETS((S.CompanyName, O.ShipCountry))
)

SELECT *
FROM cnt_com_ordercount
PIVOT(
  COUNT(OrderCount)
  FOR Country IN (
    'USA' AS "USA",
    'Canada' AS "Canada",
    'UK' AS "UK",
    'Germany' AS "Germany",
    'France' AS "France"
  )
)
ORDER BY CompanyName;

-- 14. Calculate the total sales amount for each employee and year
WITH emp_year_sales AS (
  SELECT
    E.EmployeeID,
    EXTRACT(YEAR FROM O.OrderDate) AS OrderYear,
    SUM(OD.UnitPrice * OD.Quantity) AS TotalSalesAmount
  FROM Employees E
  INNER JOIN Orders O ON E.EmployeeID = O.EmployeeID
  INNER JOIN OrderDetails OD ON O.OrderID = OD.OrderID
  GROUP BY GROUPING SETS((E.EmployeeID, EXTRACT(YEAR FROM O.OrderDate)))
)

SELECT *
FROM emp_year_sales
PIVOT(
  SUM(TotalSalesAmount)
  FOR OrderYear IN (
    1996 AS "1996",
    1997 AS "1997",
    1998 AS "1998"
  )
)
ORDER BY EmployeeID;

-- 15. Count the total number of orders for each customer and year
WITH cust_year_ordercount AS (
  SELECT
    C.CustomerID,
    COUNT(O.OrderID) AS OrderCount,
    EXTRACT(YEAR FROM O.OrderDate) AS OrderYear
  FROM Customers C
  INNER JOIN Orders O ON C.CustomerID = O.CustomerID
  GROUP BY GROUPING SETS((C.CustomerID, EXTRACT(YEAR FROM O.OrderDate)))
)

SELECT *
FROM cust_year_ordercount
PIVOT(
  COUNT(OrderCount)
  FOR OrderYear IN (
    1996 AS "1996",
    1997 AS "1997",
    1998 AS "1998",
    1999 AS "1999",
    2000 AS "2000"
  )
)
ORDER BY CustomerID;