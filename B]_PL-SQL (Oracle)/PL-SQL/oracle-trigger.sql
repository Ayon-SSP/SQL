/*
-- What is an Oracle trigger
    A trigger is a named PL/SQL block stored in the Oracle Database and executed automatically when a triggering event takes place. The event can be any of the following:
    A (DML) statement executed against a table e.g., INSERT, UPDATE, or DELETE. For example, if you define a trigger that fires before an INSERT statement on the customers table, the trigger will fire once before a new row is inserted into the customers table.
    A (DDL) statement executes e.g., CREATE or ALTER statement. These triggers are often used for auditing purposes to record changes of the schema.
    A system event such as startup or shutdown of the Oracle Database. 
    A user event such as login or logout. -- system db event trigger 
    instead of trigger(used in non- updatable views)
    compound triggers
    instead of trigger(used in non- updatable views)
*/


CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER } triggering_event ON table_name
[FOR EACH ROW]  -- row-level trigger
[FOLLOWS | PRECEDES another_trigger]
[ENABLE / DISABLE ]
[WHEN condition]
DECLARE
    declaration statements
BEGIN
    executable statements
EXCEPTION
    exception_handling statements
END;



-- triggering_event - > INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, LOGON, LOGOFF, STARTUP, SHUTDOWN

/*
-- USER:
    control over the security.
    - collect statistical information
    - automatically generate values.
    - prevent invalid transactions.
*/



-- Oracle Statement-level Triggers
CREATE [OR REPLACE] TRIGGER trigger_name
    {BEFORE | AFTER } triggering_event ON table_name
    [FOLLOWS | PRECEDES another_trigger]
    [ENABLE / DISABLE ]
    [WHEN condition]
DECLARE
    declaration statements
BEGIN
    executable statements
EXCEPTION
    exception_handling statements
END;

-- Eg: Monkay is holeday if insert on monday then error Exception
-- For example, if you update 1000 rows in a table, then a statement-level trigger on that table would only be executed once. 

CREATE OR REPLACE TRIGGER customers_credit_trg
    BEFORE UPDATE OF credit_limit ON customers
DECLARE
    l_day_of_month NUMBER;
BEGIN
    -- determine the transaction type
    l_day_of_month := EXTRACT(DAY FROM sysdate);

    IF l_day_of_month BETWEEN 28 AND 31 THEN
        raise_application_error(-20100,'Cannot update customer credit from 28th to 31st');
    END IF;
END;


