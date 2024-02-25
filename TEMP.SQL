/*Q1.Write a PL/SQL anonymous block to calculate the total salary of employees working in
the 'Sales' department. If the total salary exceeds 100000, display "Bonus Granted",
otherwise display "No Bonus".
 * */


DECLARE
	v_totalSalary emp.sal%TYPE;
BEGIN
	SELECT SUM(sal) 
	INTO v_totalSalary
	FROM EMP e
	WHERE deptno=(SELECT deptno FROM DEPT d WHERE dname='Sales');

	IF v_totalSalary > 100000
	THEN
		DBMS_OUTPUT.put_line('Bonus Granted');
	ELSE
		DBMS_OUTPUT.put_line('No Bonus');
	END IF;
END;


/*Q2.Create a PL/SQL block to calculate the average salary of
employees in each department. If the average salary is
greater than 50000, print "High Paying Department", else
print "Normal Paying Department".
*/

DECLARE
BEGIN
	FOR
	dept_rec IN (SELECT deptno, avg(sal) AS avg_sal FROM emp GROUP BY deptno)
	LOOP
	
		IF dept_rec.avg_sal > 50000 THEN
			DBMS_OUTPUT.put_line('Department '|| dept_rec.deptno ||' is a High Paying Department');
		Else
			DBMS_OUTPUT.put_line('Department '|| dept_rec.deptno ||' is a Normal Paying Department');
		END IF;
	END LOOP;
END;

/*Q3.Write a PL/SQL anonymous block to find the employee with
the highest salary in each department.
*/
DECLARE
BEGIN
    FOR emp_rec IN (
        SELECT empno, ename, sal, deptno
        FROM (
            SELECT empno, ename, sal, deptno,
                   ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) AS row_num
            FROM EMP
        )
        WHERE row_num = 1
    ) LOOP
        DBMS_OUTPUT.put_line('Department ' || emp_rec.deptno || ' - Employee: ' || emp_rec.ename || ' (Employee Number: ' || emp_rec.empno || ') has the highest salary: ' || emp_rec.sal);
    END LOOP;
END;

/*
 * Q4.Create a PL/SQL block to give a 10% raise to employees in
the 'IT' department and a 5% raise to employees in the
'HR' department.
 */
DECLARE
BEGIN
	FOR
		emp_rec IN (SELECT deptno,dname FROM dept WHERE dname IN('IT','HR'))
		LOOP 
			IF emp_rec.dname='IT' THEN 
			UPDATE emp 
			SET sal = sal + (sal*0.1) WHERE deptno=emp_rec.deptno;
			DBMS_OUTPUT.put_line('IT UPDATED');
			ELSIF emp_rec.dname='HR' THEN
			UPDATE emp 
			SET sal = sal + (sal*0.05) WHERE deptno=emp_rec.deptno;
			DBMS_OUTPUT.put_line('HR UPDATED');
			ELSE
			DBMS_OUTPUT.put_line('DEPARTMENT DOES NOT EXIST');
			END IF;
		END LOOP;
END;

/*
 * Q5.Write a PL/SQL block to display the names of employees
who have a commission greater than their salary.
*/

DECLARE 
	v_ename emp.ename%TYPE;
BEGIN
	FOR
	emp_rec IN (SELECT ename, sal, nvl(comm,0) AS comm FROM emp)
	LOOP
		IF emp_rec.sal<emp_rec.comm THEN
		v_ename:= emp_rec.ename;
		DBMS_OUTPUT.put_line('Employee Name: '||v_ename);
		END IF;
	END LOOP;
END;

/*
 * Q6.Display all employees' names and salaries in a specific
department using a loop.
 * */

DECLARE
v_deptno emp.deptno%TYPE:=20; --specifying department
BEGIN
	FOR
	emp_rec IN (SELECT ename, sal, deptno FROM EMP e WHERE deptno=v_deptno)
	LOOP
		dbms_output.put_line('Employee Name: '||emp_rec.ename||', Salary: '||emp_rec.sal||', DepartmentID: '||emp_rec.deptno);
		
	END LOOP;
	
END;

