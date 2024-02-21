-- PL/SQL Functions
/*
Types of subroutines or say sub-programs:
    1. PL/SQL Functions
    2. PL/SQL Procedures
-- PL/SQL Functions In Oracle Database
    Pass-by-Value Functions and
    Pass-by-Reference functions

Restrictions on calling a function
    Multiple DML does not allow in a function.
    - dIFF: https://www.tutorialspoint.com/what-are-the-differences-between-stored-procedures-and-functions
    - always returns a single value.
PL/SQL Stored Procedure
    - IN, OUT, or INOUT
    - can have input/output parameters
    - AUTHID Clause:
        The AUTHID clause is used for setting the authority model for the PL/SQL Procedures. This clause has two flags.
            1. DEFINER and
            2. CURRENT_USER

Functions:	                                        Procedures:
A function has a return type and returns a value.	A procedure does not have a return type. But it returns values using the OUT parameters.
You cannot use a function with Data Manipulation queries. Only Select queries are allowed in functions.	You can use DML queries such as insert, update, select etc… with procedures.
A function does not allow output parameters	A procedure allows both input and output parameters.
You cannot manage transactions inside a function.	You can manage transactions inside a procedure.
You cannot call stored procedures from a function	You can call a function from a stored procedure.
You can call a function using a select statement.	You cannot call a procedure using select statements.

- PL/SQL procedure parameters can have one of three possible modes: IN, OUT, or IN OUT.

*/




-- Calling Notation for PL/SQL Subroutines https://www.rebellionrider.com/calling-notation-for-pl-sql-subroutines-in-oracle-database/
/*


Types of Calling Notations for Subroutines
    - In Oracle PL/SQL there are 3 types of calling notations. These are:

    1. Positional Notation: my_procedure(10, 1.1, 'SomeString');
    2. Named Notation: my_procedure(dep_id => 10, sal_raise => 1.1, emp_name => 'SomeString');
    3. Mixed calling notation: my_procedure(dep_id => 10, 1.1, 'SomeString');
*/





CREATE [OR REPLACE] FUNCTION function_name
(Parameter 1, Parameter 2…)
RETURN datatype
IS
	Declare variable, constant etc.  
BEGIN
	Executable Statements
	Return (Return Value);
END;
/

-- Example of a function to calculating the area of a circle

CREATE OR REPLACE FUNCTION area_of_circle
    (p_radius NUMBER := 1)
RETURN NUMBER
IS
    pi CONSTANT NUMBER(7, 3) := 3.141;
    area NUMBER(7, 3);
BEGIN
    area := pi * (p_radius * p_radius);
    RETURN area;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Area of circle with radius 5: ' || area_of_circle(5));
END;
/

-- stored procedure
CREATE [OR REPLACE] PROCEDURE pro_name (Parameter - List)
IS [AUTHID 	DEFINER | CURRENT_USER]
	Declare statements
BEGIN
	Executable statements 
END procedure name;
/ 

-- Stored procedures and functions (subprograms) can be compiled and stored in an Oracle Database XE
CREATE OR REPLACE PROCEDURE pr_foo IS
    var_name VARCHAR2 (30):= 'pappu';
    var_web VARCHAR2 (30) := '.cant dance';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Whats Up Internet? I am '||var_name||' from '||var_web);
END pr_foo;
/

EXECUTE pr_foo;
EXEC pr_foo;

BEGIN
    pr_foo;
END;   

CREATE OR REPLACE PROCEDURE emp_sal
(dep_id NUMBER, sal_raise NUMBER) 
IS
BEGIN
  UPDATE employees SET salary = salary * sal_raise WHERE department_id = dep_id;
END;
/




















-- PL/SQL Procedure
CREATE [OR REPLACE ] PROCEDURE procedure_name (parameter_list)     
IS
    [declaration statements]

BEGIN
    [execution statements]

EXCEPTION

    [exception handler]
END [procedure_name ];

-- Example 1:
CREATE OR REPLACE PROCEDURE calculate_department_salary (
    p_department_id IN NUMBER,
    p_total_salary OUT NUMBER
) IS
    v_total_salary NUMBER := 0;
BEGIN
    -- Declare cursor to fetch employee salaries
    FOR employee_rec IN (SELECT salary FROM employees WHERE department_id = p_department_id) LOOP
        -- Add each employee's salary to the total
        v_total_salary := v_total_salary + employee_rec.salary;
    END LOOP;
    
    -- Assign the total salary to the output parameter
    p_total_salary := v_total_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle if no employees are found in the department
        p_total_salary := 0;
    WHEN OTHERS THEN
        -- Handle other exceptions
        p_total_salary := -1; -- An error indicator
END;
/

DECLARE
    v_total_salary_result NUMBER;
BEGIN
    calculate_department_salary(10, v_total_salary_result); -- Assuming department ID 10
    DBMS_OUTPUT.PUT_LINE('Total Salary for Department 10: ' || v_total_salary_result);
END;
/


CREATE OR REPLACE PROCEDURE example_procedure (
    p_in_param IN NUMBER,
    p_out_param OUT NUMBER,
    p_inout_param IN OUT NUMBER
) IS
BEGIN
    -- Modify the IN OUT parameter
    p_inout_param := p_inout_param * 2;

    -- Assign a value to the OUT parameter
    p_out_param := p_in_param * 10;
END;
/

DECLARE
    v_in_param NUMBER := 5;
    v_out_param NUMBER;
    v_inout_param NUMBER := 10;
