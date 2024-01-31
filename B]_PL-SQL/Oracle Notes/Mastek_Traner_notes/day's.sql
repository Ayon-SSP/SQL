
-- below will give error due to the primary key constraint
--insert into orderdetails values(null,'p1004',1);
--insert into orderdetails values('o1002',null ,1);

-- do not un comment its just for your reference
--create table dummy(
--order_id varchar2(5) references orders(order_id),
--pid  varchar2(5) references products(pid),
--quantity numeric(3) not null
--);
--
--insert into dummy values(null,'p1004',1);
--insert into dummy values('o1002',null ,1);
--
--select * from dummy;

--drop table dummy;
--truncate table orderdetails;

--create table dummy(
--order_id varchar2(5) references orders(order_id) primary key,
--pid  varchar2(5) references products(pid) primary key,
--quantity numeric(3) not null
--);
--Error report -
--ORA-02260: table can have only one primary key
--02260. 00000 -  "table can have only one primary key"
--*Cause:    Self-evident.
--*Action:   Remove the extra primary key.
--  explicit declartion of composit primary key 
--  constraint pk_orderdetails primary key (order_id,pid)






DROP TABLE people;
CREATE TABLE people(
    person_id NUMBER(3, 0) PRIMARY KEY,
    person_name VARCHAR2(35) NOT NULL,
    dateOfBirth date DEFAULT '01-Jun-1900'
);

INSERT INTO people VALUES(1, 'ASUKA', '01-Jan-1990');
INSERT INTO people VALUES(2, 'YASH', '01-Jan-1990');
INSERT INTO people VALUES(3, 'DUSTBIN', '05-Jan-1990');
INSERT INTO people VALUES(4, 'FUNN', '12-Jan-1990');

INSERT INTO people (person_id, person_name) VALUES(5, 'KARAN');


SELECT * FROM people;


###########################################################
###Date: 29Jan24
CREATE TABLE people(
person_id NUMBER(3,0) primary key,
persona_name varchar2(35) not null,
dateOfBirth date default '01-Jun-1950'
);
 








###########################################################
-- create product table - DDL
create table products(
    pid varchar2(5) primary key,
    productname varchar(25) not null,
    unitPrice NUMERIC(7,2) not null
);

-- TO ADD RECORDS / MANUPULATE THE DAA WE USE DML INSERT 
INSERT INTO PRODUCTS VALUES('p1001','Butter',10);
INSERT INTO PRODUCTS VALUES('p1002','Bread',40);
INSERT INTO PRODUCTS VALUES('p1003','Jam',20);
INSERT INTO PRODUCTS VALUES('p1004','Maggie',20);
INSERT INTO PRODUCTS VALUES('p1005','Sugar 1 Kg',45);
INSERT INTO PRODUCTS VALUES('p1006','Rice 1 Kg',100);

-- DQL DATA QUERY LANGUAGE USES SELECT STATEMENT
select * from products;
select pid,productname,unitprice from products where pid='P1001';
-- data in side the column is case-sensative
select Pid,ProductName,UnitPrice from Products where Pid='p1001';

--  comment and uncomment cltr+/ 
--customers		
--	cid	    customername
--	c1001	Amit Jha 
--	c1002	Amit Kumar
--	c1003	Sumit Shah

create table customers(
 cust_id varchar2(5) primary key,
 cust_name varchar(25) not null
);
INSERT INTO customers values  ('c1001','Amit Jha');
INSERT INTO customers values  ('c1002','Amit Kumar');
INSERT INTO customers values  ('c1003','Sumit Shah');
-- DQL 
select * from customers;
select cust_id,cust_name from customers;

--orders			
--	oderid	orderdate	cid
--	o1001	12-Dec-23	c1001
--	o1002	15-Dec-23	c1001
--	o1003	12-Dec-23	c1002
--	o1004	15-Dec-23	c1002
--	o1005	12-Dec-23	c1003
--	o1006	15-Dec-23	c1003

