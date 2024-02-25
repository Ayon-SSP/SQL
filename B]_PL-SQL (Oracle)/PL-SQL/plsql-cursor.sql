/*
Types of cursors in oracle database:
    Implicit cursor: 
        - Automatically created by oracle database when a SQL statement is executed.
        - It is used to process a single row at a time.
        - It is used for SELECT, INSERT, UPDATE, DELETE statements.
        - It is read-only
    Explicit cursor:
        - It is created by the user.
        - It is used to process multiple rows at a time.
        - It is used for SELECT statements.
        - It is read-write.
    steps:
        1. Declare: CREATE cursor_name is select_statement;
        2. Open: OPEN cursor_name;
        3. Fetch: FETCH cursor_name INTO variable;
        4. Process: process the fetched row.
        5. Close: CLOSE cursor_name;
        6. 


Cursor Attributes
    Oracle provides four attributes which work in correlation with cursors. These attributes are:
        %FOUND
        %NOTFOUND
        %ISOPEN
        %ROWCOUNT
*/


SET SERVEROUTPUT ON;
DECLARE
    -- cursor
    -- CURSOR c_emp IS
    --     SELECT * FROM emp;
    -- parameterized cursor
    CURSOR c_emp (p_limit NUMBER := 3) IS
        SELECT * FROM emp WHERE ROWNUM <= p_limit;
    -- record    
    r_emp c_emp%ROWTYPE;
BEGIN
    -- open the cursor
    -- OPEN c_emp; 
    OPEN c_emp(2);

    -- fetch the records
    LOOP
        FETCH c_emp INTO r_emp;
        EXIT WHEN c_emp%NOTFOUND;

        -- process the record
        DBMS_OUTPUT.PUT_LINE('Customer id: ' || r_emp.ename || 
            ' Name: ' || r_emp.empno);

    END LOOP;
    -- -<OR>-
    -- FOR r_emp IN c_emp LOOP
    --     DBMS_OUTPUT.PUT_LINE('Customer id: ' || r_emp.ename ||
    --         ' Name: ' || r_emp.empno);
    -- END LOOP; -- No need to fetch and close the cursor

    -- close the cursor
    CLOSE c_emp;
END;
/
select * from emp;



DECLARE
    l_budget NUMBER := 1000000;
    -- cursor
    CURSOR c_sales IS
        SELECT * FROM sales  
        ORDER BY total DESC;
    -- record    
    r_sales c_sales%ROWTYPE;
BEGIN
    -- reset credit limit of all customers
    UPDATE customers SET credit_limit = 0;

    OPEN c_sales;

    LOOP
        FETCH c_sales INTO r_sales;
        EXIT WHEN c_sales%NOTFOUND;

        -- update credit for the current customer
        UPDATE customers
        SET credit_limit = 
            CASE 
                WHEN l_budget > r_sales.credit THEN r_sales.credit 
                ELSE l_budget
            END
        WHERE customer_id = r_sales.customer_id;

        -- reduce the budget for credit limit
        l_budget := l_budget - r_sales.credit;

        DBMS_OUTPUT.PUT_LINE('Customer id: ' || r_sales.customer_id || 
            ' Credit: ' || r_sales.credit || ' Remaining Budget: ' || l_budget);

        -- check the budget
        EXIT WHEN l_budget <= 0;
    END LOOP;

    CLOSE c_sales;
END;
-- END: ed8c6549bwf9



-- Display employee details who all are working in deptno=20/30/40
-- hint cursor c_empByDeptno(deptno emp.deptno%type)

DECLARE
    CURSOR c_empByDeptno(p_deptno emp.deptno%type) IS
        SELECT * FROM emp WHERE deptno = p_deptno;
    r_emp c_empByDeptno%ROWTYPE;
BEGIN
    FOR r_emp IN c_empByDeptno(20) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee id: ' || r_emp.empno || 
            ' Name: ' || r_emp.ename || ' Deptno: ' || r_emp.deptno);
    END LOOP;
END;