/*Q7.Calculate and display the total salary expense for a specific
branch using a loop.
 */

DECLARE
v_branchno emp.branchno%TYPE:=101; --specifying branchno
BEGIN
	FOR emp_rec IN (SELECT SUM(sal + NVL(comm, 0)) AS sal
FROM emp
WHERE branchno = v_branchno)
	LOOP 
		dbms_output.put_line('Branch No: '||v_branchno||' SALARY EXPENSE: '||emp_rec.sal);
	END LOOP;
END;


/*Q8.Find and display the names of employees who earn a commission using a loop 
 * */

DECLARE
BEGIN
	FOR emp_rec IN (SELECT ename FROM emp WHERE comm IS NOT null)
	LOOP 
		dbms_output.put_line('Employee Name: '||emp_rec.ename);
	END LOOP;
END;

/*Q9.Display the names of employees who have a manager using a loop.
 * */
DECLARE
BEGIN
	FOR emp_rec IN (SELECT ename FROM emp WHERE mgr IS NOT null)
	LOOP 
		dbms_output.put_line('Employee Name: '||emp_rec.ename);
	END LOOP;
END;


/*
 *Q10.Calculate and display the average salary of all employees in
	a specific department using a loop.
*/
DECLARE 
	v_deptno emp.deptno%type:=20;
BEGIN
	FOR emp_rec IN (SELECT round(avg(sal),2) AS avg_sal FROM emp WHERE deptno=v_deptno)
	LOOP
		dbms_output.put_line('Department no.: '||v_deptno||' Average Salary: '||emp_rec.avg_sal);
	END LOOP;
END;


/*Q11.Write a PL/SQL anonymous block to calculate the total
salary of all employees in a given department.
*/
DECLARE
v_salSum emp.sal%TYPE;
v_deptno emp.deptno%TYPE:=20;
BEGIN
	SELECT sum(sal) AS sal INTO v_salSum FROM emp WHERE deptno = v_deptno;
	dbms_output.put_line('Department No: '||v_deptno||' Total Salary: '||v_salSum);
END;


/*Q12.Create a PL/SQL anonymous block to retrieve all
information about an employee with empno 7839
 * 
 * */
DECLARE
	record_emp emp%rowtype;
	v_empno emp.empno%TYPE;
BEGIN
	v_empno:=7839;
	SELECT * INTO record_emp FROM emp WHERE empno = v_empno;
	dbms_output.put_line('EMPNO: '||record_emp.empno);
    dbms_output.put_line('ENAME: '||record_emp.ename);
    dbms_output.put_line('JOB: '||record_emp.job);
    dbms_output.put_line('MGR: '||record_emp.mgr);
    dbms_output.put_line('HIREDATE: '||record_emp.hiredate);
    dbms_output.put_line('SAL: '||record_emp.sal);
    dbms_output.put_line('comm: '||record_emp.comm);
    dbms_output.put_line('DEPTNO: '||record_emp.deptno);
    dbms_output.put_line('BRANCHNO: '||record_emp.branchno);
END;


/*Q13.Declare a variable to store the commission of an employee
and assign a commission rate of 0.15.
 * 
 * */
DECLARE
    v_commission NUMBER(7,2);
BEGIN
    v_commission := 0.15;
    DBMS_OUTPUT.put_line('Commission Rate: ' || v_commission);
END;

/*Q14.Define a constant to represent the maximum salary allowed
in the company and assign a value of 10000 to it.
 * 
 * */

DECLARE
    max_salary CONSTANT NUMBER(10,2) := 10000;
BEGIN
    DBMS_OUTPUT.put_line('Maximum Salary Allowed: ' || max_salary);
END;


/*Q15.Write a PL/SQL block to retrieve the location of the branch
where the department with deptno 20 is located.
 * 
 * */

DECLARE
	v_location branch.location%TYPE;
	v_deptno dept.deptno%type:=20;
BEGIN
	SELECT location INTO v_location FROM branch WHERE branchno=(SELECT branchno FROM dept WHERE deptno=v_deptno);
	dbms_output.put_line('Branch no: 20'||', Location: '||v_location);
END;