create table branch(
branchno number(3) constraint pk_branch_branchno PRIMARY key,
branchName varchar2(25) not null,
location varchar(25) not null
);

insert into branch (branchno,branchname,location) values (101,'Geneva','NEW YORK');
INSERT INTO BRANCH VALUES 	(102,'Geneva','NEW YORK');
INSERT INTO BRANCH VALUES 	(103,'CHICAGO','CHICAGO');
INSERT INTO BRANCH VALUES 	(104,'CHICAGO','CHICAGO');
INSERT INTO BRANCH VALUES 	(105,'Kingston','NEW YORK');
INSERT INTO BRANCH VALUES 	(106,'Kingston','NEW YORK');

DROP TABLE dept;
create table dept(
  deptNo number(2,0) constraint pk_dept_deptno primary key,
  dname varchar2(50) not null,
  branchno number(3,0) constraint fk_branch_branchno REFERENCES branch
);

INSERT INTO DEPT VALUES	(10,'ACCOUNTING',101);
INSERT INTO DEPT VALUES (20,'RESEARCH',103);
INSERT INTO DEPT VALUES	(30,'SALES',105);
INSERT INTO DEPT VALUES	(40,'OPERATIONS',106);

-- create table dept1(
-- deptNo number(2,0),
-- dname varchar2(50) not null,
-- branchno number(3,0),
-- constraint pk_dept1_deptno primary key (deptno)
-- )

-- alter table dept1
-- add foreign key (branchno) REFERENCES branch(branchno);

-- alter table dept1
-- add my_text varchar2(40) not null;

-- alter table dept1
-- drop column my_text;


-- alter table dept1
-- add my_text varchar2(40) default 'Some text';
-- add my_text varchar2(40) not null;  gives error 
-- alter table dept1
-- modify my_text varchar2(40) default 'Some text' not null;

-- insert into dept1 values(2,'dept2',101,'mytext');
-- insert into dept1(deptno,dname,branchno) values(3,'dept2',101);
-- insert into dept1 values(4,'dept2',101,null);


-- truncate table dept1;
-- drop table dept1;

drop table emp;
create table emp(   
  empno    number(4,0),   
  ename    varchar2(10),   
  job      varchar2(9),   
  mgr      number(4,0),   
  hiredate date,   
  sal      number(7,2),   
  comm     number(7,2),   
  deptno   number(2,0),     
  constraint pk_emp primary key (empno),   
  constraint fk_deptno foreign key (deptno) references dept (deptno)   
);

alter table emp
ADD  BRANCHNO INT CONSTRAINT FK_EMP_BRANCHNO REFERENCES BRANCH;