/*
-- Table Based Record datatype/Cursor Based Record Datatype Variable
    Declaration of cursor based record.
    Initialization of cursor based record and 
    Accessing data stored into the cursor base record variable
    CURSOR cur_foo IS SELECT * FROM foo;
    var_emp cur_foo%ROWTYPE; using single value accessing all attrubutes of a record
    var_emp foo%ROWTYPE; 
    OPEN cur_foo;
    FETCH cur_foo INTO var_emp;
    DBMS_OUTPUT.PUT_LINE('Employee id: ' || var_emp.empno || 
        ' Name: ' || var_emp.ename || ' Deptno: ' || var_emp.deptno);
-- User Defined Record Datatype: https://www.rebellionrider.com/how-to-create-user-defined-record-datatype-variable-in-oracle-database/
    TYPE type_name IS RECORD (
        field_name1 datatype 1,
        field_name2 datatype 2,
        ...
        field_nameN datatype N 
    
    record_name TYPE_NAME;
);
*/

SET SERVEROUTPUT ON;
DECLARE
    TYPE rv_dept IS RECORD(
        f_name  VARCHAR2(20),
        d_name  DEPARTMENTS.department_name%TYPE 
    );

var1 rv_dept;


/*
ERROR 
	-> SYNTAX ERROR -> WE MISSED SOMETHING IN SYNTAX WHICH IS CAUGHT DURING COMPILATION 
	-> RUN TIME ERROR ->LOGICAL 
EXCEPTIN HANDLING -> RUN TIME ERROR CAUSED DUE TO LOGICAL ERRORS 

Error report -
ORA-06550: line 6, column 23:
PLS-00306: wrong number or types of arguments in call to 'C_EMP'
ORA-06550: line 6, column 5:
PL/SQL: Statement ignored
06550. 00000 -  "line %s, column %s:\n%s"
*Cause:    Usually a PL/SQL compilation error.
*Action:


EXCEPTION -> LOGICALLY RAISED ERROR 
			-> CURSOR NOT OPEN 
			-> CURSOR IS CLOSED BUT YOU ARE TRYING TO FETCH THE RECORD
			-> THERE IS NO RECORUD IN THE CURSOR NOT FOUND 
SWITCH(COLOR)
	CASE 'RED' : break;
	CASE 'GREEN' : break;
	CASE 'YELLOW': break;
	DEFAULT : break;
		
exception
	when	THEN
	when	THEN
	when	THEN
	when OTHERS THEN

REF CURSOR :cursor variables
REF -> REFERRINGS TO OTHER CURSORS AND WE CAN REASSIGN IT DIFFERENT CURSORS
CURSORS-> POINTER LOOKING AT OR WORKING ON RESULT SET 

CURSOR C_EMP IS SELECT * FROM EMP;
CURSOR C_DEPT IS SELECT * FROM DEPT;

REF_CURSOR->C_EMP -> ALL RECORDS / OPERATIONS ON C_EMP
REF_CURSOR->C_DEPT -> ALL RECORDS / OPERATIONS ON C_EMP



V_N NUMBER => NUMBER 
 
 TYPE customer_t IS REF CURSOR RETURN customers%ROWTYPE; 
 We are creating a cursor varialbe called customer_t which will work on records from customers%rowtype
 customer_t will always store the records from customers%rowtype;
Explicitly you are creating your own cursor variable to create a cursor which will work on customer data 
 1. Declare the cursor variable ref cursor 
	Type <name> is REF CURSOR RETURNS cusomers%ROWTYPE;
 2. dECLARE THE VARIABLE OF TYPE REF CURSOR
	customer_t c_customer
Other way
 1. Declare the type of the ref cursor
	Type <ref_curs_type_name> is Ref Cursor ; //it can point to any type of records
	Type myrefcursortye is ref cursor;
 2. declare a varialbe of your own type ref cursor
	myrefcursortype sys_refcursor;
	
**** cursor <cursor_name> is (query)
	
Type <name> is REF CURSOR RETURNS cusomers%ROWTYPE;
1. declare a ref cursor using type declartion 
Type emp_curtype is ref cursor returns emp%rowtype;
emp_cur emp_curType;
	a. user defined cursor type 
	b. its mandatory to define it with type keyword 
	c. when ever you are sure about what kind of records you want to work in that cursor 
		define it using Type Ref cursor

EMP_CUR SYS_REFCURSOR 
SYS_REFCURSOR 
		a. its sytem ref cursor type 
		b. we don't declare it using type explicitly 
		c. when you want to use cursor on different type records then use SysRefCursor 
		

Both types are useful in different scenarios, with REF CURSOR providing more static definition of the result set structure and SYS_REFCURSOR offering more flexibility for dynamic result sets.







Practice many questions on queries -> use these queries to practice with
for loop cursor using ref cursor on particular type of data
*/


