

BEGIN
    -- executable section
    ...
    -- exception-handling section
    EXCEPTION 
        WHEN e1 THEN 
            -- exception_handler1
        WHEN e2 THEN 
            -- exception_handler1
        WHEN OTHERS THEN
            -- other_exception_handler
END;
/


DECLARE
    l_name emp.empno%TYPE;
    l_customer_id emp.empno%TYPE := &empno; -- imp (9999)
BEGIN
    -- get the customer name by id
    SELECT empno INTO l_name
    FROM emp
    -- WHERE empno = l_customer_id;
    WHERE empno <= l_customer_id;
    -- ORA-01403: no data found
    -- ORA-01422: exact fetch returns more than requested number of rows


    -- show the customer name   
    dbms_output.put_line('Customer name is ' || l_name);

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Customer ' || l_customer_id ||  ' does not exist');
        WHEN TOO_MANY_ROWS THEN
            dbms_output.put_line('Too many customers with id ' || l_customer_id);
        WHEN OTHERS THEN
            dbms_output.put_line('An error occurred');

    -- Customer 0 does not exist
END;
/
/*
# PL/SQL exception categories
  - (db related errors)`Internally defined` exceptions are errors that arise from the `Oracle Database environment`. The runtime system raises the internally defined exceptions automatically. ORA-27102 (out of memory) is one example of Internally defined exceptions. Note that Internally defined exceptions do not have names, but an error code.
  - (programming related errors like java python c# error types) `Predefined exceptions` are errors that occur during the `execution of the program`. The predefined exceptions are internally defined exceptions that `PL/SQL` has given names e.g., NO_DATA_FOUND, TOO_MANY_ROWS.
  - User-defined exceptions are `custom exceptions` defined by users like you. User-defined exceptions must be raised explicitly.

  Look at this LINK: (table)https://www.oracletutorial.com/plsql-tutorial/pl-sql-exception/
    Category	Definer	Has Error Code	Has Name	Raised Implicitly	Raised Explicitly 
    Internally defined	Runtime system	Always	Only if you assign one	Yes	Optionally
    Predefined	Runtime system	Always	Always	Yes	Optionally
    User-defined	User	Only if you assign one	Always	No	Always
*/

-- PL/SQL Exception Propagation
/*
When an exception occurs, 
- PL/SQL looks for an exception handler in the current block.
- If it does not find a match, PL/SQL propagates the exception to the enclosing block of the current block.
- PL/SQL then attempts to handle the exception by raising it once more in the enclosing block. This process continues in each successive enclosing block until there is no remaining block in which to raise the exception. If there is no exception handler in all blocks, PL/SQL returns an unhandled exception to the application environment that executed the outermost PL/SQL block.
*/


DECLARE
    e1 EXCEPTION;
    PRAGMA exception_init (e1, -20001);
    e2 EXCEPTION;
    PRAGMA exception_init (e2, -20002);
    e3 EXCEPTION;
    PRAGMA exception_init (e2, -20003);
    l_input NUMBER := &input_number;
BEGIN
    -- inner block
    BEGIN
        IF l_input = 1 THEN
            raise_application_error(-20001,'Exception: the input number is 1');
        ELSIF l_input = 2 THEN
            raise_application_error(-20002,'Exception: the input number is 2');
        ELSE
            raise_application_error(-20003,'Exception: the input number is not 1 or 2');
        END IF;
    -- exception handling of the inner block
    EXCEPTION
        WHEN e1 THEN 
            dbms_output.put_line('Handle exception when the input number is 1');
    END;
    -- exception handling of the outer block
    EXCEPTION 
        WHEN e2 THEN
            dbms_output.put_line('Handle exception when the input number is 2');
END;
/


-- [plsql-exception-propagation-example-1.png](https://www.oracletutorial.com/wp-content/uploads/2019/08/plsql-exception-propagation-example-1.png)

-- never directly enter the datatypes like NUMBER, insted know the datatype of the column and use that datatype

-- -- system-defined exceptions: system defined exceptions are defined & maintanined implicitly by the oracle server.
-- PL/SQL Raise Exceptions
-- Raising a user-defined exception
-- `error_code` Don't use -20,999 to -20,000 || string with a maximum length of 2,048 bytes
DECLARE
    exception_name EXCEPTION;
    PRAGMA EXCEPTION_INIT (exception_name, error_code) error_code SHOULD NOT 
/


-- -- Raising an internally defined exception
    IF l_customer_id < 0 THEN
        RAISE invalid_number;
    END IF;

-- ERROR at line 115:
-- ORA-01722: invalid number
-- ORA-06512: at line 6

DECLARE
    var_dividend NUMBER := 24;
    var_divisor NUMBER := 0;
    var_result NUMBER;
    ex_divzero EXCEPTION;
    PRAGMA EXCEPTION_INIT (ex_divzero, -1476);
BEGIN
    IF var_divisor = 0 THEN
        RAISE ex_divzero;
    END IF;

    var_result := var_dividend / var_divisor;
    dbms_output.put_line('Result: ' || var_result);

    EXCEPTION
        WHEN ex_divzero THEN
            dbms_output.put_line('ERROR ERROR!- yOUR dIVISOR iS zERO');

END;
/














-- -- Reraising the current exception
        -- adding some steps after EXCEPTION 
--      : You can re-raise the current exception with the RAISE statement
/*
DECLARE
    e_credit_too_high EXCEPTION;
    PRAGMA exception_init( e_credit_too_high, -20001 );

BEGIN
    IF l_credit > l_max_credit THEN 
        RAISE e_credit_too_high;
END;
*/

DECLARE
    e_credit_too_high EXCEPTION;
        PRAGMA exception_init( e_credit_too_high, -20001 );
    l_max_credit customers.credit_limit%TYPE;
    l_customer_id customers.customer_id%TYPE := &customer_id;
    l_credit customers.credit_limit%TYPE     := &credit_limit;
BEGIN
    BEGIN
        -- get the max credit limit
        SELECT MAX(credit_limit) 
        INTO l_max_credit
        FROM customers;
        
        -- check if input credit is greater than the max credit
        IF l_credit > l_max_credit THEN 
            RAISE e_credit_too_high;
        END IF;
        EXCEPTION
            WHEN e_credit_too_high THEN
                dbms_output.put_line('The credit is too high' || l_credit);
                RAISE; -- reraise the exception
    END;
EXCEPTION
    WHEN e_credit_too_high THEN
        -- get average credit limit
        SELECT avg(credit_limit) 
        into l_credit
        from customers;
        
        -- adjust the credit limit to the average
        dbms_output.put_line('Adjusted credit to ' || l_credit);
    
        --  update credit limit
        UPDATE customers 
        SET credit_limit = l_credit
        WHERE customer_id = l_customer_id;
        COMMIT;
END;
/


-- diff: raising an internally defined exception is about handling specific known errors, while re-raising the current exception is about allowing an exception to propagate further while preserving its original context and information.




-- -- -- -- Oracle RAISE_APPLICATION_ERROR:
/*
        comes under userdefine exception.

*/

ACCEPT var_age NUMBER PROMPT 'Enter your age: ';
DECLARE
    l_age NUMBER := &var_age;
BEGIN
    IF l_age < 18 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Age cannot be negative');
    END IF;

    dbms_output.put_line('Your age is ' || l_age);
    EXCEPTION
        WHEN others THEN
            dbms_output.put_line('Invalid age: ' || SQLERRM); -- SQLERRM -> 'Age cannot be negative'
END;  -- Invalid age: ORA-20001: Age cannot be negative
/