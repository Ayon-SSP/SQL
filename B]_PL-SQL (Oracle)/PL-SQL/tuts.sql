
-- conditions, operaters 
/*
Overview of PL/SQL:
    Basics of PL/SQL:
        Procedural Constructs
        Block Structure
        Variable Declaration
        Exception Handling
        Stored Procedures and Functions
        Triggers
        Cursors
            1. parameter cursor(with or without default value).
            
    
    Advantages of PL/SQL:
        Integration with SQL
        Improved Performance
        ...more-👇


PL/SQL - Delimiters: https://www.tutorialspoint.com/plsql/plsql_basic_syntax.htm
PL/SQL - Data Types: https://www.tutorialspoint.com/plsql/plsql_data_types.htm
Loops:(
    while,
    for,
    nested loops,
    exitstatements,
    EXIT WHEN
) 
string:(
    fixed and variable-length strings,
    functions & purpose
) https://www.tutorialspoint.com/plsql/plsql_strings.htm

*/

-- small practices





-- Bind Variable
VARIABLE v_empno VARCHAR2(10);
EXEC :v_empno := '100'; 
-- another way is ":v_empno := '100';" in the BEGIN END block
-- AND display it using "dbms_output.put_line(:v_empno);" or using print command "print :v_empno;" or auto print SET AUTOPRINT ON;


-- constants
PI CONSTANT NUMBER := 3.141592654;      

SET SERVEROUTPUT ON;
DECLARE
    -- constant declaration 
    pi constant number := 3.141592654; 
    
    -- other declarations 
    x NUMBER := 100;
    is_valid BOOLEAN := TRUE;
    name VARCHAR2(20);
    choice CHAR(1);
    salary NUMBER(10, 2) := 50000.50;
    hire_date DATE := TO_DATE('2023-01-01', 'YYYY-MM-DD');

    -- Composite Data Types(Record, Collection Types (Arrays):)
    emp_rec RECORD(
        emp_id NUMBER,
        emp_name VARCHAR2(50),
        emp_salary NUMBER
    );
    
    TYPE emp_id_list IS VARRAY(10) OF NUMBER;
    emp_ids emp_id_list := emp_id_list(101, 102, 103);

    -- Special Data Types(CLOB, BLOB, ROWID)

    CURSOR c1 is
        SELECT ename, empno, sal FROM emp
        ORDER BY sal DESC;
    my_ename VARCHAR2(10);
    my_empno NUMBER(4);
    my_sal   NUMBER(7,2);

    -- Anchored Datatype (%TYPE)
    v_empno emp.empno%TYPE; -- same as NUMBER(4)

    -- Subtypes (%ROWTYPE)
    v_emp_rec emp%ROWTYPE; -- same as RECORD






