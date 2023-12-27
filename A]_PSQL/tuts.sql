/*
	SQL
		Structured Query Language
		SQL is a standard language for accessing and manipulating databases.
		SQL statements are used to perform tasks such as update data on a database, or retrieve data from a database.
		SQL can be used to insert, search, and update data in a database.
		SQL is a standard language for storing, manipulating and retrieving data in databases
	
	WHERE
	ORDER BY
	GROUP BY
	HAVING
	LIMIT
	OFFSET
	INSERT
	UPDATE
	DELETE
	ALTER
	CREATE
	DROP
	TRUNCATE
	GRANT
	REVOKE
	ANALYZE
	CLUSTER
	COPY
	CREATE INDEX
	CREATE TABLE AS
	CREATE VIEW
	DEALLOCATE



	SERIAL
	DEFAULT
	NOT NULL
	NULL
	CHECK
	UNIQUE
	PRIMARY KEY
	FOREIGN KEY
	REFERENCES
	CONSTRAINT
	ASC
	DESC
	AVG
	COUNT
	MAX
	MIN
	SUM
	ALL
	ANY
	BETWEEN
	
	EXISTS
	IN
	IS NULL
	IS NOT NULL
	LIKE
	NOT
	OR
	SOME
	INTERSECT
	EXCEPT
	UNION
	INTERSECT
	UNION

	_ 	any single character
	% 	any string of zero or more characters
	




*/


-- Run on postgresql sql Shill
\l -- to list all the DB  or SHOW DATABASE; - for mysql
\dt -- for displaying the tables
\d employee -- discribe a TABLE
\dn -- display avalable SCHEMA
\dv -- avalable vwes
\du -- users and there roles
\q -- to quit the terminal
\dt -- to list all the avalable tables
psql --help -- to get help





```bash
sudo service postgresql status
sudo service postgresql start
sudo service postgresql stop
sudo service postgresql restart
sudo service postgresql reload
psql --version
sudo passwd postgres

```

```bash
sudo passwd postgres
sudo -u postgres psql
psql store_monitoring postgres
```
```psql
\l
\du
\dt - this shows all tables in the current schema
\password postgres
\q
SELECT * FROM pg_catalog.pg_tables; - list all tables
\c <dbnaem-toConnect>
\! clear
\d+ tablename - show table structure
```









CREATE TABLE IF NOT EXISTS employee (
    name VARCHAR (255) NOT NULL,
    empid int not null
);


CREATE TABLE IF NOT EXISTS employeeTemp (

	name VARCHAR (255) NOT NULL,
	empid serial not null, 
	department VARCHAR (255) NOT NULL,
	salary int not null check (salary > 10000),
	phone int not null,
	Age int NULL DEFAULT 0;
);

CREATE table employee (
	id serial primary key,
	name varchar(255) not null,
	department varchar(255) DEFAULT 'SWE2' not null,
	salary int not null,
	phone int not null,
	UNIQUE (name,department),
	CHECK (salary > 10000),
	CHECK (phone > 1000000000)
);


-- to copy a TABLE with and without data
CREATE TABLE original_table as table original_table;
CREATE TABLE original_table as table original_table with no data;

CREATE TABLE original_table AS SELECT * FROM original_table;




INSERT into employee(name, empid) VALUES('AYON', 1);
-- insert in table
INSERT into employee(empid,name,department,salary,phone) VALUES(5,'AYON','sde3',700000,39454);
INSERT INTO table2 (select * form table1)

INSERT into employee(empid,name,department,salary,phone) 
VALUES
(5,'AYON','sde3',700000,39454)
(57,'kunal','sde2',100000,6549872),
(45,'jojo','video edior',50000,845454),
(50,'harry','sde1',700000,3945443);

SELECT Emp_ID, First_Name, Last_Name, Salary, City  
FROM Employee_details  
WHERE Salary = 100000  
ORDER BY Last_Name;


select 'My Name is ' || name || ' and I work as ' || department || ' with salary ' || salary || 'you can contact me in ' || phone
from employee;

select name, department
from employee
where salary > 1000
order by salary DESC/ASC;

select department 
from employee
group by department
order by department;

-- total count
select count(*) 
from employee;


-- only display the sde1,sde2 and sde3
select department,count(department) 
from employee
group by department
having department in ('sde1','sde2','sde3');

-- or
select department,count(department) 
from employee
group by department
having department like 'sde%';


-- finding average
select department,count(department),avg(salary)
from employee
group by department
having department like 'sde%';








-- To del table
DROP TABLE employee;

-- To delet db
DROP DATABASE Company;   
-- to delete the content of a table
TRUNCATE TABLE table_name;  


