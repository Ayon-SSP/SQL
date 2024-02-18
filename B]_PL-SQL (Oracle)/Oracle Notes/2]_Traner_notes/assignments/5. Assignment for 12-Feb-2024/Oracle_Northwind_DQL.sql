--Assignment_010   12-FEB-24 
--SQL QUERIES 

-- -- Oracle Union All
-- Assignment: Write queries to combine the results of two or more SELECT statements, including duplicate rows.
-- 1. List all customers from the USA and Canada.
SELECT * FROM Customers
WHERE Country = 'USA'
UNION ALL
SELECT * FROM Customers
WHERE Country = 'Canada';

-- 2. List all employees from the USA and UK.
SELECT EmployeeID FROM Employees
WHERE Country = 'USA'
UNION ALL 
SELECT EmployeeID FROM Employees
WHERE Country = 'UK';

-- 3. List all products from the 'Beverages' category and 'Confections' category.
SELECT 
  C.CategoryID, 
  C.CategoryName,
  LISTAGG(P.ProductID, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs,
  LISTAGG(P.PRODUCTNAME, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs
FROM CATEGORIES C
INNER JOIN PRODUCTS P
ON C.CategoryID = P.CategoryID
WHERE CategoryName = 'Beverages'
GROUP BY C.CategoryID, C.CategoryName
UNION ALL
SELECT 
  C.CategoryID, 
  C.CategoryName,
  LISTAGG(P.ProductID, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs,
  LISTAGG(P.PRODUCTNAME, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs
FROM CATEGORIES C
INNER JOIN PRODUCTS P
ON C.CategoryID = P.CategoryID
WHERE CategoryName = 'Confections'
GROUP BY C.CategoryID, C.CategoryName;

-- 4. List all orders shipped by 'Speedy Express' and 'United Package'.
SELECT 
  S.CompanyName,
  O.OrderID
FROM Shippers S
INNER JOIN Orders O
ON S.ShipperID = O.ShipVia
WHERE S.CompanyName = 'Speedy Express'
UNION ALL
SELECT 
  S.CompanyName,
  O.OrderID
FROM Shippers S
INNER JOIN Orders O
ON S.ShipperID = O.ShipVia
WHERE S.CompanyName = 'United Package';


-- 5. List all customers and supplierscompany name.
SELECT 
  Cust.CustomerID,
  Cust.CompanyName,
  LISTAGG(S.SupplierID, ', ') WITHIN GROUP (ORDER BY Cust.CustomerID) AS CustomerID,
  LISTAGG(S.CompanyName, ', ') WITHIN GROUP (ORDER BY Cust.CompanyName) AS CompanyName
FROM customers Cust
INNER JOIN Orders O ON Cust.CustomerID = O.CustomerID
INNER JOIN Orderdetails OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
GROUP BY (Cust.CustomerID, Cust.CompanyName); -- There is no customer name How to solve? ⚠️ Nor correct

-- SELECT *
-- FROM Customers
-- UNION ALL
-- SELECT *
-- FROM Suppliers;


-- -- Oracle Intersect: 
-- Assignment: Write queries to find common rows returned by two SELECT statements. 
-- 1. List all customers from the USA and Canada. 
SELECT * FROM Customers
WHERE Country = 'USA'
UNION ALL
SELECT * FROM Customers
WHERE Country = 'Canada';

-- 2. List all employees from the USA and UK. 
SELECT EmployeeID FROM Employees
WHERE Country = 'USA'
UNION ALL 
SELECT EmployeeID FROM Employees
WHERE Country = 'UK';

-- 3. List all products from the 'Beverages' category and 'Confections' category.
SELECT 
  C.CategoryID, 
  C.CategoryName,
  LISTAGG(P.ProductID, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs,
  LISTAGG(P.PRODUCTNAME, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs
FROM CATEGORIES C
INNER JOIN PRODUCTS P
ON C.CategoryID = P.CategoryID
WHERE CategoryName = 'Beverages'
GROUP BY C.CategoryID, C.CategoryName
UNION ALL
SELECT 
  C.CategoryID, 
  C.CategoryName,
  LISTAGG(P.ProductID, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs,
  LISTAGG(P.PRODUCTNAME, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs
FROM CATEGORIES C
INNER JOIN PRODUCTS P
ON C.CategoryID = P.CategoryID
WHERE CategoryName = 'Confections'
GROUP BY C.CategoryID, C.CategoryName; 

-- 4. List all orders shipped by 'Speedy Express' and 'United Package'. 
SELECT 
  S.CompanyName,
  O.OrderID
FROM Shippers S
INNER JOIN Orders O
ON S.ShipperID = O.ShipVia
WHERE S.CompanyName = 'Speedy Express'
UNION ALL
SELECT 
  S.CompanyName,
  O.OrderID
FROM Shippers S
INNER JOIN Orders O
ON S.ShipperID = O.ShipVia
WHERE S.CompanyName = 'United Package';

-- 5. List all customers and suppliers company name. 




-- SELECT 
--   Cust.CustomerID,
--   Cust.CompanyName,
--   LISTAGG(S.SupplierID, ', ') WITHIN GROUP (ORDER BY Cust.CustomerID) AS CustomerID,
--   LISTAGG(S.CompanyName, ', ') WITHIN GROUP (ORDER BY Cust.CompanyName) AS CompanyName
-- FROM customers Cust
-- INNER JOIN Orders O ON Cust.CustomerID = O.CustomerID
-- INNER JOIN Orderdetails OD ON O.OrderID = OD.OrderID
-- INNER JOIN Products P ON OD.ProductID = P.ProductID
-- INNER JOIN Suppliers S ON P.SupplierID = S.SupplierID
-- GROUP BY (Cust.CustomerID, Cust.CompanyName); -- There is no customer name How to solve? ⚠️ Nor correct



-- -- Oracle Minus: 
-- Assignment: Write queries to find rows in one SELECT statement but not in another.
-- 1. List customers not from the USA. 
SELECT * FROM Customers
MINUS
SELECT * FROM Customers
WHERE Country = 'USA';

-- 2. List employees not from the UK. 
SELECT EmployeeID FROM Employees
MINUS
SELECT EmployeeID FROM Employees
WHERE Country = 'UK';

-- 3. List products not in the 'Beverages' category. 
SELECT 
  C.CategoryID, 
  C.CategoryName,
  LISTAGG(P.ProductID, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs,
  LISTAGG(P.PRODUCTNAME, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs
FROM CATEGORIES C
INNER JOIN PRODUCTS P
ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryID, C.CategoryName
MINUS
SELECT 
  C.CategoryID, 
  C.CategoryName,
  LISTAGG(P.ProductID, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs,
  LISTAGG(P.PRODUCTNAME, ', ') WITHIN GROUP (ORDER BY C.CategoryID) AS ProductIDs
FROM CATEGORIES C
INNER JOIN PRODUCTS P
ON C.CategoryID = P.CategoryID
WHERE CategoryName = 'Beverages'
GROUP BY C.CategoryID, C.CategoryName; 

-- 4. List orders not shipped by 'Speedy Express'. 
SELECT 
  S.CompanyName,
  O.OrderID
FROM Shippers S
INNER JOIN Orders O
ON S.ShipperID = O.ShipVia
MINUS
SELECT 
  S.CompanyName,
  O.OrderID
FROM Shippers S
INNER JOIN Orders O
ON S.ShipperID = O.ShipVia
WHERE S.CompanyName = 'Speedy Express';

-- 5. List customers who are not also suppliers.


-- -- Anti Join: 
-- Assignment: Write queries to return only rows where there is no match on the joined tables. 
-- 1. List customers who have not placed any orders. 
SELECT * FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

-- 2. List employees who have not made any sales.
SELECT * FROM EMPLOYEES 
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM Orders); -- Every employee has made at least one sale.

-- 3. List categories with no products. 
SELECT * FROM Categories
WHERE CategoryID NOT IN (SELECT CategoryID FROM Products); -- Every category has at least one product.

-- 4. List products with no orders. 
SELECT * FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM OrderDetails); -- Every product has been ordered.

-- 5. List suppliers with no products. 
SELECT * FROM Suppliers
WHERE SupplierID NOT IN (SELECT SupplierID FROM Products); -- Every supplier has at least one product.


-- -- Semi Join:  (You can use 'IN' or 'EXISTS' to perform a semi join.)
-- Assignment: Write queries to return only rows from the first table where there is a match with the 
-- 1. List customers who have placed orders.
SELECT * FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders);
-- -<or>-
SELECT * FROM Customers
WHERE EXISTS (SELECT * FROM Orders WHERE Customers.CustomerID = Orders.CustomerID);

-- 2. List employees who have made sales. 
SELECT * FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM Orders);

-- 3. List categories with products. 
SELECT * FROM Categories
WHERE CategoryID IN (SELECT CategoryID FROM Products);

-- 4. List products with orders. 
SELECT * FROM Products
WHERE ProductID IN (SELECT ProductID FROM OrderDetails);

-- 5. List suppliers with products. 
SELECT * FROM Suppliers
WHERE SupplierID IN (SELECT SupplierID FROM Products);

-- -- With Clause:
-- Assignment: Write queries using the WITH clause to define a common table expression for reuse in subsequent SELECT statements. 

-- 1. List all employees along with their managers. 
-- can add a manager column and insert some employee's who are managers then... query
WITH EmployeeManager AS (

  SELECT 
    employeeid, 
    firstname || ' ' || lastname,
    (
      SELECT employeeid || ' | ' || firstname || ' ' || lastname
      FROM Employees mj
      WHERE mj.employeeid = jr.ReportsTo
    ) AS manager
  from employees jr
  WHERE ReportsTo is not null
)

SELECT * FROM EmployeeManager;


-- 2. Calculate the total number of orders placed by each customer. 
WITH cust_orders AS (
  SELECT 
    CustomerID,
    COUNT(OrderID) AS TotalOrders
  FROM orders
  GROUP BY CustomerID
)

SELECT * FROM cust_orders;

-- 3. Calculate the total sales amount for each product. 
WITH product_sales AS (
  SELECT 
    ProductID,
    SUM((UnitPrice * Quantity) * (1 - Discount) ) AS TotalSales
  FROM OrderDetails
  GROUP BY ProductID
)

SELECT * FROM product_sales;

-- 4. Find the top 10 customers based on their total order amount. 
WITH cust_order_amount AS (
  SELECT 
    OrderID,
    SUM((UnitPrice * Quantity) * (1 - Discount) ) AS TotalOrderAmount
  FROM OrderDetails
  GROUP BY OrderID
)

SELECT * 
FROM OrderDetails
FETCH FIRST 10 ROWS ONLY;

-- 5. Find the top 5 products based on their total sales amount.
WITH product_sales AS (
  SELECT 
    ProductID,
    SUM((UnitPrice * Quantity) * (1 - Discount) ) AS TotalSales
  FROM OrderDetails
  GROUP BY ProductID
)

SELECT *
FROM product_sales
FETCH FIRST 5 ROWS ONLY;


-- -- Grouping Set 
-- 1. Calculate the total number of orders for each customer, year, and month. 
SELECT 
  CustomerID,
  EXTRACT(YEAR FROM OrderDate) AS OrderYear,
  EXTRACT(MONTH FROM OrderDate) AS OrderMonth,
  COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY GROUPING SETS (
  (EXTRACT(MONTH FROM OrderDate)),
  (EXTRACT(YEAR FROM OrderDate)),
  (CustomerID)
);

-- 2. Calculate the total sales amount for each product category and year. 
SELECT 
  C.CategoryName,
  EXTRACT(YEAR FROM O.OrderDate) AS OrderYear,
  SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) AS TotalSales
FROM Categories C
INNER JOIN Products P
ON C.CategoryID = P.CategoryID
INNER JOIN OrderDetails OD
ON P.ProductID = OD.ProductID
INNER JOIN Orders O
ON OD.OrderID = O.OrderID
GROUP BY GROUPING SETS (
  (C.CategoryName),
  (EXTRACT(YEAR FROM O.OrderDate))
);


-- 3. Calculate the total sales amount for each shipper and country.
SELECT 
  S.CompanyName,
  C.Country,
  SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) AS TotalSales
FROM Shippers S
INNER JOIN Orders O
ON S.ShipperID = O.ShipVia
INNER JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
GROUP BY GROUPING SETS (
  (S.CompanyName),
  (C.Country)
);



-- Assignment: Write queries using the GROUPING SETS clause to perform multiple GROUP BY operations in a single query. 

-- 1. Calculate the total number of orders for each employee and territory. 
SELECT 
  E.EmployeeID,
  ET.TerritoryID,
  COUNT(O.OrderID) AS TotalOrders
FROM Employees E
INNER JOIN EmployeeTerritories ET
ON E.EmployeeID = ET.EmployeeID
INNER JOIN Orders O
ON ET.TerritoryID = O.TerritoryID
GROUP BY GROUPING SETS (
  (E.EmployeeID),
  (ET.TerritoryID)
);

-- 2. Calculate the total sales amount for each customer and product category.
SELECT 
  C.CustomerID,
  P.CategoryID,
  SUM((OD.UnitPrice * OD.Quantity) * (1 - OD.Discount)) AS TotalSales
FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
INNER JOIN Products P
ON OD.ProductID = P.ProductID
GROUP BY GROUPING SETS (
  (C.CustomerID),
  (P.CategoryID)
);