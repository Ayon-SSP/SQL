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

