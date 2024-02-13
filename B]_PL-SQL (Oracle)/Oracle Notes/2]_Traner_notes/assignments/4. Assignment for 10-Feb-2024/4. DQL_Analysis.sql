-- Understanding the Northwind Data
-- there are 77 different products from 8 different Categories
-- there are 91 different customers from 21 different countries in which 2 customers have not placed any orders
-- there are 830 different orders from 9 different employees
-- there are 2155 different orderdetails from 830 different orders
-- there are 29 different shippers
-- there are 29 different suppliers from 16 different countries
-- there are 9 different employees from 8 different countries
-- product prices like 'chai' cost is not constant so consider the orderdetails unitprice

-- -- Q1. Write queries on Northwind db.(Any 5) 
-- 1. Get a list of latest order IDs for all customers by using the max function on Order_ID column.

-- There are 91 customers in which 89 customers placed orders and 2 customers have not placed any orders.

SELECT COUNT(*)
FROM Customers;

SELECT DISTINCT customerid
FROM Orders;

-- customer -> total no. of orders
SELECT C.CustomerID, COUNT(O.OrderID)
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID;
-- HAVING COUNT(O.OrderID) = 0; -- 2 customers have not ordered anything

-- first order of 89 customers

-- all the orders placed by ALFKI
select *
from orders
where customerid = 'ALFKI'
ORDER BY orderdate DESC;

SELECT *
FROM Customers;

SELECT *
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID;

select *
from products;



-- all the latest_order_date of every customer
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





-- display all the orderids of the latest order of every customer
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



-- 7. For each order, calculate a subtotal for each Order (identified by OrderID).
SELECT * FROM OrderDetails;
SELECT * FROM Products;

SELECT COUNT(*) -- 2155 
FROM OrderDetails; 

select count(*) -- 830 rows in orders table unique orderid's
from orders; 

SELECT COUNT(UNIQUE Orderid) -- 830
FROM Orders;

select orderid, count(orderid) -- 830 unique orderid rows
from orderdetails
group by orderid
order by count(orderid) desc;

select * -- 6rows -> 6 products which are (1, 19, 37, 57, 60, 76)
from orderdetails
where orderid = '10847';

-- all products in orderid 10847
select *
from products
where productid in (
    select productID-- 6rows -> 6 products which are (1, 19, 37, 57, 60, 76)
    from orderdetails
    where orderid = '10847'
);

select LISTAGG(productid, ', ') AS productids -- product's (11, 24, 72)
from orderdetails
where orderid = '10248';

select unitprice * quantity as total_product_amount
from orderdetails
where orderid = '10248';

select sum(unitprice * quantity) as total_order_amount
from orderdetails
where orderid = '10248'; -- this is for one order


select sum(unitprice * quantity) as total_order_amount
from orderdetails
where orderid = '10260'; -- this is for one order

-- total amount for orderid 10260
select sum((unitprice * quantity) * (1 - discount)) as total_order_amount
from orderdetails
where orderid = '10260'; -- this is for one order

-- total amount for orderid 10260
select sum((unitprice * quantity) * (1 - discount)) as total_order_amount
from orderdetails
where orderid = '10397'; -- this is for one order


select o.orderid, (
    select sum((unitprice * quantity) * (1 - discount)) as total_order_amount
    from orderdetails
    where orderid = o.orderid ) as total_order_amount
from orders o
order by o.orderid;

-- 8. Sales by Year for each order.    
SELECT * 
FROM Orders;

select *
from orders
order by shippeddate;

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
ORDER BY year, shippeddate;

-- 9. Get Employee sales by country names
-- country, lastname, firstname, shippeddate, orderid, sale_amount
-- employeeid -> lastname, firstname, country ---> table: (employees)
-- orderid -> shippeddate, sale_amount ---> table: (orders, orderdetails) 
-- | employeeid | orderid | on 
select * -- there are only 9 employees
from employees
order by employeeid;

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
  ost.Employeeid,
  ShippedDate,
  OrderID,
  sale_amount
FROM Order_Subtotal ost
LEFT JOIN employees emp
ON ost.EmployeeID = emp.EmployeeID;
-- next ost.Employeeid -> emp.EmployeeID -> emp.lastname, emp.firstname, emp.country



-- 10. Alphabetical list of products 
SELECT 
  ProductID,
  ProductName,
  SupplierID
  QuantityPerUnit,
  UnitPrice
  ...

-- 12. Calculate sales price for each order after discount is applied. 
SELECT
  OrderID,
  ProductID,
  UnitPrice,
  Quantity,
  Discount,
  (UnitPrice * Quantity) * (1 - Discount) AS SalesPrice
FROM OrderDetails;

-- 13. Sales by Category: For each category, we get the list of products sold and the total sales amount. 

select * -- there are 8 different categories
from categories;

select * -- there are 10 different products in category 4(dairy products)
from products
where categoryid = 4;

