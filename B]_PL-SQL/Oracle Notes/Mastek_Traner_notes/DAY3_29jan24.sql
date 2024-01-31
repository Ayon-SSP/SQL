--create table person(
--    name varchar2(25),
--    dateOfBirth date
--);
--select * from person;
--
--insert into person values(null,null);
--insert into person values(null,'12-Dec-23');
--insert into person values('Sheldon',null);
--insert into person values('Sheldon','12-dec-23');
--
---- Data -> Valid not null unless we really don't know the value 
---- WE want to ensure that name,date has a value its not null
----a. Drop table and recreate -- best option
----b. alter table
--truncate table person;
--
--alter table person
--modify name varchar2(25) not null;
--
--select * from person;
--
--insert into person values(null,null);
--insert into person values(null,'12-Dec-23');
--insert into person values('Sheldon',null);
--insert into person values('Sheldon','12-dec-23');
--
---- if dob is not know default '01-Jun-1975'
--alter table person
--modify dateofbirth date default '01-Jun-1975';
--
---- DML Insert -> add new record
---- DML Update -> when you want to modify/change a value of a column 
--update person 
--set dateofbirth='01-Jun-1975'
--where name='Sheldon';
--
--rollback ;
--select * from person;
--update person 
--set dateofbirth='01-Jun-1975'
--where name='Sheldon' and dateofbirth is null;
-- #########################
CREATE TABLE people(
person_id NUMBER(3,0) primary key,
persona_name varchar2(35) not null,
dateOfBirth date default '01-Jun-1950'
);
-- dml 
-- 1. In the order of creation 
-- People(perso_id, person_name,dateofbirth)
insert into people values(1,'Sakshi War','01-Jan-1999');
insert into people values(2,'Yash Tripathi','01-Feb-1999');
insert into people values(3,'Pradyumna Thakare','01-Mar-1999');
insert into people values(4,'Gaurav Shelke','01-Apr-1999');
-- 2. Change the order of insertion the data
-- People( person_name,dateofbirth,perso_id)
insert into people 
(persona_name,dateofbirth,person_id)
values('Ankita Vishnupurikar','01-May-1999',5);


--create table test1(
--nuid number(3,0),
--uid numeric(2,0)
--)
--drop table test1;


create table dept(
deptno number(3) primary key,
dname varchar2(25) not null
);

CREATE TABLE emp(
    empno number(3) primary key,
    ename varchar2(50) not null,
    job varchar2(25) not null,
    hiredate date not null,
    sal number(7,2) check(sal>0),
    comm number(7,2),
    mgr number(3) ,
    deptno number(3) references dept(deptno)
);
--mgr number(3) REFERENCES emp(empno),
-- alter table -> create foreignkey for mgr


create table test1(
 pk_id number(2) primary key,
 uk_id number(2) unique
);
select * from test1;
INSERT INTO test1 VALUES (1,11);
INSERT INTO test1 VALUES (2,null);
--INSERT INTO test1 VALUES (null,12);--we get error for primary key
INSERT INTO test1 VALUES (3,null);
INSERT INTO test1 VALUES (4,null);

select distinct uk_id,pk_id from test1


drop table test1;
--create table test1(
--id number(3) primary key,
--text 
--)


create table test1(
    id number(3) not null,
    text varchar2(10) not null,
    primary key (id,text)
)

INSERT INTO test1 VALUES (1,'text1');
INSERT INTO test1 VALUES (2,'text1');
select * from test1;
INSERT INTO test1 VALUES (1,'text2');
INSERT INTO test1 VALUES (2,'text2');
-- reenter
INSERT INTO test1 VALUES (1,'text1');
INSERT INTO test1 VALUES (2,'text1');

select * from orderdetails;
commit;