BEGIN
    example_procedure(v_in_param, v_out_param, v_inout_param);
    DBMS_OUTPUT.PUT_LINE('OUT Parameter Value: ' || v_out_param);
    DBMS_OUTPUT.PUT_LINE('IN OUT Parameter Value: ' || v_inout_param);
END;
/













-- Example 2
CREATE OR REPLACE PROCEDURE print_contact(
    in_customer_id NUMBER 
)
IS
    r_contact contacts%ROWTYPE;
BEGIN
    -- get contact based on customer id
    SELECT * INTO r_contact
    FROM contacts
    WHERE customer_id = p_customer_id;

    -- print out contact's information
    dbms_output.put_line( r_contact.first_name || ' ' ||
    r_contact.last_name || '<' || r_contact.email ||'>' );

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line( SQLERRM );
END;


create or replace procedure prc_getEmpTSal (p_empno in emp.empno%type, p_totalSalary out emp.sal%type)
IS
v_sal emp.sal%type;
v_comm emp.comm%type;
begin
    SELECT 
    SAL,COMM 
    INTO
    v_sal,v_comm
    FROM EMP 
    WHERE
        EMPNO=p_empno;
        
    p_totalsalary:=v_sal+nvl(v_comm,0);
    
    exception
        when others 
            then dbms_output.put_line('Error: '||SQLERRM);
end;


declare
v_totalsal emp.sal%type;
begin
    prc_getEmpTSal(7839,v_totalsal);
    dbms_output.put_line('Total Salary is'||v_totalsal);
end;
/
select * from emp;

-- Create a procedure that separates employees based on their job

create or replace procedure prc_separateEmpByJob
(
p_job in emp.job%type,
p_empCursor out SYS_REFCURSOR,
p_totalSalary out emp.sal%type
)
is
begin
-- is fetching employee records for specific job
    Open p_empCursor for 
    select empno,ename,job,sal,comm,hiredate,mgr,deptno 
    from emp
    where job=p_job;
-- totalsalary   of a particular job
    select 
        sum(sal) into p_totalSalary
    from emp
    where job=p_job;
    
    exception
        when others 
            then dbms_output.put_line('Error: '||SQLERRM);
end;

declare         
    v_cursor SYS_REFCURSOR;
    v_totalsal emp.sal%type;
    record_emp emp%rowtype;
begin
    PRC_SEPARATEEMPBYJOB('ANALYST',v_cursor,v_totalsal);
    loop
    fetch v_cursor into record_emp;
    exit when v_cursor%notfound;
    dbms_output.put_line(record_emp.ename||' working as '||record_emp.job||' has sal '||record_emp.sal);
    end loop;
    dbms_output.put_line('Total Salary of Job'||record_emp.job||' is '|| v_totalsal); 
    close v_cursor;
end;

-- Oracle Implicit Statement Results(single/Multiple value return)
CREATE OR REPLACE PROCEDURE get_customers(
    page_no NUMBER, 
    page_size NUMBER
)
AS
    c_customers SYS_REFCURSOR;
    c_total_row SYS_REFCURSOR;
BEGIN
    -- return the total of customers
    OPEN c_total_row FOR
        SELECT COUNT(*)
        FROM customers;
    
    dbms_sql.return_result(c_total_row);
    
    -- return the customers 
    OPEN c_customers FOR
        SELECT customer_id, name
        FROM customers
        ORDER BY name
        OFFSET page_size * (page_no - 1) ROWS
        FETCH NEXT page_size ROWS ONLY;
        
    dbms_sql.return_result(c_customers);     -- to return the cursor
END;

-- Using the get_next_result() procedure
SET SERVEROUTPUT ON

DECLARE
l_sql_cursor    PLS_INTEGER;
c_cursor        SYS_REFCURSOR;
l_return        PLS_INTEGER;

l_column_count  PLS_INTEGER;
l_desc_tab      dbms_sql.desc_tab;

l_total_rows    NUMBER;
l_customer_id   customers.customer_id%TYPE;
l_name          customers.NAME%TYPE;
BEGIN
-- Execute the function.
l_sql_cursor := dbms_sql.open_cursor(treat_as_client_for_results => TRUE);

dbms_sql.parse(C             => l_sql_cursor,
                STATEMENT     => 'BEGIN get_customers(1,10); END;',
                language_flag => dbms_sql.NATIVE);

l_return := dbms_sql.EXECUTE(l_sql_cursor);

-- Loop over the result sets.
LOOP
    -- Get the next resultset.
    BEGIN
    dbms_sql.get_next_result(l_sql_cursor, c_cursor);
    EXCEPTION
    WHEN no_data_found THEN
        EXIT;
    END;

    -- Get the number of columns in each result set.
    l_return := dbms_sql.to_cursor_number(c_cursor);
    dbms_sql.describe_columns (l_return, l_column_count, l_desc_tab);
    c_cursor := dbms_sql.to_refcursor(l_return);

    -- Handle the result set based on the number of columns.
    CASE l_column_count
    WHEN 1 THEN
        dbms_output.put_line('The total number of customers:');
        FETCH c_cursor
        INTO  l_total_rows;

        dbms_output.put_line(l_total_rows);
        CLOSE c_cursor;
    WHEN 2 THEN
        dbms_output.put_line('The customer list:');
        LOOP
        FETCH c_cursor
        INTO  l_customer_id, l_name;

        EXIT WHEN c_cursor%notfound;

        dbms_output.put_line(l_customer_id || ' ' || l_name);
        END LOOP;
        CLOSE c_cursor;
    ELSE
        dbms_output.put_line('An error occurred!');
    END CASE;
END LOOP;
END;
/
