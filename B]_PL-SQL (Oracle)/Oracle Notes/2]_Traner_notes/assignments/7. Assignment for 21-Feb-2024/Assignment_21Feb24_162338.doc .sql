--Assignment   21-FEB-24 

-- HR schema  (emp, dept, branch) 
create table branch(
    branchno number(3) constraint pk_branch_branchno PRIMARY key,
    branchName varchar2(25) not null,
    location varchar(25) not null
);

INSERT INTO BRANCH (branchno,branchname,location) values (101,'Geneva','NEW YORK');
INSERT INTO BRANCH VALUES 	(102,'Geneva','NEW YORK');
INSERT INTO BRANCH VALUES 	(103,'CHICAGO','CHICAGO');
INSERT INTO BRANCH VALUES 	(104,'CHICAGO','CHICAGO');
INSERT INTO BRANCH VALUES 	(105,'Kingston','NEW YORK');
INSERT INTO BRANCH VALUES 	(106,'Kingston','NEW YORK');

create table dept(
    deptNo number(2,0) constraint pk_dept_deptno primary key,
    dname varchar2(50) not null,
    branchno number(3,0) constraint fk_branch_branchno REFERENCES branch
);

INSERT INTO DEPT VALUES	(10,'ACCOUNTING',101);
INSERT INTO DEPT VALUES (20,'RESEARCH',103);
INSERT INTO DEPT VALUES	(30,'SALES',105);
INSERT INTO DEPT VALUES	(40,'OPERATIONS',106);

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

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM BRANCH;

DROP TABLE emp;
DROP TABLE dept;
DROP TABLE branch;

-- Conditional Statement: PLSQL Conditional Statement, Looping statement, Variables, Records, Cursor and Ref Cursor/sys_refcursosr 
-- Q1. Write a PL/SQL anonymous block to calculate the total salary of employees working in the 'Sales' department. If the total salary exceeds 100000, display "Bonus Granted", otherwise display "No Bonus". 
DECLARE
    v_total_salary emp.sal%TYPE; 
BEGIN
    SELECT SUM(sal) INTO v_total_salary
    FROM emp
    WHERE job = 'Sales';

    IF v_total_salary > 100000 THEN
        DBMS_OUTPUT.put_line('Bonus Granted');
    ELSE
        DBMS_OUTPUT.put_line('No Bonus');
    END IF;
END;
/

-- Q2. Create a PL/SQL block to calculate the `average salary of employees in each department`. If the average salary is greater than 50000, print "High Paying Department", else print "Normal Paying Department". 
DECLARE
    CURSOR dept_rec IS
        SELECT 
            deptno, 
            ROUND(AVG(sal), 2) as avg_sal
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno
        ORDER BY deptno;

    dept_rec_row dept_rec%ROWTYPE;

BEGIN
    OPEN dept_rec;

    LOOP
        FETCH dept_rec INTO dept_rec_row;
        EXIT WHEN dept_rec%NOTFOUND;

        IF dept_rec_row.avg_sal > 50000 THEN
            DBMS_OUTPUT.put_line('Department '|| dept_rec_row.deptno ||' is a High Paying Department');
        ELSE
            DBMS_OUTPUT.put_line('Department '|| dept_rec_row.deptno ||' is a Normal Paying Department');
        END IF;
        
    END LOOP;
    CLOSE dept_rec;
    -- Exception block for curssor
    EXCEPTIONS
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('An error occurred');
END;
/

-- Q3 Write a PL/SQL anonymous block to find the employee with the highest salary in each department. 
DECLARE
BEGIN
    FOR emp_rec IN (
        SELECT *
        FROM (
            SELECT empno,
                ename,
                sal,
                deptno,
                ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) AS row_num
            FROM EMP
        )
        WHERE row_num = 1
    ) 
    LOOP
        DBMS_OUTPUT.put_line('Dept ' || emp_rec.deptno || ' - Emp: ' || emp_rec.ename || ' (Emp_no: ' || emp_rec.empno || ') has the highest salary: ' || emp_rec.sal);
    END LOOP;
END;
/

-- Q4 Create a PL/SQL block to give a 10% raise to employees in the 'IT' department and a 5% raise to employees in the 'HR' department. 
SELECT * 
FROM emp 
WHERE deptno = 30;

DECLARE
    TYPE sal_raise_type 
        IS TABLE OF NUMBER
        INDEX BY dept.dname%TYPE;
    
    sal_raise sal_raise_type;

BEGIN
    sal_raise('IT') := 0.1;
    sal_raise('HR') := 0.05;
    sal_raise('SALES') := 0.2; -- deptno is 30

    FOR emp_rec IN (
        SELECT 
            deptno, 
            dname
        FROM dept
        WHERE DNAME IN ('IT', 'HR', 'SALES')
    )
    LOOP
        UPDATE emp
        SET sal = ROUND(sal + (sal * sal_raise(emp_rec.dname)), 2)
        WHERE deptno = emp_rec.deptno;
    END LOOP;
END;
/

SELECT * 
FROM emp 
WHERE deptno = 30;

-- ROLLBACK;