INSERT INTO EMP VALUES(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20,102);
INSERT INTO EMP VALUES(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30,102);
INSERT INTO EMP VALUES(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30,103);
INSERT INTO EMP VALUES(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20,104);
INSERT INTO EMP VALUES(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30,105);
INSERT INTO EMP VALUES(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30,105);
INSERT INTO EMP VALUES(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10,102);
INSERT INTO EMP VALUES(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87')-85,3000,NULL,20,103);
INSERT INTO EMP VALUES(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,NULL,101);
INSERT INTO EMP VALUES(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30,104);
INSERT INTO EMP VALUES(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87')-51,1100,NULL,20,105);
INSERT INTO EMP VALUES(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30,103);
INSERT INTO EMP VALUES(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20,105);
INSERT INTO EMP VALUES(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10,104);
INSERT INTO EMP VALUES(7901,'JOHN_SMITH','CLERK',7698,to_date('23-1-1982','dd-mm-yyyy'),3000,NULL,30,104);
commit;


select * from emp;








--Q1. Display employee name,job,sal,comm in asc order of job
--Q2. Display employee name,job,sal,comm in asc order of sal
--Q3. Display employee name,job,sal,comm in asc order of comm

SELECT ename,job,sal,comm FROM emp ORDER BY job;
SELECT ename,job,sal,comm FROM emp ORDER BY sal;
SELECT ename,job,sal,comm FROM emp ORDER BY comm;


--Q4. Display employee name,job,sal,comm,deptno in asc order of deptno
--Q5. Display employee name,job,sal,comm,deptno in asc order of deptno,job
--Q6. Display employee name,job,sal,comm,deptno in asc order of deptno,sal,comm

SELECT ename,job,sal,comm,deptno FROM emp ORDER BY deptno;
SELECT ename,job,sal,comm,deptno FROM emp ORDER BY deptno,job;
SELECT ename,job,sal,comm,deptno FROM emp ORDER BY deptno,sal,comm;


--Q7. Fetch 5 top employees earning highest
--Q8. Fetch 2nd Highest salaried employee details
--Q9. Display list of all employees working in department 20

SELECT * FROM emp 
ORDER BY sal DESC 
FETCH FIRST 5 ROWS ONLY;

SELECT * FROM emp 
ORDER BY sal DESC 
OFFSET 1 ROW FETCH FIRST 1 ROWS ONLY;

SELECT * FROM emp WHERE deptno = 20;

--Q10. Display list of all employees working in department 30
--Q11. Display list of all employees working in department 10

SELECT * FROM emp WHERE deptno = 30;
SELECT * FROM emp WHERE deptno = 10;

--Q15. Display list of all employees working as PRESIDENT
--Q16. Display list of all employees EARNING SAL BETWEEN 500 TO 4000
--Q17. Display list of all employees EARNING SAL NOT BETWEEN 500 TO 4000
--Q18. COMPARISON
--Q18.A. Display list of all employees EARNING SAL >500
--Q18.B. Display list of all employees EARNING SAL <500
--Q18.C. Display list of all employees EARNING SAL <=500
--Q18.D. Display list of all employees EARNING SAL <=500
--Q18.E. Display list of all employees EARNING SAL !=800
--Q18.F. Display list of all employees EARNING SAL =5000

SELECT * FROM emp WHERE job = 'PRESIDENT';
SELECT * FROM emp WHERE sal BETWEEN 500 AND 4000;
SELECT * FROM emp WHERE sal NOT BETWEEN 500 AND 4000;
SELECT * FROM emp WHERE sal > 500;
SELECT * FROM emp WHERE sal < 500;
SELECT * FROM emp WHERE sal <= 500;
SELECT * FROM emp WHERE sal >= 500;
SELECT * FROM emp WHERE sal != 800;
SELECT * FROM emp WHERE sal = 5000;



--Q19. LOGICAL OPERATOR AND OR NOT/LIKE/IN/NOT IN/BETWEEN NOT BETWEEN
--Q19.A DISPLAY EMPLOYEE WORKING IN DEPARTMENT 10 AS CLERK
--Q19.B DISPLAY EMPLOYEE WORKING IN DEPARTMENT 20 AS MANAGER
--Q19.C DISPLAY EMPLOYEE WORKING IN DEPARTMENT 30 AS SALESMAN
--Q19.D DISPLAY EMPLOYEE WHO ARE WORKING AS MANAGER BUT NOT IN DEPT 10
--Q19.E DISPLAY EMPLOYEE WORKING AS CLERK,MANAGER
--Q19.F DISPLAY EMPLOYEE WORKING IN DEPTNO 20,30
--Q19.G DISPLAY EMPLOYEE NOT WORKING IN DEPTNO 20,30
--Q19.H DISPLAY EMPLOYEE NOT WORKING AS CLERK,MANAGER
--Q19.I DISPLAY EMPLOYEE WHO'S NAME STARTS WITH 'S'
--Q19.J DISPLAY EMPLOYEE WHO'S NAME ENDSS WITH 'S'
--Q19.K DISPLAY EMPLOYEE WHO'S NAME HAS  'LL'
--Q19.L DISPLAY EMPLOYEE WHO'S NAME CONTAINS '_'

SELECT * FROM emp WHERE deptno = 10 AND job = 'CLERK';
SELECT * FROM emp WHERE deptno = 20 AND job = 'MANAGER';
SELECT * FROM emp WHERE deptno = 30 AND job = 'SALESMAN';
SELECT * FROM emp WHERE job = 'MANAGER' AND deptno != 10;
SELECT * FROM emp WHERE job = 'CLERK' OR job = 'MANAGER';
SELECT * FROM emp WHERE deptno = 20 OR deptno = 30;
SELECT * FROM emp WHERE deptno NOT IN (20,30);
SELECT * FROM emp WHERE job NOT IN ('CLERK','MANAGER');
SELECT * FROM emp WHERE ename LIKE 'S%';
SELECT * FROM emp WHERE ename LIKE '%S';
SELECT * FROM emp WHERE ename LIKE '%LL%';
SELECT * FROM emp WHERE ename LIKE '_S%';

--Q20. DISPLAY UNIUE JOB FROM EMPLOYE TABLE

SELECT DISTINCT job FROM emp;

