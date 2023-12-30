
-- conditions, operaters 
/*
Overview of PL/SQL:
    Basics of PL/SQL:
        Procedural Constructs
        Block Structure
        Variable Declaration
        Exception Handling
        Stored Procedures and Functions
        Triggers, Cursors
    
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

PI CONSTANT NUMBER := 3.141592654; 

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


BEGIN
    -- make sure to declare it before using 
    steps_to := -1;
    company := 'Mastek';
    introduction := ' Hello! I''m Ayon from Mastek.'; 
    

    FOR i IN 1..10 LOOP
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




EXCEPTION

END
-- Anonymous Blocks
/


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