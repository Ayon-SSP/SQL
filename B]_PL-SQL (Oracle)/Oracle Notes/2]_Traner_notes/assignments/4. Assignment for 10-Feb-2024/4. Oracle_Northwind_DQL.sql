--Assignment_008   310-FEB-24 
--SQL QUERIES 

-- -- Q1. Write queries on Northwind db.
-- 1. Get a list of latest order IDs for all customers by using the max function on Order_ID column.
SELECT CustomerID, MAX(OrderID) 
FROM Orders 
GROUP BY CustomerID;

-- -<or>-
WITH customers_latest_active_date AS (
    SELECT C.CustomerID, MAX(O.orderdate) AS latest_order_date
    FROM Customers C
    LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID
    GROUP BY C.CustomerID
)

SELECT clad.CustomerID ,clad.latest_order_date, (
    SELECT O.OrderID
    FROM Orders O
    WHERE O.CustomerID = clad.CustomerID
        AND O.OrderDate = clad.latest_order_date
    FETCH FIRST 1 ROWS ONLY
) AS latest_order_id
FROM customers_latest_active_date clad
ORDER BY latest_order_date DESC NULLS LAST;

-- -<or>-
WITH LatestOrders AS (
    SELECT 
        CustomerID,
        OrderID,
        OrderDate,
        FIRST_VALUE(OrderID) OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS latest_order_id
    FROM Orders
)

SELECT C.CustomerID, OrderDate, latest_order_id
FROM Customers C
LEFT JOIN LatestOrders O
ON C.CustomerID = O.CustomerID
WHERE OrderID = latest_order_id
ORDER BY ORDERDATE DESC;

-- 2. Find suppliers who sell more than one product to Northwind Trader. 
SELECT supplierID, COUNT(ProductID) AS product_count
FROM Products
GROUP BY SupplierID
HAVING COUNT(ProductID) > 1;

-- 3. Create a function to get latest order date for entered customer_id (SQL)
CREATE OR REPLACE FUNCTION get_latest_order_date(customer_id IN VARCHAR2) RETURN DATE
AS
  latest_order_date DATE;
BEGIN
  SELECT MAX(OrderDate) INTO latest_order_date
  FROM Orders
  WHERE CustomerID = customer_id;
  RETURN latest_order_date;
END;
/

SELECT get_latest_order_date('BONAP') FROM dual;
SELECT get_latest_order_date('TORTU') FROM dual;

-- 4. Get the top 10 most expensive products. 
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC
FETCH FIRST 10 ROWS ONLY;


-- 5. Rank products by the number of units in stock in each product category.
SELECT
  CategoryID,
  RANK() OVER (PARTITION BY CategoryID ORDER BY UnitsInStock DESC) AS category_rank,
  UnitsInStock,
  ProductID,
  ProductName
FROM Products;

-- 6. Rank customers by the total sales amount within each order date
CREATE OR REPLACE FUNCTION get_order_total_sales(order_id IN NUMBER) RETURN NUMBER
AS
  total_sales NUMBER;
BEGIN
  SELECT SUM((UnitPrice * Quantity) * (1 - Discount)) INTO total_sales
  FROM OrderDetails
  WHERE OrderID = order_id;
  RETURN total_sales;
END;

SELECT
  CustomerID,
  OrderDate,
  get_order_total_sales(OrderID) AS total_sales,
  RANK() OVER (ORDER BY get_order_total_sales(OrderID) DESC) AS order_rank
FROM Orders;

-- 7. For each order, calculate a subtotal for each Order (identified by OrderID).
SELECT 
  OrderID, 
  (
    SELECT SUM((quantity * unitprice) * (1 - discount))
    FROM orderdetails
    WHERE OrderID = o.OrderID
  ) AS subtotal
FROM Orders o
ORDER BY OrderID;

-- 8. Sales by Year for each order.  oracle sql code
SELECT 
  ShippedDate,
  OrderID, 
  (
    SELECT SUM((quantity * unitprice) * (1 - discount))
    FROM orderdetails
    WHERE OrderID = o.OrderID
  ) AS subtotal,
  EXTRACT(YEAR FROM ShippedDate) AS year
FROM Orders o
ORDER BY year, shippeddate;  -- page 14 & 15 matches o/p

-- 9. Get Employee sales by country names
With Order_Subtotal AS (
  SELECT 
    ShippedDate,
    OrderID,
    Employeeid,
    (
      SELECT SUM((quantity * unitprice) * (1 - discount))
      FROM orderdetails
      WHERE OrderID = o.OrderID
    ) AS sale_amount
  FROM Orders o
)