-- Q5 Write a PL/SQL block to display the names of employees who have a commission greater than their salary. 
DECLARE 
	v_ename emp.ename%TYPE;
BEGIN
	FOR
	emp_rec IN ( SELECT ename, sal, NVL(comm,0) AS comm FROM emp )
	LOOP
		IF emp_rec.sal<emp_rec.comm THEN
            v_ename := emp_rec.ename;
            DBMS_OUTPUT.put_line('Employee Name: ' || v_ename
                || 'Salary is ' || emp_rec.sal || 'Commition' || emp_rec.comm
            );
		END IF;
	END LOOP;
END;
/


-- Loop:
-- Q6. Display all employees' names and salaries in a specific department using a loop.
DECLARE
    v_deptno emp.deptno%TYPE := 20; --specifying department
BEGIN
	FOR
	emp_rec IN (
        SELECT ename, sal, deptno 
        FROM EMP e 
        WHERE deptno=v_deptno
    )
	LOOP
		dbms_output.put_line('Employee Name: '||emp_rec.ename||', Salary: '||emp_rec.sal||', DepartmentID: '||emp_rec.deptno);
		
	END LOOP;
	
END;
/

-- Q7. Calculate and display the total salary expense for a specific branch using a loop. 
DECLARE
    dept_total_sal NUMBER;
BEGIN
	FOR dept_rec IN ( SELECT deptno, dname FROM dept )
	LOOP 
        dept_total_sal := 0;

        FOR emp_rec IN (SELECT sal FROM emp WHERE deptno = dept_rec.deptno)
        LOOP
            dept_total_sal := dept_total_sal + emp_rec.sal;
        END LOOP;
        dbms_output.put_line('Branch No: '|| dept_rec.deptno || '( ' || dept_rec.dname || ' )' ||' SALARY EXPENSE: '|| dept_total_sal );
	END LOOP;
END;
/

-- Q8. Find and display the names of employees who earn a commission using a loop.
BEGIN
	FOR emp_rec IN (
        SELECT ename, comm 
        FROM EMP
        WHERE comm IS NOT NULL
            AND comm != 0
    )
	LOOP
		dbms_output.put_line('Employee Name: '|| emp_rec.ename ||', Commission: '||emp_rec.comm);
		
	END LOOP;
END;
/

-- Q9. Display the names of employees who have a manager using a loop. 
BEGIN
	FOR emp_rec IN (
        SELECT ename, mgr 
        FROM EMP
        WHERE mgr IS NOT NULL
    )
	LOOP
		dbms_output.put_line('Employee Name: '|| emp_rec.ename ||', Manager: '||emp_rec.mgr);
		
	END LOOP;
END;
/

-- Q10. Calculate and display the average salary of all employees in a specific department using a loop. 
BEGIN
    FOR dept_rec IN (SELECT deptno, dname FROM dept)
    LOOP
        FOR emp_rec IN (SELECT ROUND(AVG(sal), 2) AS avg_sal FROM emp WHERE dept_rec.deptno = deptno)
        LOOP
            dbms_output.put_line('Dept: '|| dept_rec.dname || '( ' || dept_rec.deptno || ' )'||', Average Salary: '|| emp_rec.avg_sal);
        END LOOP;
    END LOOP;
END;
/

SELECT * FROM DEPT;


-- Variable,%Rowtype,%type,Constant 
-- Q11. Write a PL/SQL anonymous block to calculate the total salary of all employees in a given department. 
DECLARE
    CURSOR emp_rec IS
        SELECT deptno, SUM(sal) AS total_sal
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno;

    emp_rec_row emp_rec%ROWTYPE;

BEGIN
    OPEN emp_rec;

    LOOP
        FETCH emp_rec INTO emp_rec_row;
        EXIT WHEN emp_rec%NOTFOUND;
        
        DBMS_OUTPUT.put_line('Department '|| emp_rec_row.deptno ||' Total salary' || emp_rec_row.total_sal );
        
    END LOOP;
    CLOSE emp_rec;
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q12. Create a PL/SQL anonymous block to retrieve all information about an employee with empno 7839. 
DECLARE
    CURSOR emp_rec IS
        SELECT *
        FROM emp
        WHERE empno = 7839;
    
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_job emp.job%TYPE;
    v_mgr emp.mgr%TYPE;
    v_hiredate emp.hiredate%TYPE;
    v_sal emp.sal%TYPE;
    v_comm emp.comm%TYPE;
    v_deptno emp.deptno%TYPE;
    v_branchno emp.branchno%TYPE;

BEGIN
    OPEN emp_rec;
    LOOP
        FETCH emp_rec INTO v_empno, v_ename, v_job, v_mgr, v_hiredate, v_sal, v_comm, v_deptno, v_branchno;
        EXIT WHEN emp_rec%NOTFOUND;

        DBMS_OUTPUT.put_line('Employee No: '|| v_empno);
        DBMS_OUTPUT.put_line('Employee Name: '|| v_ename);
        DBMS_OUTPUT.put_line('Job: '|| v_job);
        DBMS_OUTPUT.put_line('Manager: '|| v_mgr);
        DBMS_OUTPUT.put_line('Hire Date: '|| v_hiredate);
        DBMS_OUTPUT.put_line('Salary: '|| v_sal);
        DBMS_OUTPUT.put_line('Commission: '|| v_comm);
        DBMS_OUTPUT.put_line('Department No: '|| v_deptno);
        DBMS_OUTPUT.put_line('Branch No: '|| v_branchno);

    END LOOP;
    CLOSE emp_rec;
    -- exception