create table orders(
order_id varchar2(5) primary key,
orderdate date not null,
cust_id varchar2(5) references  customers(cust_id) 
);

insert into orders values('o1001','12-Dec-23','c1001');		
insert into orders values('o1002','15-Dec-23','c1001');		
insert into orders values('o1003','12-Dec-23','c1002');		
insert into orders values('o1004','15-Dec-23','c1002');		
insert into orders values('o1005','12-Dec-23','c1003');		
insert into orders values('o1006','15-Dec-23','c1003');		

-- DQL
select * from orders;

--ordersdetails			
--	orderid	pid	qunatity
--	o1001	p1001	1
--	o1001	p1002	1
--	o1002	p1003	1
--	o1002	p1004	1
--	o1003	p1001	1
--	o1003	p1002	1
--	o1004	p1003	1
--	o1004	p1004	1
--	o1005	p1001	1
--	o1005	p1002	1
--	o1006	p1003	1
--	o1006	p1004	1
--	o1006	p1005	1
--	o1007	p1006	1

create table orderdetails(
order_id varchar2(5) references orders(order_id),
pid  varchar2(5) references products(pid),
quantity numeric(3) not null,
constraint pk_orderdetails primary key (order_id,pid)
)

insert into orderdetails values('o1001','p1001',1);
insert into orderdetails values('o1001','p1002',1);
insert into orderdetails values('o1002','p1003',1);
insert into orderdetails values('o1002','p1004',1);


select * from orderdetails;
-- below will give error due to the primary key constraint
--insert into orderdetails values(null,'p1004',1);
--insert into orderdetails values('o1002',null ,1);

-- do not un comment its just for your reference
--create table dummy(
--order_id varchar2(5) references orders(order_id),
--pid  varchar2(5) references products(pid),
--quantity numeric(3) not null
--);
--
--insert into dummy values(null,'p1004',1);
--insert into dummy values('o1002',null ,1);
--
--select * from dummy;

--drop table dummy;
--truncate table orderdetails;

--create table dummy(
--order_id varchar2(5) references orders(order_id) primary key,
--pid  varchar2(5) references products(pid) primary key,
--quantity numeric(3) not null
--);
--Error report -
--ORA-02260: table can have only one primary key
--02260. 00000 -  "table can have only one primary key"
--*Cause:    Self-evident.
--*Action:   Remove the extra primary key.
--  explicit declartion of composit primary key 
--  constraint pk_orderdetails primary key (order_id,pid)



-- https://www.oracletutorial.com/oracle-basics
-- https://livesql.oracle.com/apex/livesql/file/tutorial_D39T3OXOCOQ3WK9EWZ5JTJA.html




























###########################################################
###Date: 30Jan24--super-> product,customer
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
-- in below two data entries we are entering _ special character
INSERT INTO customers VALUES ('c1004','Ankit_Arora');
INSERT INTO customers VALUES ('c1005','John_Doe');
--Q9. Display customer name starting with A and 4th character is t
-- Since here we are aware 4th character we are using "_" to find the missing 
-- characters to be compared with all names avaialble in cust_name
select cust_name from customers
where cust_name like 'A__t%';

--Q10. Display customer name having i at the 4th position
--"_" wild card character used with like where it presents one unkonw character
select cust_name from customers
where cust_name like '___i%';
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
where unitprice<20 or unitprice>45
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
   ############################
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
###################################
###########################################################
###Date: 29Jan24
CREATE TABLE people(
person_id NUMBER(3,0) primary key,
persona_name varchar2(35) not null,
dateOfBirth date default '01-Jun-1950'
);
###########################################################
-- create product table - DDL
create table products(
    pid varchar2(5) primary key,
    productname varchar(25) not null,
    unitPrice NUMERIC(7,2) not null
);