CREATE TABLE vals(val int);
INSERT INTO vals VALUES (1),(2),(3),(4),(5),(6),(7),(8);
select * from vals;



-- copying a table with structure and data both
CREATE TABLE vals_backup as table vals;
select * from vals_backup;

-- copying only the structure of a table
CREATE TABLE vals_structure as table vals with no data;
select * from vals_structure;

-- Inserting other table data
insert into vals_structure (select * from vals);
select * from vals_structure;


-- ----< SELECT, UPDATE AND DELETE >-------

-- update table
update employee
set salary = 950000
where id = 8;



-- select by like name [%,_]

select 'foo' like 'f%'; -- % for any number of character
select 'foo' like 'f__'; -- _ for single character
select 'foo' like '%f%'; 
select 'superman' like '%man%'; 
select 'batman' ~~ '%man%'; -- ~~ also used like like !~~ not like

select *
from employee
where name ilike '%a%';  -- ilike i for case sensitive

select *
from employee
where name like '%a%' or name like '%r%';

-- when else in select    
create table nums(n int not null);
insert into nums values (1),(2),(3),(4),(5),(6),(7);
select * from nums;
select n,
case
	when n = 1 then 'one'
	when n = 2 then 'two'
	else 'others'
end 
from nums;


select abs(-54)
select sqrt(25)
select log(45)
select greatest(1,2,3,4,5,234,54,21,123,4567,654);
select ltrim('   AYON   ')
select rtrim('   AYON   ')




-- update
update employee 
set department = 'Teacher'
where id = 4;

update employee
set salary = salary + salary*0.1

delete from employee 
where department = 'hell';


-- add columns
ALTER TABLE Customers
ADD Email varchar(255);



-- Joints
create table supplier (id int,name varchar);
insert into supplier values(0,'jems'),(1,'pat'),(2,'kane');
select * from supplier;

create table orders (id int,name int);
insert into orders values(1,5000),(2,8000),(3,10000);
select * from orders;


select * from supplier,orders;
select * from supplier cross join orders;


-- left join
select * from supplier 
left join orders
on supplier.id = orders.id;
-- or
select * from supplier as sup 
left join orders as ord 
on ord.id = sup.id;
--   right join	
select * from supplier as sup 
right join orders as ord
on ord.id = sup.id;


-- inner join
select * from supplier as sup 
inner join orders as ord
on ord.id = sup.id;

-- Full join
select * from supplier as sup 
full join orders as ord
on ord.id = sup.id;


select * from supplier as s
natural join orders as o;






-- Mysql
show databases;
show tables;
create database mydb;
use mydb;
desc tableName;



-- JOINS


/*
t1 ->
id  name
1   AYON
2   Kunal
3   Ishan

t2 ->
id  name
2  Kunal
3  Ishan
4  Marry
*/

SELECT * FROM t1, t2; 
-- output: 
-- id  name  id  name
-- 1   AYON  2   Kunal
-- 1   AYON  3   Ishan
-- 1   AYON  4   Marry
-- 2   Kunal 2   Kunal
-- 2   Kunal 3   Ishan
-- ...

SELECT * FROM t1 CROSS JOIN t2;
-- output:
-- id  name  id  name
-- 1   AYON  2   Kunal
-- 1   AYON  3   Ishan
-- 1   AYON  4   Marry
-- 2   Kunal 2   Kunal
-- 2   Kunal 3   Ishan
...
SELECT * 
FROM t1 
INNER JOIN t2
ON t1.id = t2.id;
-- output:
-- id  name  id  name
-- 2   Kunal 2   Kunal
-- 3   Ishan 3   Ishan

SELECT * 
FROM t1 
LEFT JOIN t2 
ON t1.id = t2.id;
-- output:
-- id  name  id  name
-- 1   AYON  NULL NULL
-- 2   Kunal 2   Kunal
-- 3   Ishan 3   Ishan

SELECT * 
FROM t1 
RIGHT JOIN t2 
ON t1.id = t2.id;
-- output:
-- id  name  id  name
-- 2   Kunal 2   Kunal
-- 3   Ishan 3   Ishan
-- NULL NULL 4   Marry

SELECT * 
FROM t1 
FULL JOIN t2 
ON t1.id = t2.id;
-- output:
-- id  name  id  name
-- 1   AYON  NULL NULL
-- 2   Kunal 2   Kunal
-- 3   Ishan 3   Ishan
-- NULL NULL 4   Marry

SELECT * 
FROM t1 
NATURAL JOIN t2;
-- output:
-- id  name  id  name
-- 2   Kunal 2   Kunal
-- 3   Ishan 3   Ishan