-- REF CURSOR:(structure is defined)(week cursor) REF CURSOR is a cursor variable whose structure is defined at declaration time. It is typically used as a formal parameter in stored procedures or functions.
CREATE OR REPLACE PROCEDURE get_employee_data (emp_cursor OUT SYS_REFCURSOR) IS
BEGIN
    OPEN emp_cursor FOR
        SELECT employee_id, first_name, last_name
        FROM employees;
END;


-- SYS_REFCURSOR:(week cursor) SYS_REFCURSOR is a cursor variable whose structure is defined dynamically at runtime. It is used within PL/SQL blocks and can also be returned as an OUT parameter from stored procedures or functions.
DECLARE
    emp_cursor SYS_REFCURSOR;
BEGIN
    OPEN emp_cursor FOR
        SELECT employee_id, first_name, last_name
        FROM employees;
    -- Use the cursor variable emp_cursor as needed
END;


-- PL/SQL Cursor Variables with REF CURSOR
DECLARE
    TYPE customer_t IS REF CURSOR RETURN customers%ROWTYPE;
    c_customer customer_t;




-- Oracle CURSOR FOR UPDATE
DECLARE
    -- customer cursor
    CURSOR c_customers IS 
        SELECT 
            customer_id, 
            name, 
            credit_limit
        FROM 
            customers
        WHERE 
            credit_limit > 0 
        FOR UPDATE OF credit_limit;
    -- local variables
    l_order_count PLS_INTEGER := 0;
    l_increment   PLS_INTEGER := 0;
    
BEGIN
    FOR r_customer IN c_customers
    LOOP
        -- get the number of orders of the customer
        SELECT COUNT(*)
        INTO l_order_count
        FROM orders
        WHERE customer_id = r_customer.customer_id;
        -- 
        IF l_order_count >= 5 THEN
            l_increment := 5;
        ELSIF l_order_count < 5 AND l_order_count >=2 THEN
            l_increment := 2;
        ELSIF l_increment = 1 THEN
            l_increment := 1;
        ELSE 
            l_increment := 0;
        END IF;
        
        IF l_increment > 0 THEN
            -- update the credit limit
            UPDATE 
                customers
            SET 
                credit_limit = credit_limit * ( 1 +  l_increment/ 100)
            WHERE 
                customer_id = r_customer.customer_id;
            
            -- show the customers whose credits are increased
            dbms_output.put_line('Increase credit for customer ' 
                || r_customer.NAME || ' by ' 
                || l_increment || '%' );
        END IF;
    END LOOP;
    
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('Error code:' || SQLCODE);
            dbms_output.put_line('Error message:' || sqlerrm);
            RAISE;
            
END;
/




-- Example
CREATE OR REPLACE FUNCTION get_direct_reports(
    in_manager_id IN employees.manager_id%TYPE)
    RETURN SYS_REFCURSOR
AS
    c_direct_reports SYS_REFCURSOR;
BEGIN

    OPEN c_direct_reports FOR
        SELECT
            employee_id,
            first_name,
            last_name,
            email
        FROM
            employees
        WHERE
            manager_id = in_manager_id
        ORDER BY
            first_name,
            last_name;

    RETURN c_direct_reports;
END;

DECLARE
    c_direct_reports SYS_REFCURSOR;
    l_employee_id employees.employee_id%TYPE;
    l_first_name employees.first_name%TYPE;
    l_last_name employees.last_name%TYPE;
    l_email employees.email%TYPE;
BEGIN
    -- get the ref cursor from function
    c_direct_reports := get_direct_reports(46);

    -- process each employee
    LOOP
        FETCH c_direct_reports
        INTO l_employee_id,
            l_first_name,
            l_last_name,
            l_email;
        EXIT WHEN c_direct_reports%notfound;
        dbms_output.put_line(l_first_name || ' ' || l_last_name || ' - ' || l_email);
    END LOOP;
    -- close the cursor
    CLOSE c_direct_reports;
END;
/