-- Get the products
select 
  p.categoryid,
  c.categoryname,
  p.productid,
  p.productname
from products p
left join categories c
on p.categoryid = c.categoryid;


SELECT 
  ProductID,
  ProductName,
  SupplierID,
  CategoryID,
  QuantityPerUnit,
  UnitPrice
FROM Products
ORDER BY ProductName;

select * from Products;


-- 13. Sales by Category: For each category, we get the list of products sold and the total sales amount. 
-- first forget about the category
-- just bring over all sales of Chai with productid `1`

select * -- 38 different orders of chai
from orderdetails
where productid = 1;

select sum(quantity) -- total 828 chai's are sold
from orderdetails
where productid = 1;

-- total sales of chai("1")
select sum((unitprice * quantity) * (1 - discount)) as total_sales
from orderdetails
where productid = 1;

-- similarly for all the products


SELECT 
  P.ProductID,
  (
    SELECT 
      SUM((UnitPrice * Quantity) * (1 - Discount)) AS TotalSales
    FROM OrderDetails
    WHERE ProductID = P.ProductID
  )
FROM Products P
ORDER BY P.ProductID;

-- 13. Sales by Category: For each category, we get the list of products sold and the total sales amount. 
select *
from PRODUCTS
where PRODUCTNAME = 'Chai';

-- 38 different orders of chai
select sum((unitprice * quantity) * (1 - discount)) as total_sales
from ORDERDETAILS
where productid = 2;

-- 2. Find suppliers who sell more than one product to Northwind Trader. 
SELECT 
  SupplierID, 
  CompanyName, 
  COUNT(ProductID) AS product_count
FROM Products
GROUP BY SupplierID, CompanyName
HAVING COUNT(ProductID) > 1;

select *
from suppliers;

select DISTINCT supplierid -- 29 different suppliers with 77 different products
from products;

select SUPPLIERID, count(productid)
from products
group by supplierid;




SELECT *
FROM Orders
where customerid = 'TORTU'
order by orderdate desc;


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

-- 6. Rank customers by the total sales amount within each order date
-- rank customers(total sales amount) order by orderdate

select *
from ORDERDETAILS;

select *
from orders;


-- customer(1) -> (N) Orders, date -> (N) OrderDetails(product's)


-- I need a function which takes orderid and orderdate and return the total sales amount of that order
--    handel the edgcase one customer can place 2 or more orders in same day.



  SELECT SUM((UnitPrice * Quantity) * (1 - Discount)) AS TotalSales
  FROM OrderDetails
  WHERE CustomerID = 'ALFKI' AND ORDERDATE = '1996-07-04';


CREATE OR REPLACE FUNCTION get_order_total_sales(customer_id IN NUMBER, order_date IN DATE) RETURN NUMBER
AS
  total_sales NUMBER;
BEGIN
  SELECT SUM((UnitPrice * Quantity) * (1 - Discount)) INTO total_sales
  FROM OrderDetails
  WHERE CustomerID = customer_id AND OrderDate = order_date;
  RETURN total_sales;
END;
/
SELECT get_order_total_sales('ALFKI', '1996-07-04') FROM dual;
SELECT get_order_total_sales(2, '1996-07-04') FROM dual;



-- WRITE A FUNCTION WILL TAKE orderid AND RETURN THE TOTAL SALES AMOUNT OF THAT ORDER
CREATE OR REPLACE FUNCTION get_order_total_sales(order_id IN NUMBER) RETURN NUMBER
AS
  total_sales NUMBER;
BEGIN
  SELECT SUM((UnitPrice * Quantity) * (1 - Discount)) INTO total_sales
  FROM OrderDetails
  WHERE OrderID = order_id;
  RETURN total_sales;
END;

SELECT get_order_total_sales(10248) FROM dual;
SELECT get_order_total_sales(10249) FROM dual;

select *
from OrderDetails;

select CUSTOMERID, orderid, ORDERDATE
from orders
order by CUSTOMERID, ORDERDATE;







-- 5. Rank products by the number of units in stock in each product category.
select *
from products;

select
  RANK() OVER (PARTITION BY CategoryID ORDER BY UnitsInStock DESC) AS customer_rank
from products;

select
  CategoryID,
  RANK() OVER (PARTITION BY CategoryID ORDER BY UnitsInStock DESC) AS category_rank,
  UnitsInStock,
  ProductID,
  ProductName
from products;




-- 2. Display product(productname), customers(companyname), orders(orderyear)
-- productid -> productname
-- customerid -> companyname

-- CREATE OR REPLACE VIEW vwQuarterly_Orders_by_Product AS
SELECT
  C.CompanyName,
  
FROM Customers C
RIGHT JOIN Orders O
ON Customers.CustomerID = Orders.CustomerID;

-- SELECT *
-- FROM vwQuarterly_Orders_by_Product;


select * from suppliers;

select * from PRODUCTS;