END;
/

-- Q13. Declare a variable to store the commission of an employee and assign a commission rate of 0.15. 
DECLARE
    v_comm emp.comm%TYPE ;
    v_comm_rate CONSTANT NUMBER := 0.15;
BEGIN
    SELECT comm INTO v_comm
    FROM emp
    WHERE empno = 7499;

    v_comm := v_comm * v_comm_rate;
    DBMS_OUTPUT.put_line('Commission: '|| v_comm);

    
END;
/

-- Q14. Define a constant to represent the maximum salary allowed in the company and assign a value of 10000 to it. 
DECLARE
    max_salary CONSTANT emp.sal%TYPE := 10000;
BEGIN
    DBMS_OUTPUT.put_line('Maximum Salary Allowed: ' || max_salary);
END;
/

-- Q15. Write a PL/SQL block to retrieve the location of the branch where the department with deptno 20 is located.
DECLARE
    v_location branch.location%TYPE;
BEGIN
    SELECT location INTO v_location
    FROM branch b
    JOIN dept d
    ON b.branchno = d.branchno
    WHERE deptno = 20;

    DBMS_OUTPUT.put_line('Location: '|| v_location);
END;
/


-- Cursor:
-- Q16. Write a PL/SQL anonymous block to display the names of all employees along with their salaries. Hint user cursor 
DECLARE
    CURSOR emp_rec IS
        SELECT ename, sal
        FROM emp;
    
    emp_rec_row emp_rec%ROWTYPE;
BEGIN
    OPEN emp_rec;
    LOOP
        FETCH emp_rec INTO emp_rec_row;
        EXIT WHEN emp_rec%NOTFOUND;

        DBMS_OUTPUT.put_line('Employee Name: '|| emp_rec_row.ename ||', Salary: '|| emp_rec_row.sal);
    END LOOP;
    CLOSE emp_rec;
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q17. Create a PL/SQL anonymous block to find the total number of employees in each department. Hint user cursor 
DECLARE
    CURSOR dept_rec IS
        SELECT deptno, COUNT(*) AS total_emp
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno;

    dept_rec_row dept_rec%ROWTYPE;

BEGIN
    OPEN dept_rec;
    LOOP
        FETCH dept_rec INTO dept_rec_row;
        EXIT WHEN dept_rec%NOTFOUND;

        DBMS_OUTPUT.put_line('Department '|| dept_rec_row.deptno ||' Total Employees: '|| dept_rec_row.total_emp );
    END LOOP;
    CLOSE dept_rec;
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q18. Write a PL/SQL anonymous block to display the details of employees who have a commission. 
DECLARE
    CURSOR emp_rec IS
        SELECT *
        FROM emp
        WHERE comm IS NOT NULL
            AND comm != 0;
    
    emp_rec_row emp_rec%ROWTYPE;
BEGIN
    OPEN emp_rec;
    LOOP
        FETCH emp_rec INTO emp_rec_row;
        EXIT WHEN emp_rec%NOTFOUND;

        DBMS_OUTPUT.put_line('Employee No: '|| emp_rec_row.empno);
        DBMS_OUTPUT.put_line('Employee Name: '|| emp_rec_row.ename);
        DBMS_OUTPUT.put_line('Commission: '|| emp_rec_row.comm);
        DBMS_OUTPUT.put_line('____________________________________');
    END LOOP;
    CLOSE emp_rec;
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q19. Create a PL/SQL anonymous block to find the average salary of employees in each department. 
DECLARE
    CURSOR dept_rec IS
        SELECT deptno, ROUND(AVG(sal), 2) AS avg_sal
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno;

    dept_rec_row dept_rec%ROWTYPE;

BEGIN
    OPEN dept_rec;
    LOOP
        FETCH dept_rec INTO dept_rec_row;
        EXIT WHEN dept_rec%NOTFOUND;

        DBMS_OUTPUT.put_line('Department '|| dept_rec_row.deptno ||' Average Salary: '|| dept_rec_row.avg_sal );
    END LOOP;
    CLOSE dept_rec;
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q20. Write a PL/SQL anonymous block to display the names of all employees along with their managers' names. 
DECLARE
    CURSOR emp_rec IS
        SELECT e.ename, m.ename AS manager_name
        FROM emp e
        JOIN emp m
        ON e.mgr = m.empno;
    
    emp_rec_row emp_rec%ROWTYPE;

BEGIN
    OPEN emp_rec;
    
    DBMS_OUTPUT.put_line('Employee Name' || RPAD(' ', 10) || 'Manager');
    DBMS_OUTPUT.put_line('-----------------------------------');
    
    LOOP
        FETCH emp_rec INTO emp_rec_row;
        EXIT WHEN emp_rec%NOTFOUND;

        DBMS_OUTPUT.put_line(RPAD(emp_rec_row.ename, 20) || RPAD(' ', 10) || emp_rec_row.manager_name);
    END LOOP;
    
    CLOSE emp_rec;
    
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/


