select * from whoami;

-- create a table with name varchar
create table whoami (name varchar2);

-- create a procedure that takes varchar2 as input
-- create or replace procedure whoami_proc (name in varchar2) as
-- begin
--   insert into whoami values (name);
-- end;


CREATE OR REPLACE PROCEDURE example_procedure (
    p_in_default_param IN NUMBER DEFAULT 5,
    p_in_param IN NUMBER,
    p_out_param OUT NUMBER,
    p_inout_param IN OUT NUMBER
) IS 
BEGIN
    SELECT 500 INTO p_out_param FROM dual;
    -- Assign a value to the `OUT` parameter
    -- p_out_param := p_in_param * p_in_default_param;

    -- Modify the `IN OUT` parameter
    p_inout_param := p_inout_param * 2;
    
END;
/

-- EXEC example_procedure;
-- /

DECLARE
    v_out_param NUMBER;
    v_inout_param NUMBER := 10;
BEGIN
    example_procedure (
        -- p_in_default_param => 2, 
        p_in_param => 5, 
        p_out_param => v_out_param, 
        p_inout_param => v_inout_param
    );
    DBMS_OUTPUT.PUT_LINE('OUT Parameter Value: ' || v_out_param);
    DBMS_OUTPUT.PUT_LINE('IN OUT Parameter Value: ' || v_inout_param); 
END;
/