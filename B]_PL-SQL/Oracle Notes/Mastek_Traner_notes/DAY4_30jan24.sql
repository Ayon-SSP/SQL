--super-> product,customer
--subentity->orders,orderdetails
-- q1. Display all products details
    select * from products;
-- q2. Display productname, unitprice from products
    select productname,unitprice from products;
-- q3. Display productname, unitprice from products 
--where unit price is more than 20  
select productname,unitprice from products
where unitprice>20;
-- Avoid using Select * 
-- q4. Display all customer details
select * from customers;
select cust_id,cust_name from customers;
-- column alias name by using as keyword
select cust_id as CustomerId ,cust_name as CustomerName from customers;
-- q5. Display all orders details
select * from orders;
select order_id as Orderid, orderdate, cust_id as Customerid from orders;
-- q6. Display all orderDetails records
select * from orderdetails;
select 
order_id as orderid, 
pid as ProductId, 
quantity as PurchaseQuantity 
from orderdetails;
--Q7. Display customer name starting with A
-- Like operator where we are using search for Starting with A character
-- % indicates any other character
select 
cust_name as CustomerName
from customers
where 
cust_name like 'A%';
--Q8. Display customer name ending with a
select 
cust_name as "Customer Name"
from customers
where 
cust_name like '%a';
-- char/varchar/date ==>''
-- alias if has white space you should put it inside the " "
select * from customers;
--Q9. Display customer name starting with A and 4th character is t
-- Since here we are aware 4th character we are using "_" to find the missing 
-- characters to be compared with all names avaialble in cust_name
select cust_name from customers
where cust_name like 'A__t%';

--Q10. Display customer name having i at the 4th position
--"_" wild card character used with like where it presents one unkonw character
select cust_name from customers
where cust_name like '___i%';

select cust_id,cust_name from customers;
-- in below two data entries we are entering _ special character
INSERT INTO customers VALUES ('c1004','Ankit_Arora');
INSERT INTO customers VALUES ('c1005','John_Doe');

--Q11. Display customer name having _ in it
-- while working with like operator if we want to compare a string
-- having "_" in it, in that case instead of wild card we want
-- query parser to consider "_" as simple character
-- For this we have escape sequnce 
-- in c/cpp/java '\n, \t,\r'
-- '%\_% escape '\'
select 
cust_name 
from customers
where 
cust_name like '%\_%' escape '\';

select 
cust_name 
from customers
where 
cust_name like '%$_%' escape '$';

select 
cust_name 
from customers
where 
cust_name like '%_%';
commit;
--##################################
-- when you want to know the data types and number of column details of a table
describe customers; 
-- when you want to understand the data of the table you will fire below
select * from customers;
--##################################
select * from products;
--Q12. Display products with use of conditional operator
--a. less than 50
select
productname,unitPrice
from products
where 
unitprice<50;
--b. greater than 50
select
productname, unitprice
from 
products
where
unitprice>50;

--c. less than equalto 50
select
productname, unitprice
from 
products 
where 
unitprice<=50;
--d. greater than euql to 50
select
productname, unitprice
from 
products 
where 
unitprice>=50;
--e. equal (exact match) 45
select
productname,unitprice
from
products
where unitprice=45;
--f. not equal != 45
select
productname,unitprice
from 
products
where 
unitprice!=45;
--g. not equal <> 45
select
productname,
unitprice
from 
products
where
unitprice<>45;
--Q13 Range operators
-- in unitprice is 10,40,45
select
productname,
unitprice
from products
where
unitprice in(10,40,45);
-- using or unitprice is 10 or 40 or 45
select productname, unitprice
from products
where unitprice=10 or unitprice=40 or unitprice=45;

-- not in 10,40,45
select productname,unitprice
from products
where unitprice!=10 and unitprice!=40 and unitprice!=45;

select productname,unitprice 
from products 
where unitprice not in (10,40,45);

-- !or => and
-- !and => or 

-- between unitprice is between 20 to 45
-- using >= and <= 
-- it considers boundry value inclusion of boundries
select productname,unitprice from products
where unitprice between 20 and 45;

select productname,unitprice from products
where unitprice >=20 and unitprice<=45;

-- not between 20 and 45
select productname,unitprice from products
where unitprice not between 20 and 45;

select productname,unitprice from products
where unitprice<20 or unitprice>45;
-- !and -> or 
-- !>= -> <
-- !<= -> >
--Q14 lets use arithmatic operators +-/*%
--Display product unit price increase by 20 
select 
productname, 
unitprice,
unitprice+20 as "Unitprice+20"
from 
products;
--Display product increse unitprice 5 times
select
productname,
unitprice,
unitprice*5 as "Unitprice5times"
from products;
--Display productname,unitprice with 10% discound on it 
select
productname,
unitprice,
(unitprice*0.1),
(unitprice*(10/100))
from 
products;
--Display productname,unitprice with 10% discound on it,ordedeatails quantity
-- OrderREcepit
select * from orderdetails;
--o1001	p1001	1
--o1001	p1002	1
select * from products;
--p1001	Butter	10
--                   tp
-- o1001 p1001 2 10 20   ((quantity*unitprice)*0.1)  2  (quantity*unitprice)-((quantity*unitprice)*0.1)18
-- o1001 p1002 1 40 40   ((quantity*unitprice)*0.1)  4  (quantity*unitprice)-((quantity*unitprice)*0.1)36

--Q15 Concatenation ||
select cust_id || '_' ||cust_name
as "Customer Details"
from customers;
--############ creating user on oracle instance for custom schema
alter session set "_ORACLE_SCRIPT"=true;
-- Create user 
create user dj IDENTIFIED by root;
 
SELECT 
		username, 
		default_tablespace, 
		profile, 
		authentication_type
	FROM
		dba_users 
	WHERE 
		account_status = 'OPEN'
	ORDER BY
		username; 
-- ################################################################	
-- DCL: Grant Control
-- ################################################################
   grant create session to dj;     
   grant create table to dj; 
   grant create view to dj;
   grant create any trigger to dj;
   grant create any procedure to dj;
   grant create SEQUENCE to dj;
   grant create SYNONYM to dj;
   grant all PRIVILEGES to dj;
   grant connect to dj;
   grant RESOURCE to dj;
   grant dba to dj;
-- 
select * from products;
select * from orderdetails;

delete from products where pid='p1004';
delete from orderdetails where pid='p1004';
rollback;

truncate table products
cascade;

create table parent(
pid number primary key )

create table childtable(
pid number references parent(pid) on delete CASCADE
)
insert INTO parent values(1);
insert INTO parent values(2);
insert INTO parent values(3);

insert into childtable values (1);
insert into childtable values (1);
insert into childtable values (1);

select pid as parentpid from parent;
select pid as childpid from childtable;
commit;
truncate table parent CASCADE;

delete from parent CASCADE;

rollback;