-- REF Cursor :
-- Q21. Write a PL/SQL block to fetch and display the details of all employees in department 10. 
DECLARE
    TYPE emp_ref_cursor IS REF CURSOR;
    v_emp_cursor emp_ref_cursor;
    v_emp_rec emp%ROWTYPE;
BEGIN
    OPEN v_emp_cursor FOR
        SELECT *
        FROM emp
        WHERE deptno = 10;

    DBMS_OUTPUT.put_line('----------------------------------------');
    LOOP
        FETCH v_emp_cursor INTO v_emp_rec;
        EXIT WHEN v_emp_cursor%NOTFOUND;

        DBMS_OUTPUT.put_line('Employee No: '|| v_emp_rec.empno);
        DBMS_OUTPUT.put_line('Employee Name: '|| v_emp_rec.ename);
        DBMS_OUTPUT.put_line('Job: '|| v_emp_rec.job);
        DBMS_OUTPUT.put_line('Manager: '|| v_emp_rec.mgr);
        DBMS_OUTPUT.put_line('Hire Date: '|| v_emp_rec.hiredate);
        DBMS_OUTPUT.put_line('Salary: '|| v_emp_rec.sal);
        DBMS_OUTPUT.put_line('Commission: '|| v_emp_rec.comm);
        DBMS_OUTPUT.put_line('Department No: '|| v_emp_rec.deptno);
        DBMS_OUTPUT.put_line('Branch No: '|| v_emp_rec.branchno);
        DBMS_OUTPUT.put_line('----------------------------------------');
    END LOOP;
    CLOSE v_emp_cursor;
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q22. Write a PL/SQL block to display the total salary expense for each department. 
DECLARE
    TYPE emp_rec_type IS RECORD (
        deptno emp.deptno%TYPE,
        total_sal emp.sal%TYPE
    );
    
    TYPE emp_ref_cursor IS REF CURSOR 
    RETURN emp_rec_type;
    
    v_emp_cursor emp_ref_cursor;
    v_emp_rec emp_rec_type;
