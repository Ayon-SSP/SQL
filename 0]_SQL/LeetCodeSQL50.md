## Select
### 1757. Recyclable and Low Fat Products
```sql
SELECT product_id
FROM Products
WHERE  low_fats='Y' AND recyclable='Y';
```
### 584. Find Customer Referee
```sql
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;
```
### 595. Big Countries
```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;
```
### 1148. Article Views I
```sql
SELECT DISTINCT author_id AS id
FROM views
WHERE author_id = viewer_id
ORDER BY id;
```
### 1683. Invalid Tweets
```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

## Basic Joins
### 1378. Replace Employee ID With The Unique Identifier
```sql
SELECT EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI
ON Employees.id = EmployeeUNI.id
```
### 1068. Product Sales Analysis I
```sql
SELECT Product.product_name, Sales.year, Sales.price
FROM Sales
INNER JOIN Product
ON Sales.product_id = Product.product_id
```
### 1581. Customer Who Visited but Did Not Make Any Transactions
```sql
SELECT Visits.customer_id, COUNT(Visits.customer_id) as count_no_trans
FROM Visits
LEFT JOIN Transactions
ON Visits.visit_id = Transactions.visit_id
WHERE Transactions.amount IS NULL
GROUP BY Visits.customer_id;
```
### 197. Rising Temperature
```sql
SELECT w1.id
FROM Weather as w1
CROSS JOIN Weather as w2
WHERE DATEDIFF(w1.recordDate, w2.recordDate) = 1
    AND w1.temperature > w2.temperature;
```
### 
```sql
```
### 
```sql
```
### 
```sql
```
### 
```sql
```
### 
```sql
```













## Basic Aggregate Functions
## Sorting and Grouping
## Advanced Select and Joins
## Subqueries
## Advanced String Functions / Regex / Clause