-- TO ADD RECORDS / MANUPULATE THE DAA WE USE DML INSERT 
INSERT INTO PRODUCTS VALUES('p1001','Butter',10);
INSERT INTO PRODUCTS VALUES('p1002','Bread',40);
INSERT INTO PRODUCTS VALUES('p1003','Jam',20);
INSERT INTO PRODUCTS VALUES('p1004','Maggie',20);
INSERT INTO PRODUCTS VALUES('p1005','Sugar 1 Kg',45);
INSERT INTO PRODUCTS VALUES('p1006','Rice 1 Kg',100);

-- DQL DATA QUERY LANGUAGE USES SELECT STATEMENT
select * from products;
select pid,productname,unitprice from products where pid='P1001';
-- data in side the column is case-sensative
select Pid,ProductName,UnitPrice from Products where Pid='p1001';

--  comment and uncomment cltr+/ 
--customers		
--	cid	    customername
--	c1001	Amit Jha 
--	c1002	Amit Kumar
--	c1003	Sumit Shah

create table customers(
 cust_id varchar2(5) primary key,
 cust_name varchar(25) not null
);
INSERT INTO customers values  ('c1001','Amit Jha');
INSERT INTO customers values  ('c1002','Amit Kumar');
INSERT INTO customers values  ('c1003','Sumit Shah');
-- DQL 
select * from customers;
select cust_id,cust_name from customers;

--orders			
--	oderid	orderdate	cid
--	o1001	12-Dec-23	c1001
--	o1002	15-Dec-23	c1001
--	o1003	12-Dec-23	c1002
--	o1004	15-Dec-23	c1002
--	o1005	12-Dec-23	c1003
--	o1006	15-Dec-23	c1003

create table orders(
order_id varchar2(5) primary key,
orderdate date not null,
cust_id varchar2(5) references  customers(cust_id) 
);

insert into orders values('o1001','12-Dec-23','c1001');		
insert into orders values('o1002','15-Dec-23','c1001');		
insert into orders values('o1003','12-Dec-23','c1002');		
insert into orders values('o1004','15-Dec-23','c1002');		
insert into orders values('o1005','12-Dec-23','c1003');		
insert into orders values('o1006','15-Dec-23','c1003');		

-- DQL
select * from orders;

--ordersdetails			
--	orderid	pid	qunatity
--	o1001	p1001	1
--	o1001	p1002	1
--	o1002	p1003	1
--	o1002	p1004	1
--	o1003	p1001	1
--	o1003	p1002	1
--	o1004	p1003	1
--	o1004	p1004	1
--	o1005	p1001	1
--	o1005	p1002	1
--	o1006	p1003	1
--	o1006	p1004	1
--	o1006	p1005	1
--	o1007	p1006	1

create table orderdetails(
order_id varchar2(5) references orders(order_id),
pid  varchar2(5) references products(pid),
quantity numeric(3) not null,
constraint pk_orderdetails primary key (order_id,pid)
) 

insert into orderdetails values('o1001','p1001',1);
insert into orderdetails values('o1001','p1002',1);
insert into orderdetails values('o1002','p1003',1);
insert into orderdetails values('o1002','p1004',1);


select * from orderdetails;
-- below will give error due to the primary key constraint
--insert into orderdetails values(null,'p1004',1);
--insert into orderdetails values('o1002',null ,1);

-- do not un comment its just for your reference
--create table dummy(
--order_id varchar2(5) references orders(order_id),
--pid  varchar2(5) references products(pid),
--quantity numeric(3) not null
--);
--
--insert into dummy values(null,'p1004',1);
--insert into dummy values('o1002',null ,1);
--
--select * from dummy;

--drop table dummy;
--truncate table orderdetails;

--create table dummy(
--order_id varchar2(5) references orders(order_id) primary key,
--pid  varchar2(5) references products(pid) primary key,
--quantity numeric(3) not null
--);

--Error report -
--ORA-02260: table can have only one primary key
--02260. 00000 -  "table can have only one primary key"
--*Cause:    Self-evident.
--*Action:   Remove the extra primary key.
--  explicit declartion of composit primary key 
--  constraint pk_orderdetails primary key (order_id,pid)