SELECT 
  -- ost.Employeeid,
  emp.Country,
  emp.LastName,
  emp.FirstName,
  ShippedDate,
  OrderID,
  sale_amount
FROM Order_Subtotal ost
LEFT JOIN employees emp
ON ost.EmployeeID = emp.EmployeeID
ORDER BY emp.Country, LastName, FirstName, ShippedDate; -- page 2 matches with o/p

-- 10. Alphabetical list of products 
SELECT 
  ProductID,
  ProductName,
  SupplierID,
  CategoryID,
  QuantityPerUnit,
  UnitPrice
FROM Products
ORDER BY ProductName;

-- 11. Display the current Productlist
SELECT
  ProductID,
  ProductName
FROM Products;

-- 12. Calculate sales price for each order after discount is applied. 
SELECT
  O.OrderID,
  O.ProductID,
  P.ProductName,
  O.UnitPrice,
  O.Quantity,
  O.Discount,
  (O.UnitPrice * O.Quantity) * (1 - O.Discount) AS SalesPrice
FROM OrderDetails O
LEFT JOIN Products P
ON O.ProductID = P.ProductID;

-- 13. Sales by Category: For each category, we get the list of products sold and the total sales amount. 
SELECT 
  C.CategoryID,
  C.CategoryName,
  -- P.ProductID,
  P.ProductName,
  (
    SELECT 
      SUM((UnitPrice * Quantity) * (1 - Discount)) AS TotalSales
    FROM OrderDetails
    WHERE ProductID = P.ProductID
  ) AS ProductSales
FROM Products P
LEFT JOIN Categories C
ON P.CategoryID = C.CategoryID; -- diff output. 😅 I guess my code/output is correct


-- -- Q2. Create below views
-- 1. Displays products(productname,unitprice) who’s price is greater than avg(price) 
CREATE OR REPLACE VIEW vwProducts_Above_Average_Price AS
SELECT 
  ProductID,
  ProductName,
  UnitPrice
FROM Products
WHERE UnitPrice > (
  SELECT AVG(UnitPrice)
  FROM Products
)
ORDER BY UnitPrice;

SELECT *
FROM vwProducts_Above_Average_Price;

-- 2. Display product(productname), customers(companyname), orders(orderyear)
CREATE OR REPLACE VIEW vwQuarterly_Orders_by_Product AS
SELECT 
  P.ProductName,
  C.CompanyName,
  EXTRACT(YEAR FROM O.OrderDate) AS OrderYear
FROM Products P
LEFT JOIN OrderDetails OD ON P.ProductID = OD.ProductID
LEFT JOIN Orders O ON OD.OrderID = O.OrderID
LEFT JOIN Customers C ON O.CustomerID = C.CustomerID;

SELECT *
FROM vwQuarterly_Orders_by_Product;

-- 3. Display Supplier Continent wise sum of unitinstock. 
-- 'Europe'= ('UK','Spain','Sweden','Germany','Norway', 
--                  'Denmark','Netherlands','Finland','Italy','France') 
-- 'America'= 'USA','Canada','Brazil' and 'Asia-Pacific'

CREATE OR REPLACE VIEW vwUnitsInStock AS
SELECT 
  S.Country,
  SUM(P.UnitsInStock) AS TotalUnitsInStock
FROM Suppliers S
LEFT JOIN Products P ON S.SupplierID = P.SupplierID
GROUP BY S.Country;

SELECT *
FROM vwUnitsInStock;

-- 4. Display top 10 expensive products 
CREATE OR REPLACE VIEW vw10Most_Expensive_Products AS
SELECT 
  ProductName,
  UnitPrice
FROM Products
ORDER BY UnitPrice DESC
FETCH FIRST 10 ROWS ONLY;

SELECT *
FROM vw10Most_Expensive_Products;


-- 5. Display customer supplier by city
-- city, companyname, contactname, relationship
CREATE OR REPLACE VIEW vwCustomer_Supplier_by_City AS
SELECT 
  C.City,
  C.CompanyName AS Customer,
  C.ContactName AS CustomerContact,
  'Customer' AS Relationship
FROM Customers C
UNION
SELECT 
  S.City,
  S.CompanyName AS Supplier,
  S.ContactName AS SupplierContact,
  'Supplier' AS Relationship
FROM Suppliers S
ORDER BY City;

SELECT *
FROM vwCustomer_Supplier_by_City;