BEGIN
    -- make sure to declare it before using 
    steps_to := -1;
    company := 'Mastek';
    introduction := ' Hello! I''m Ayon from Mastek.'; 
    

    FOR i IN 1..10 LOOP -- or you can use 'REVERSE 1..10'
        dbms_output.put_line(UPPER(greetings));
        dbms_output.put_line(LOWER(greetings));
        dbms_output.put_line(INITCAP(greetings));
        -- ...string concepts
        IF x < 0 AND x =! steps_to THEN -- less that zero and not -1(AND, OR, NOT) ...more ⬇️
            INSERT INTO temp VALUES (i, x, 'i is less than zero')
        ELSIF x = 0 THEN  -- i is zero(=, != or <>, >, <=..) ...more ⬇️
            INSERT INTO temp VALUES (i, x, 'i is even')
        ELSIF MOD(i, 2) = 0 THEN  -- i is even
            INSERT INTO temp VALUES (i, x, 'i is even')
            dbms_output.put_line('i is: '|| i || ' and j is: ' || j);
            DBMS_OUTPUT.NEW_LINE;
        ELSE
            INSERT INTO temp VALUES (i, x, 'i is odd');
        END IF;
        -- <OR> YOU AN USE WHEN THEN ELSE END CASE(same as sql)
        x := x + 100
    END LOOP;
    -- <OR> YOU CAN USE WHILE
    -- <OR> LOOP END LOOP.
    WHILE steps_to <= 1
        steps_to := steps_to + 1 
        /*
        --[operators] 
            Assignment ops(:=)
            Arithmetic ops(+,-,*,/,**) 
            Relational ops(=, != or <> or ~=, >, <=,) 
            Comparison ops(LIKE, BETWEEN, IN, IS NULL) 
            Logical ops(AND, OR, NOT) 
        **Learn operator precidence.
            **	
            +, -
            *, /
            +, -, ||
            NOT	
            AND	
            OR	
        */
    END LOOP;

    LOOP
        -- steps
        EXIT WHEN steps_to <= 1;
    END LOOP;
    COMMIT;

    -- Cursor 
    OPEN c1;
    FOR i IN 1..5 LOOP -- or c1%NOTFOUND; returns true if rows end's
        FETCH c1 INTO my_ename, my_empno, my_sal;
        EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                                        /* is more than the total       */
                                        /* number of employees          */
        INSERT INTO temp VALUES (my_sal, my_empno, my_ename);
        COMMIT;
    END LOOP;
    CLOSE c1;
    


    -- SELECT INTO ( it's like v_salary = salary(from table emp with id = 100)) && DECLARE v_salary NUMBER(8);
    SELECT salary INTO v_salary -- or multiple variable like  || SELECT salary, name, id INTP v_salary, v_name, v_id ||
    FROM emp WHERE emp_id = 100;

    


    


EXCEPTION

END
/

/*
-- _____  ** Sample PL/SQL Programs **     __________

1. FOR Loop
2. Cursors
3. Scoping and more ...https://docs.oracle.com/cd/B10500_01/appdev.920/a96624/a_samps.html
*/

SET SERVEROUTPUT ON;
DECLARE
    v_test VARCHAR2(20) := 'Hello World';
BEGIN
    dbms_output.put_line(v_test);
END;

-- write a plsql query to display fibonacci series upto 10 terms
SET SERVEROUTPUT ON;
DECLARE
    v_first NUMBER := 0;
    v_second NUMBER := 1;
    v_next NUMBER;
BEGIN
    dbms_output.put_line(v_first);
    dbms_output.put_line(v_second);

    FOR i IN 1..8 LOOP
        v_next := v_first + v_second;
        dbms_output.put_line(v_next);
        v_first := v_second;
        v_second := v_next;
    END LOOP;
END;


DECLARE
    x NUMBER := 100;
BEGIN
    FOR i IN 1..10 LOOP
        IF MOD(i,2) = 0 THEN     -- i is even
            INSERT INTO temp VALUES (i, x, 'i is even');
        ELSE
            INSERT INTO temp VALUES (i, x, 'i is odd');
        END IF;
        x := x + 100;
    END LOOP;
    COMMIT;
END;

-- Import the dbms_output package
SET SERVEROUTPUT ON;

-- now create a table temp refering above code
CREATE TABLE temp(
    i NUMBER,
    x NUMBER,
    msg VARCHAR2(20)
);

SELECT * FROM temp;



-- Sample 2. Cursors
/*
CREATE This table
SQL> SELECT ename, empno, sal FROM emp ORDER BY sal DESC;

ENAME          EMPNO      SAL
---------- --------- --------
KING            7839     5000
SCOTT           7788     3000
FORD            7902     3000
JONES           7566     2975
BLAKE           7698     2850
CLARK           7782     2450
ALLEN           7499     1600
TURNER          7844     1500
MILLER          7934     1300
WARD            7521     1250
MARTIN          7654     1250
ADAMS           7876     1100
JAMES           7900      950
SMITH           7369      800

*/
-- write a sql query to create the above commented table and insert the above data into it
CREATE TABLE emp(
    ename VARCHAR2(20),
    empno NUMBER,
    sal NUMBER
);

INSERT INTO emp VALUES('KING', 7839, 5000);
INSERT INTO emp VALUES('SCOTT', 7788, 3000);
INSERT INTO emp VALUES('FORD', 7902, 3000);
INSERT INTO emp VALUES('JONES', 7566, 2975);
INSERT INTO emp VALUES('BLAKE', 7698, 2850);
INSERT INTO emp VALUES('CLARK', 7782, 2450);
INSERT INTO emp VALUES('ALLEN', 7499, 1600);
INSERT INTO emp VALUES('TURNER', 7844, 1500);
INSERT INTO emp VALUES('MILLER', 7934, 1300);
INSERT INTO emp VALUES('WARD', 7521, 1250);
INSERT INTO emp VALUES('MARTIN', 7654, 1250);
INSERT INTO emp VALUES('ADAMS', 7876, 1100);
INSERT INTO emp VALUES('JAMES', 7900, 950);
INSERT INTO emp VALUES('SMITH', 7369, 800);

SELECT * FROM emp;
Drop table emp;
CREATE TABLE temp(
    sal NUMBER(7,2),
    empno NUMBER(4),
    ename VARCHAR2(10)
);

-- The following example uses a cursor to select the five highest paid employees from the emp table.
DECLARE
    CURSOR c1 is
        SELECT ename, empno, sal FROM emp
            ORDER BY sal DESC;   -- start with highest paid employee
    my_ename VARCHAR2(10);
    my_empno NUMBER(4);
    my_sal   NUMBER(7,2);
BEGIN
    OPEN c1;
    -- fetch the first value and display it
    FETCH c1 INTO my_ename, my_empno, my_sal;
    dbms_output.put_line(my_ename || ' ' || my_empno || ' ' || my_sal);

    FOR i IN 1..5 LOOP
        FETCH c1 INTO my_ename, my_empno, my_sal;
        EXIT WHEN c1%NOTFOUND;  /* in case the number requested */
                                        /* is more than the total       */
                                        /* number of employees          */
        INSERT INTO temp VALUES (my_sal, my_empno, my_ename);
        COMMIT;
    END LOOP;
    CLOSE c1;
END;

SELECT * FROM temp;
TRUNCATE TABLE temp;
DROP TABLE temp;



-- Sample 3. Scoping

CREATE TABLE temp2(
    i NUMBER,
    x NUMBER,
    msg VARCHAR2(20)
);

-- available online in file 'sample3'
DECLARE
    x NUMBER := 0;
    counter NUMBER := 0;
BEGIN
    FOR i IN 1..4 LOOP
        x := x + 1000;
        counter := counter + 1;
        INSERT INTO temp2 VALUES (x, counter, 'in OUTER loop');
        /* start an inner block */
        DECLARE
            x NUMBER := 0;  -- this is a local version of x
        BEGIN
            FOR i IN 1..4 LOOP
                x := x + 1;  -- this increments the local x
                counter := counter + 1;
                INSERT INTO temp2 VALUES (x, counter, 'inner loop');
            END LOOP;
        END;
    END LOOP;
    COMMIT;
END;
/

SELECT * FROM temp2;


-- Sample 4. Batch Transaction Processing

/*
SQL> SELECT * FROM accounts ORDER BY account_id;

ACCOUNT_ID     BAL
---------- -------
         1    1000
         2    2000
         3    1500
         4    6500
         5     500

SQL> SELECT * FROM action ORDER BY time_tag;

ACCOUNT_ID  O  NEW_VALUE STATUS                TIME_TAG
----------  - ---------- -------------------- ---------
         3  u        599                      18-NOV-88
         6  i      20099                      18-NOV-88
         5  d                                 18-NOV-88
         7  u       1599                      18-NOV-88
         1  i        399                      18-NOV-88
         9  d                                 18-NOV-88
        10  x                                 18-NOV-88
*/
-- write sql query's to create above tables and insert data into it
CREATE TABLE accounts(
    account_id NUMBER,
    bal NUMBER
);

INSERT INTO accounts VALUES(1, 1000);
INSERT INTO accounts VALUES(2, 2000);
INSERT INTO accounts VALUES(3, 1500);
INSERT INTO accounts VALUES(4, 6500);
INSERT INTO accounts VALUES(5, 500);

DROP TABLE action;
CREATE TABLE action(
    account_id NUMBER,
    oper_type CHAR(1),
    new_value NUMBER,
    status VARCHAR2(50),
    time_tag DATE
);

INSERT INTO action VALUES(3, 'u', 599, NULL, '18-NOV-88');
INSERT INTO action VALUES(6, 'i', 20099, NULL, '18-NOV-88');
INSERT INTO action VALUES(5, 'd', NULL, NULL, '18-NOV-88');
INSERT INTO action VALUES(7, 'u', 1599, NULL, '18-NOV-88');
INSERT INTO action VALUES(1, 'i', 399, NULL, '18-NOV-88');
INSERT INTO action VALUES(9, 'd', NULL, NULL, '18-NOV-88');
INSERT INTO action VALUES(10, 'x', NULL, NULL, '18-NOV-88');



DECLARE
    CURSOR c1 IS
        SELECT account_id, oper_type, new_value 
        FROM action
        ORDER BY time_tag
        FOR UPDATE OF status;
BEGIN
    FOR acct IN c1 LOOP  -- process each row one at a time

        acct.oper_type := upper(acct.oper_type);

        /*________________________________________*/
        /* Process an UPDATE.  If the account to  */
        /* be updated doesn't exist, create a new */
        /* account.                               */
        /*________________________________________*/
        IF acct.oper_type = 'U' THEN
            UPDATE accounts SET bal = acct.new_value
            WHERE account_id = acct.account_id;

            IF SQL%NOTFOUND THEN  -- account didn't exist. Create it.
                INSERT INTO accounts
                VALUES (acct.account_id, acct.new_value);
                UPDATE action SET status =
                'Update: ID not found. Value inserted.'
                WHERE CURRENT OF c1;
            ELSE
                UPDATE action SET status = 'Update: Success.'
                WHERE CURRENT OF c1;
            END IF;

        /*____________________________________________*/
        /* Process an INSERT.  If the account already */
        /* exists, do an update of the account        */
        /* instead.                                   */
        /*____________________________________________*/
        ELSIF acct.oper_type = 'I' THEN
            BEGIN
                INSERT INTO accounts
                VALUES (acct.account_id, acct.new_value);
                UPDATE action set status = 'Insert: Success.'
                WHERE CURRENT OF c1;
                EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN   -- account already exists
                    UPDATE accounts SET bal = acct.new_value
                    WHERE account_id = acct.account_id;
                    UPDATE action SET status =
                    'Insert: Acct exists. Updated instead.'
                    WHERE CURRENT OF c1;
            END;

        /*____________________________________________*/
        /* Process a DELETE.  If the account doesn't  */
        /* exist, set the status field to say that    */
        /* the account wasn't found.                  */
        /*____________________________________________*/
        ELSIF acct.oper_type = 'D' THEN
            DELETE FROM accounts
            WHERE account_id = acct.account_id;

            IF SQL%NOTFOUND THEN   -- account didn't exist.
                UPDATE action SET status = 'Delete: ID not found.'
                WHERE CURRENT OF c1;
            ELSE
                UPDATE action SET status = 'Delete: Success.'
                WHERE CURRENT OF c1;
            END IF;

        /*____________________________________________*/
        /* The requested operation is invalid.        */
        /*____________________________________________*/
        ELSE  -- oper_type is invalid
            UPDATE action SET status =
            'Invalid operation. No action taken.'
            WHERE CURRENT OF c1;

        END IF;

    END LOOP;
    COMMIT;
END;
/

SELECT * FROM accounts;
SELECT * FROM action;



-- Triggers in PL/SQL
/*
Types of triggers:
    1. DML Triggers
        1.1 Row Level Triggers
        1.2 Statement Level Triggers
    2. DDL Triggers
    3. System Triggers
    4. Instead of Triggers
    5. Compound Triggers
*/
-- syntax [https://youtu.be/R3fvX_xf5P4?list=PLL_LQvNX4xKyiExzq9GKwORoH6nvaRnOQ&t=182]

CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER} Triggering_event ON table_name
[FOR EACH ROW] [FOLLOWS another_trigger_name]
[ENABLE/DISABLE] [WHEN condition]
DECLARE
    declaration statements
BEGIN
    executable statements
END;



CREATE [OR REPLACE] TRIGGER trigger_name
BEFORE INSERT OR UPDATE OR DELETE ON table_name -- BEFORE or AFTER
FOR EACH ROW
BEGIN
    -- Trigger logic here
END;


-- Triggers example
-- Create emp_trigger table

CREATE TABLE emp_trigger (
    emp_id NUMBER,
    emp_name VARCHAR2(100),
    salary NUMBER
);

CREATE OR REPLACE TRIGGER check_salary
BEFORE INSERT ON emp_trigger
FOR EACH ROW
BEGIN
    IF :NEW.salary < 30000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary must be at least 30000.');
    END IF;
END;
/

-- Insert data into emp_trigger table
INSERT INTO emp_trigger (emp_id, emp_name, salary)
VALUES (1, 'John Doe', 25000);

INSERT INTO emp_trigger (emp_id, emp_name, salary)
VALUES (2, 'Jane Smith', 35000);

SELECT * FROM emp_trigger;



-- create a cursor that will delete all orher ides if already exists while inserting new one
CREATE OR REPLACE TRIGGER check_id
BEFORE INSERT ON emp_trigger
FOR EACH ROW

DECLARE
    CURSOR c1 IS
        SELECT emp_id FROM emp_trigger;
    v_emp_id emp_trigger.emp_id%TYPE;
BEGIN
    OPEN c1;
    FETCH c1 INTO v_emp_id;
    IF v_emp_id = :NEW.emp_id THEN
        DELETE FROM emp_trigger WHERE emp_id = v_emp_id;
    END IF;
    CLOSE c1;
END;
/