BEGIN
    OPEN v_emp_cursor FOR
        SELECT deptno, SUM(sal) AS total_sal
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno
        ORDER BY deptno;

    LOOP
        FETCH v_emp_cursor INTO v_emp_rec;
        EXIT WHEN v_emp_cursor%NOTFOUND;
        DBMS_OUTPUT.put_line('Department No: '|| v_emp_rec.deptno || ', Total Salary: ' || v_emp_rec.total_sal);
    END LOOP;

    CLOSE v_emp_cursor;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.put_line('No data found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q23. Write a PL/SQL block to fetch and display the details of employees whose salary is greater than 5000. 
DECLARE
    TYPE emp_ref_cursor IS REF CURSOR;
    v_emp_cursor emp_ref_cursor;
    v_emp_rec emp%ROWTYPE;
BEGIN
    OPEN v_emp_cursor FOR
        SELECT *
        FROM emp
        WHERE sal > 5000;

    DBMS_OUTPUT.put_line('----------------------------------------');
    LOOP
        FETCH v_emp_cursor INTO v_emp_rec;
        EXIT WHEN v_emp_cursor%NOTFOUND;

        DBMS_OUTPUT.put_line('Employee No: '|| v_emp_rec.empno);
        DBMS_OUTPUT.put_line('Employee Name: '|| v_emp_rec.ename);
        DBMS_OUTPUT.put_line('Job: '|| v_emp_rec.job);
        DBMS_OUTPUT.put_line('Manager: '|| v_emp_rec.mgr);
        DBMS_OUTPUT.put_line('Hire Date: '|| v_emp_rec.hiredate);
        DBMS_OUTPUT.put_line('Salary: '|| v_emp_rec.sal);
        DBMS_OUTPUT.put_line('Commission: '|| v_emp_rec.comm);
        DBMS_OUTPUT.put_line('Department No: '|| v_emp_rec.deptno);
        DBMS_OUTPUT.put_line('Branch No: '|| v_emp_rec.branchno);
        DBMS_OUTPUT.put_line('----------------------------------------');
    END LOOP;
    CLOSE v_emp_cursor;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q24. Write a PL/SQL block to fetch and display the details of employees who work in the 'New York' branch. 
DECLARE
    
    TYPE emp_dept_ref_cursor IS REF CURSOR
        RETURN emp%ROWTYPE;

    emp_dept_cursor emp_dept_ref_cursor;
    emp_dept_rec emp%ROWTYPE;

BEGIN
    OPEN emp_dept_cursor FOR
        SELECT 
            e.empno, 
            e.ename, 
            e.job, 
            e.mgr, 
            e.hiredate, 
            e.sal, 
            e.comm, 
            e.deptno, 
            e.branchno
        FROM emp e
        JOIN branch b
        ON e.branchno = b.branchno
        WHERE b.location = 'NEW YORK';

    DBMS_OUTPUT.put_line('-------------------------------------------------------------------------------');
    DBMS_OUTPUT.put_line('Employee No' || RPAD(' ', 10) || 'Employee Name' || RPAD(' ', 10) || 'Job' || RPAD(' ', 10) || 'Manager' || RPAD(' ', 10) || 'Hire Date' || RPAD(' ', 10) || 'Salary' || RPAD(' ', 10) || 'Commission' || RPAD(' ', 10) || 'Department No' || RPAD(' ', 10) || 'Branch No');
    DBMS_OUTPUT.put_line('-------------------------------------------------------------------------------');
    LOOP
        FETCH emp_dept_cursor INTO emp_dept_rec;
        EXIT WHEN emp_dept_cursor%NOTFOUND;
        -- DBMS_OUTPUT.put_line(RPAD(emp_rec_row.ename, 20) || RPAD(' ', 10) || emp_rec_row.manager_name);
        DBMS_OUTPUT.put_line('Employee No: '|| emp_dept_rec.empno ||', Employee Name: '|| emp_dept_rec.ename ||', Job: '|| emp_dept_rec.job ||', Manager: '|| emp_dept_rec.mgr ||', Hire Date: '|| emp_dept_rec.hiredate ||', Salary: '|| emp_dept_rec.sal ||', Commission: '|| emp_dept_rec.comm ||', Department No: '|| emp_dept_rec.deptno ||', Branch No: '|| emp_dept_rec.branchno);
    DBMS_OUTPUT.put_line('-------------------------------------------------------------------------------');
    END LOOP;
    CLOSE emp_dept_cursor;
END;
/

-- Q25. Write a PL/SQL block to fetch and display the average salary for employees in each branch. 
DECLARE
    TYPE emp_rec_type IS RECORD(
        branchno emp.branchno%TYPE,
        avg_sal emp.sal%TYPE
    );

    TYPE emp_ref_cursor IS REF CURSOR
        RETURN emp_rec_type;

    emp_cursor emp_ref_cursor;
    emp_rec emp_rec_type;
BEGIN
    OPEN emp_cursor FOR
        SELECT 
            branchno, 
            ROUND(AVG(sal), 2) as avg_sal
        FROM emp
        WHERE branchno IS NOT NULL
        GROUP BY branchno
        ORDER BY branchno;
    
    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.put_line('Department '|| emp_rec.branchno ||' Average Salary: '|| emp_rec.avg_sal );
    END LOOP;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Sys_RefCursor 
-- Q26. Write a PL/SQL block to fetch and display the details of all employees in department 10. 
DECLARE
    emp_cursor SYS_REFCURSOR;
    emp_rec emp%ROWTYPE;
BEGIN
    OPEN emp_cursor FOR
        SELECT *
        FROM emp
        WHERE deptno = 10;

    DBMS_OUTPUT.put_line('----------------------------------------');
    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;

        DBMS_OUTPUT.put_line('Employee No: '|| emp_rec.empno);
        DBMS_OUTPUT.put_line('Employee Name: '|| emp_rec.ename);
        DBMS_OUTPUT.put_line('Job: '|| emp_rec.job);
        DBMS_OUTPUT.put_line('Manager: '|| emp_rec.mgr);
        DBMS_OUTPUT.put_line('Hire Date: '|| emp_rec.hiredate);
        DBMS_OUTPUT.put_line('Salary: '|| emp_rec.sal);
        DBMS_OUTPUT.put_line('Commission: '|| emp_rec.comm);
        DBMS_OUTPUT.put_line('Department No: '|| emp_rec.deptno);
        DBMS_OUTPUT.put_line('Branch No: '|| emp_rec.branchno);
        DBMS_OUTPUT.put_line('----------------------------------------');
    END LOOP;
    CLOSE emp_cursor;
    -- exception
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q27. Write a PL/SQL block to display the total salary expense for each department. 
DECLARE
    TYPE emp_rec_type IS RECORD (
        deptno emp.deptno%TYPE,
        total_sal emp.sal%TYPE
    );
    emp_cursor SYS_REFCURSOR;
    emp_rec emp_rec_type;
BEGIN
    OPEN emp_cursor FOR
        SELECT deptno, SUM(sal) AS total_sal
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno
        ORDER BY deptno;

    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.put_line('Department No: '|| emp_rec.deptno || ', Total Salary: ' || emp_rec.total_sal);
    END LOOP;

    CLOSE emp_cursor;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/
-- Q28. Write a PL/SQL block to fetch and display the details of employees whose salary is greater than 5000. 
DECLARE
    TYPE emp_rec_type IS RECORD (
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        mgr emp.mgr%TYPE,
        hiredate emp.hiredate%TYPE,
        sal emp.sal%TYPE,
        comm emp.comm%TYPE,
        deptno emp.deptno%TYPE,
        branchno emp.branchno%TYPE
    );
    emp_cursor SYS_REFCURSOR;
    emp_rec emp_rec_type;
BEGIN

    OPEN emp_cursor FOR
        SELECT *
        FROM emp
        WHERE sal > 5000;

    DBMS_OUTPUT.put_line('----------------------------------------');
    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;

        DBMS_OUTPUT.put_line('Employee No: '|| emp_rec.empno);
        DBMS_OUTPUT.put_line('Employee Name: '|| emp_rec.ename);
        DBMS_OUTPUT.put_line('Job: '|| emp_rec.job);
        DBMS_OUTPUT.put_line('Manager: '|| emp_rec.mgr);
        DBMS_OUTPUT.put_line('Hire Date: '|| emp_rec.hiredate);
        DBMS_OUTPUT.put_line('Salary: '|| emp_rec.sal);
        DBMS_OUTPUT.put_line('Commission: '|| emp_rec.comm);
        DBMS_OUTPUT.put_line('Department No: '|| emp_rec.deptno);
        DBMS_OUTPUT.put_line('Branch No: '|| emp_rec.branchno);
        DBMS_OUTPUT.put_line('----------------------------------------');
    END LOOP;
    CLOSE emp_cursor;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Q29. Write a PL/SQL block to fetch and display the details of employees who work in the 'New York' branch. 
DECLARE
    TYPE emp_rec_type IS RECORD (
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        mgr emp.mgr%TYPE,
        hiredate emp.hiredate%TYPE,
        sal emp.sal%TYPE,
        comm emp.comm%TYPE,
        deptno emp.deptno%TYPE,
        branchno emp.branchno%TYPE
    );
    emp_cursor SYS_REFCURSOR;
    emp_rec emp_rec_type;
BEGIN
    OPEN emp_cursor FOR
        SELECT 
            e.empno, 
            e.ename, 
            e.job, 
            e.mgr, 
            e.hiredate, 
            e.sal, 
            e.comm, 
            e.deptno, 
            e.branchno
        FROM emp e
        JOIN branch b
        ON e.branchno = b.branchno
        WHERE b.location = 'NEW YORK';

    DBMS_OUTPUT.put_line('-------------------------------------------------------------------------------');
    DBMS_OUTPUT.put_line('Employee No' || RPAD(' ', 10) || 'Employee Name' || RPAD(' ', 10) || 'Job' || RPAD(' ', 10) || 'Manager' || RPAD(' ', 10) || 'Hire Date' || RPAD(' ', 10) || 'Salary' || RPAD(' ', 10) || 'Commission' || RPAD(' ', 10) || 'Department No' || RPAD(' ', 10) || 'Branch No');
    DBMS_OUTPUT.put_line('-------------------------------------------------------------------------------');
    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;
        -- DBMS_OUTPUT.put_line(RPAD(emp_rec_row.ename, 20) || RPAD(' ', 10) || emp_rec_row.manager_name);
        DBMS_OUTPUT.put_line('Employee No: '|| emp_rec.empno ||', Employee Name: '|| emp_rec.ename ||', Job: '|| emp_rec.job ||', Manager: '|| emp_rec.mgr ||', Hire Date: '|| emp_rec.hiredate ||', Salary: '|| emp_rec.sal ||', Commission: '|| emp_rec.comm ||', Department No: '|| emp_rec.deptno ||', Branch No: '|| emp_rec.branchno);
    DBMS_OUTPUT.put_line('-------------------------------------------------------------------------------');
    END LOOP;
    CLOSE emp_cursor;


END;
/
-- Q30. Write a PL/SQL block to fetch and display the average salary for employees in each branch. 
DECLARE
    TYPE emp_rec_type IS RECORD(
        branchno emp.branchno%TYPE,
        avg_sal emp.sal%TYPE
    );

    TYPE emp_ref_cursor IS REF CURSOR
        RETURN emp_rec_type;

    emp_cursor SYS_REFCURSOR;
    emp_rec emp_rec_type;
BEGIN
    OPEN emp_cursor FOR
        SELECT 
            branchno, 
            ROUND(AVG(sal), 2) as avg_sal
        FROM emp
        WHERE branchno IS NOT NULL
        GROUP BY branchno
        ORDER BY branchno;
    
    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.put_line('Department '|| emp_rec.branchno ||' Average Salary: '|| emp_rec.avg_sal );
    END LOOP;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No data found');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM );
END;
/

-- Procedure:
-- Q31. Write a PL/SQL procedure to calculate the total salary of all employees in a given department.
CREATE OR REPLACE PROCEDURE total_salary_expense(
    p_deptno IN emp.deptno%TYPE
)
IS
    v_total_sal NUMBER;
BEGIN
    SELECT SUM(sal) INTO v_total_sal
    FROM emp
    WHERE deptno = p_deptno;

    DBMS_OUTPUT.put_line('Department '|| p_deptno ||' Total Salary Expense: '|| v_total_sal );
END;
/ 

EXEC total_salary_expense(10);
EXEC total_salary_expense(20);
EXEC total_salary_expense(30);
-- Q32. Write a PL/SQL procedure to find the average salary of employees in each department and display the result. 
CREATE OR REPLACE PROCEDURE avg_salary_expense
IS
    CURSOR dept_rec IS
        SELECT deptno, ROUND(AVG(sal), 2) AS avg_sal
        FROM emp
        WHERE deptno IS NOT NULL
        GROUP BY deptno;

    dept_rec_row dept_rec%ROWTYPE;
BEGIN
    FOR dept_rec_row IN dept_rec
    LOOP
        DBMS_OUTPUT.put_line('Department '|| dept_rec_row.deptno ||' Average Salary: '|| dept_rec_row.avg_sal );
    END LOOP;
END;
/

EXEC avg_salary_expense;

-- Q33. Write a PL/SQL procedure to update the salary of an employee by a given percentage. 
CREATE OR REPLACE PROCEDURE update_salary(
    p_empno IN emp.empno%TYPE,
    p_percentage IN NUMBER
)
IS
    v_new_sal NUMBER;
BEGIN
    SELECT sal + (sal * (p_percentage / 100)) INTO v_new_sal
    FROM emp
    WHERE empno = p_empno;

    UPDATE emp
    SET sal = v_new_sal
    WHERE empno = p_empno;

    DBMS_OUTPUT.put_line('Employee No: '|| p_empno ||' New Salary: '|| v_new_sal );
END;
/

EXEC update_salary(7839, 10);
EXEC update_salary(7782, 5);
-- ROLLBACK;

-- Q34. Write a PL/SQL procedure to delete all employees in a given department. 
CREATE OR REPLACE PROCEDURE delete_employees(
    p_deptno IN emp.deptno%TYPE
)
IS
BEGIN
    DELETE FROM emp
    WHERE deptno = p_deptno;

    DBMS_OUTPUT.put_line('Employees in Department '|| p_deptno ||' Deleted');
END;
/

EXEC delete_employees(10);
EXEC delete_employees(20);
-- ROLLBACK;

-- Q35. Write a PL/SQL procedure to display the details of all employees in a given branch. 
CREATE OR REPLACE PROCEDURE display_employees(
    p_branchno IN emp.branchno%TYPE
)
IS
    CURSOR emp_rec IS
        SELECT *
        FROM emp
        WHERE branchno = p_branchno;
    
    emp_rec_row emp%ROWTYPE;
BEGIN
    FOR emp_rec_row IN emp_rec
    LOOP
        DBMS_OUTPUT.put_line('Employee No: '|| emp_rec_row.empno);
        DBMS_OUTPUT.put_line('Employee Name: '|| emp_rec_row.ename);
        DBMS_OUTPUT.put_line('Job: '|| emp_rec_row.job);
        DBMS_OUTPUT.put_line('Manager: '|| emp_rec_row.mgr);
        DBMS_OUTPUT.put_line('Hire Date: '|| emp_rec_row.hiredate);
        DBMS_OUTPUT.put_line('Salary: '|| emp_rec_row.sal);
        DBMS_OUTPUT.put_line('Commission: '|| emp_rec_row.comm);
        DBMS_OUTPUT.put_line('Department No: '|| emp_rec_row.deptno);
        DBMS_OUTPUT.put_line('Branch No: '|| emp_rec_row.branchno);
        DBMS_OUTPUT.put_line('----------------------------------------');
    END LOOP;
END;
/

EXEC display_employees(102);


-- Function:
-- Q36. Write a PL/SQL function to calculate the total salary of employees in a given department. 
CREATE OR REPLACE FUNCTION get_total_salary_expense(
    p_deptno IN emp.deptno%TYPE
)
RETURN NUMBER
IS
    v_total_sal NUMBER;
BEGIN
    SELECT SUM(sal) INTO v_total_sal
    FROM emp
    WHERE deptno = p_deptno;

    RETURN v_total_sal;
END;
/

SELECT get_total_salary_expense(10) FROM dual;
SELECT get_total_salary_expense(20) FROM dual;

-- Q37. Create a PL/SQL function to find the average salary of employees in a given branch. 
CREATE OR REPLACE FUNCTION get_avg_salary_expense(
    p_branchno IN emp.branchno%TYPE
)
RETURN NUMBER
IS
    v_avg_sal NUMBER;
BEGIN
    SELECT ROUND(AVG(sal), 2) INTO v_avg_sal
    FROM emp
    WHERE branchno = p_branchno;

    RETURN v_avg_sal;
END;
/

SELECT get_avg_salary_expense(102) FROM dual;

-- Q38. Implement a PL/SQL function to retrieve the name of the branch where a given employee works. 
CREATE OR REPLACE FUNCTION fn_getEmpByBrn(
    v_empno IN emp.empno%TYPE 
)
RETURN branch.branchname%TYPE
IS 
v_branchname branch.branchname%TYPE;
BEGIN
	SELECT branchname INTO v_branchname 
    FROM BRANCH 
    WHERE branchno=(
        SELECT branchno
        FROM EMP
        WHERE empno = v_empno
    );

	RETURN v_branchname;
	
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
		WHEN OTHERS THEN
			RETURN NULL;
END;
/


DECLARE
v_empno emp.empno%TYPE:=7369;
v_branchname branch.branchname%TYPE;
BEGIN
	v_branchname:= fn_getEmpByBrn(7369);
	dbms_output.put_line('Employee No: '||v_empno||' works at '||v_branchname);
END;
/

-- Q39. Write a PL/SQL function to determine the number of employees managed by a given manager. 
CREATE OR REPLACE FUNCTION get_total_managed_employees(
    p_mgr IN emp.mgr%TYPE
)
RETURN NUMBER
IS
    v_total_emp NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_total_emp
    FROM emp
    WHERE mgr = p_mgr;

    RETURN v_total_emp;
END;
/

SELECT get_total_managed_employees(7839) FROM dual;

-- Q40. Create a PL/SQL function to calculate the total commission earned by employees in a given department. 
CREATE OR REPLACE FUNCTION get_total_commission_expense(
    p_deptno IN emp.deptno%TYPE
)
RETURN NUMBER
IS
    v_total_comm NUMBER;
BEGIN
    SELECT SUM(comm) INTO v_total_comm
    FROM emp
    WHERE deptno = p_deptno;

    RETURN v_total_comm;
END;
/

SELECT get_total_commission_expense(30) FROM dual;


-- Package:
-- Q41. Write a PL/SQL package named `Emp_Manager` that contains a procedure to retrieve the manager's details for a given employee. 
CREATE OR REPLACE PACKAGE Emp_Manager AS
    PROCEDURE get_manager_details(
        p_empno IN emp.empno%TYPE
    );
END Emp_Manager;
/

CREATE OR REPLACE PACKAGE BODY Emp_Manager AS
    PROCEDURE get_manager_details(
        p_empno IN emp.empno%TYPE
    )
    IS
        v_mgr emp.mgr%TYPE;
        v_mgr_name emp.ename%TYPE;
    BEGIN
        SELECT mgr INTO v_mgr
        FROM emp
        WHERE empno = p_empno;

        SELECT ename INTO v_mgr_name
        FROM emp
        WHERE empno = v_mgr;

        DBMS_OUTPUT.put_line('Manager No: '|| v_mgr ||', Manager Name: '|| v_mgr_name );
    END;
END Emp_Manager;
/

EXEC Emp_Manager.get_manager_details(7369);

-- Q42. Create a PL/SQL package named `Dept_Info` with a function to return the number of employees in a department. 
CREATE OR REPLACE PACKAGE Dept_Info AS
    FUNCTION get_total_employees(
        p_deptno IN emp.deptno%TYPE
    )
    RETURN NUMBER;
END Dept_Info;
/

CREATE OR REPLACE PACKAGE BODY Dept_Info AS
    FUNCTION get_total_employees(
        p_deptno IN emp.deptno%TYPE
    )
    RETURN NUMBER
    IS
        v_total_emp NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_total_emp
        FROM emp
        WHERE deptno = p_deptno;

        RETURN v_total_emp;
    END;
END Dept_Info;
/

SELECT Dept_Info.get_total_employees(10) FROM dual;

-- Q43. Write a PL/SQL package named `Branch_Location` with a procedure to update the location of a branch. 
CREATE OR REPLACE PACKAGE Branch_Location AS
    PROCEDURE update_branch_location(
        p_branchno IN branch.branchno%TYPE,
        p_location IN branch.location%TYPE
    );
END Branch_Location;
/

CREATE OR REPLACE PACKAGE BODY Branch_Location AS
    PROCEDURE update_branch_location(
        p_branchno IN branch.branchno%TYPE,
        p_location IN branch.location%TYPE
    )
    IS
    BEGIN
        UPDATE branch
        SET location = p_location
        WHERE branchno = p_branchno;

        DBMS_OUTPUT.put_line('Branch No: '|| p_branchno ||', Location Updated: '|| p_location );
    END;
END Branch_Location;
/

EXEC Branch_Location.update_branch_location(102, 'NEW YORK');

-- Q44. Create a PL/SQL package named `Emp_Salary` with a function to calculate the total salary of all employees in a given department.
CREATE OR REPLACE PACKAGE Emp_Salary AS
    FUNCTION get_total_salary_expense(
        p_deptno IN emp.deptno%TYPE
    )
    RETURN NUMBER;
END Emp_Salary;
/

CREATE OR REPLACE PACKAGE BODY Emp_Salary AS
    FUNCTION get_total_salary_expense(
        p_deptno IN emp.deptno%TYPE
    )
    RETURN NUMBER
    IS
        v_total_sal NUMBER;
    BEGIN
        SELECT SUM(sal) INTO v_total_sal
        FROM emp
        WHERE deptno = p_deptno;

        RETURN v_total_sal;
    END;
END Emp_Salary;
/

SELECT Emp_Salary.get_total_salary_expense(10) FROM dual;

-- Q45. Write a PL/SQL package named `Branch_Dept` with a procedure to display all departments under a given branch.
CREATE OR REPLACE PACKAGE Branch_Dept AS
    PROCEDURE display_departments(
        p_branchno IN branch.branchno%TYPE
    );
END Branch_Dept;
/
CREATE OR REPLACE PACKAGE BODY Branch_Dept AS
    PROCEDURE display_departments(
        p_branchno IN branch.branchno%TYPE
    )
    IS
    BEGIN
        FOR dept_rec IN (SELECT deptno, dname FROM dept WHERE branchno = p_branchno)
        LOOP
            DBMS_OUTPUT.put_line('Department No: '|| dept_rec.deptno ||', Department Name: '|| dept_rec.dname );
        END LOOP;
    END;
END Branch_Dept;
/

EXEC Branch_Dept.display_departments(105);