SELECT * 
FROM t1 
NATURAL LEFT JOIN t2;
-- output:
-- id  name  id  name
-- 1   AYON  NULL NULL
-- 2   Kunal 2   Kunal
-- 3   Ishan 3   Ishan

SELECT * FROM t1 NATURAL RIGHT JOIN t2;

SELECT * FROM t1 NATURAL FULL JOIN t2;






select * from employee;


-- _________DML_________
-- ___ALTER TABLE employee___

-- CREATE
-- ALTER
-- DROP
-- TRUNCATE
-- RENAME
alter table employee
alter column skilled type varchar;

alter table employee
alter column salary set not null;

alter table employee
alter column salary drop not null;

alter table employee
add column skills VARCHAR null;


alter table employee
add constraint greater check (salary>200);

-- rename 
alter table emp
rename to employee;

alter table employee
rename column skills to skilled;

alter table employee
drop column skills;

drop table std;
-- primary key

truncate table std;

create table std(
	id int ,
	name varchar
);
alter table std
add primary key (id);


insert into std values (1,'AYON');
insert into std values (2,'karmakar');

select * from std;




-- Foreign key

drop table custm;
truncate table custm;
create table custm(
	id int primary key,
	name varchar
);
select * from custm;


drop table odr;
truncate table odr;
create table odr(
	custm_id int,
	amt int,
	constraint fk foreign key (custm_id) references custm(id)
);
alter table odr constraint fk foreign key (custm_id) references custm(id);






-- for deleting complete data
alter table odr 
add constraint fk foreign key (custm_id) 
references custm(id)
on delete cascade; -- while deleting there should be no problems eg. when user gets logout forever no user id so in that wat there should be no users order;
-- -or-
on delete set null; -- this will just set null order exist's but user is no user
-- -or-
on delete set null on update set null;

alter table odr 
add constraint fk foreign key (custm_id) 
references custm(id)
on delete set null
on update cascade;

delete from custm; -- now this will delete the complete data about user and it's orders

update custm
set id = 143
where id = 1;



select * from odr;


insert into custm values (1,'AYON'); 
insert into odr values (1,99);
insert into odr values (1,299);



-- -------------------------< Subqueries in SQL >--------------------
-- Display the names who earns above average salary of there own department
-- like in sde3 avg = 100k and above avg is ayon, Karmakar where both are sde3 and both earns above 100k
select name from employee
where salary > (select avg(salary) from employee)
group by salary;

select 'YES'
from employee 
where name='AYON'; -- Print yes if where True





select * from employee;

create table department (id int,department_id varchar);

insert into department values (1,'hr');

select * from department;


-- shifting all the hr to the canada rest at india
select name,case
when department='hr' 
	then'canada' 
	else 'india'
end 
from employee;



create table transfersde(trasid int, sdelevel varchar);
insert into transfersde values
(1,'sde1'),
(2,'sde2'),
(3,'sde3');
drop table transfersde;
select * from transfersde;
-- if the name in transfersde then 'united states' else 'india'
select name,case
when department=( select sdelevel from transfersde where sdelevel='sde3')
then 'United States'
else 'india'
end 
from employee;

-- display all the names withe it's branch contry name 
-- if departement == sde1 or sde2 or sde3 are transfered to 'united states' else 'india'
select name,case
when department=( select sdelevel from transfersde where sdelevel=employee.department)
then 'United States'
else 'india'
end
from employee;


-- problems
# Write your MySQL query statement below
SELECT 
    sell_date,
    count(distinct product) as num_sold,
    group_concat(distinct product order by product asc) as products
    
FROM Activities
GROUP BY sell_date;




-- Limit in sql
SELECT first_name, age
FROM Customers
LIMIT 2;


-- ANY AND SOME -> REM
select first_name, last_name, department_id
from employees
where department_id = ANY (select department_id from departments where location_id = 1700);
-- It si like any -> any of them or in python var in list

-- <or> -
select first_name, last_name, department_id
from employees
where department_id = SOME (select department_id from departments where location_id = 1700);

select first_name, last_name, department_id
from employees
where department_id in (select department_id from departments where location_id = 1700);



-- Exists & not Exists
EXISTS -> returns True if exists at lease one else returns False

select id, first_name, department_id
from employees E
where exists (select * from departments D where D.department_id = E.department_id and D.location_id = 1700);


-- From
select sc1,sc2,sc3
from (select c1 as sc1, c2 as sc2, c3*3 as sc3 from tb1) as tb2
where sc1 >1;

<<<<<<< HEAD
insert into tb2 (select * from tbq);
=======


insert into tb2 (select * from tbq);


GRANT ALL PRIVILEGES ON DATABASE your_database TO new_username;
>>>>>>> 88d2ff3c389da92908c93b7cd345659a740f65da
