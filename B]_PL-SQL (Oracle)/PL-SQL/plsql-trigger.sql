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
summerised:
    1. A DML Statement (while insert or delete or ...)
    2. A DDL Statement (create, alter, drop, truncate, ...)
    3. A SYSTEM Event (shutdown and turnON the database)
    4. A USER Event (login and logout)
    5. A Compound Trigger (multiple triggers on a single table)


-- user -> returns the current user
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


-- (:) because OLD and NEW are external variable references.
-- triggering_event - > INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, LOGON, LOGOFF, STARTUP, SHUTDOWN

/*
-- USER:
    control over the security.
    - collect statistical information
    - automatically generate values.
    - prevent invalid transactions.
*/

-- SYSDATE

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
/

-- DML Triggers

SET SERVEROUTPUT ON;

-- DROP TABLE superheroesTABLE;
CREATE TABLE superheroesTABLE (
    sh_name VARCHAR2 (15)
);   

-- DROP TRIGGER biss_Superheroes;
CREATE OR REPLACE TRIGGER biss_Superheroes
BEFORE INSERT ON superheroesTABLE
FOR EACH ROW
ENABLE
DECLARE
    v_user  VARCHAR2 (15);
BEGIN
    SELECT user INTO v_user FROM dual;
    DBMS_OUTPUT.PUT_LINE('You Just Inserted a Row Mr.'|| v_user); 
END;
/

INSERT INTO superheroesTABLE VALUES ('Ironman');

-- Example 2: Before Update Trigger
CREATE OR REPLACE TRIGGER bu_Superheroes
BEFORE UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
    v_user  VARCHAR2 (15);
BEGIN
    SELECT user INTO v_user FROM dual;
    DBMS_OUTPUT.PUT_LINE('You Just Updated a Row Mr.'|| v_user); 
END;
/

COMMIT;

UPDATE superheroes SET SH_NAME = 'Superman' WHERE SH_NAME='Ironman';

-- Example 3: Before Delete Trigger
CREATE OR REPLACE TRIGGER bu_Superheroes
BEFORE DELETE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
    v_user  VARCHAR2 (15);
BEGIN
    SELECT user INTO v_user FROM dual;
    DBMS_OUTPUT.PUT_LINE('You Just Deleted a Row Mr.'|| v_user); 
END;
/

DELETE FROM superheroes WHERE sh_name = 'Superman';

-- INSERT, UPDATE, DELETE All in One DML Trigger Using IF-THEN-ELSIF
CREATE OR REPLACE TRIGGER tr_superheroes
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
    v_user  VARCHAR2(15);
BEGIN
    SELECT user INTO v_user FROM dual;
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('one line inserted by '||v_user);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('one line Deleted by '||v_user);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('one line Updated by '||v_user);
    END IF;
END;
/

INSERT INTO superheroes VALUES ('Ironman');
UPDATE superheroes SET SH_NAME = 'Superman' WHERE SH_NAME='Ironman';
DELETE FROM superheroes WHERE sh_name = 'Superman';




-- Table Auditing
CREATE TABLE sh_audit(
    new_name varchar2(30),
    old_name varchar2(30),
    user_name varchar2(30),
    entry_date varchar2(30),
    operation  varchar2(30)
);

CREATE OR REPLACE TRIGGER superheroes_audit
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
    v_user varchar2(30);
    v_date varchar2(30);
BEGIN
    SELECT user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO v_user, v_date FROM dual;
    IF INSERTING THEN
        INSERT INTO sh_audit (new_name, old_name, user_name, entry_date, operation) 
        VALUES (:NEW.SH_NAME, NULL, v_user, v_date, 'Insert');
        DBMS_OUTPUT.PUT_LINE('INSERTING');
    ELSIF DELETING THEN
        INSERT INTO sh_audit (new_name, old_name, user_name, entry_date, operation)
        VALUES (NULL, :OLD.SH_NAME, v_user, v_date, 'Delete');
        DBMS_OUTPUT.PUT_LINE('DELETING');
    ELSIF UPDATING THEN
        INSERT INTO sh_audit (new_name, old_name, user_name, entry_date, operation) 
        VALUES (:NEW.SH_NAME, :OLD.SH_NAME, v_user, v_date, 'Update');
        DBMS_OUTPUT.PUT_LINE('UPDATING');
    END IF;
END;
/

INSERT INTO superheroes VALUES ('Superman');
UPDATE superheroes SET SH_NAME = 'Ironman' WHERE SH_NAME = 'Superman';
DELETE FROM superheroes WHERE SH_NAME = 'Ironman';

SELECT * FROM sh_audit;




-- Create Synchronized Table Backup Using DML Trigger In Oracle PL/SQL
DROP TABLE superheroes;
CREATE TABLE superheroes (
    Sh_name VARCHAR2(30)
);

CREATE TABLE superheroes_backup AS SELECT * FROM superheroes WHERE 1=2;

CREATE OR REPLACE TRIGGER Sh_Backup
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE 
BEGIN
    IF INSERTING THEN
        INSERT INTO superheroes_backup (SH_NAME) VALUES (:NEW.SH_NAME);  
    ELSIF DELETING THEN
        DELETE FROM superheroes_backup WHERE SH_NAME = :old.sh_name; 
    ELSIF UPDATING THEN
        UPDATE superheroes_backup 
        SET SH_NAME = :new.sh_name WHERE SH_NAME = :old.sh_name;
    END IF;
END;
/

INSERT INTO superheroes VALUES ('Superman');
UPDATE superheroes SET SH_NAME = 'Ironman' WHERE SH_NAME = 'Superman';
DELETE FROM superheroes WHERE SH_NAME = 'Ironman';


SELECT * FROM superheroes_backup;
SELECT * FROM superheroes;

-- DDL Triggers
CREATE TABLE schema_audit(
    ddl_date       DATE,
    ddl_user       VARCHAR2(15),
    object_created VARCHAR2(15),
    object_name    VARCHAR2(15),
    ddl_operation  VARCHAR2(15)
);

-- Save the DDL operation in the schema_audit table on schema level and on the database level>
CREATE OR REPLACE TRIGGER hr_audit_tr/db_audit_tr  -- WORK ONLY ON THIS SCHEMA NOT IN OTHER USER
AFTER [DDL/TRUNCATE/CREATE OR ALTER] ON [SCHEMA/DATABASE]
BEGIN
    INSERT INTO schema_audit VALUES (
sysdate, -- Current date and time
sys_context('USERENV','CURRENT_USER'), -- Current user
ora_dict_obj_type, -- table, view, index, trigger, procedure, function, package, package body, type, type body, library, java class, java resource, java source, indextype, operator, tablespace, directory, queue, materialized view, db link, synonym, sequence, user, role, context, consumer group, plan, plan directive, scheduler, job, window, window group, resource plan, refresh group
ora_dict_obj_name, -- name of the object(EG: table name)
ora_sysevent);
END;
/

CREATE TABLE test_audit(r_no NUMBER);

ALTER TABLE test_audit
ADD st_name VARCHAR2(30);

INSERT INTO test_audit VALUES (1, 'Ironman');

DROP TABLE test_audit;
TRUNCATE TABLE test_audit;
SELECT * FROM schema_audit;


-- database event triggers also known as system event triggers: https://www.rebellionrider.com/schema-level-database-logon-trigger-in-pl-sql/
/*
db event trigers like: logon, logoff, startup, shutdown
- user needs DBA prevelage to create db event triggers
-- How To Create Database Event 'LogOn' Trigger In Oracle By Manish Sharma
Types of Database Event Triggers.
    Schema Level Event Triggers
    Database Level Event Triggers

***Schema level event triggers can work on some specific schemas while the database event triggers have database wide scope. In other words database event triggers can be created to monitor the system event activities of either a specific user/schema or the whole database.***

- Object/System Privileges
    Schema level event triggers can be created by any user of your database who has CREATE TRIGGER system privilege while the database event trigger can only be created by privileged user such as SYS or SYSTEM who has ‘Administrative Database Trigger’ System Privileges.
*/

CREATE TABLE hr_evnt_audit
(
    event_type   VARCHAR2(30),
    logon_date   DATE,
    logon_time   VARCHAR2(15),
    logof_date   DATE,
    logof_time   VARCHAR2(15)
);

CREATE OR REPLACE TRIGGER hr_lgon_audit
AFTER LOGON ON SCHEMA       -- SCHEMA: apply only in current schema
BEGIN
    INSERT INTO hr_evnt_audit
    VALUES (
        ora_sysevent, -- event type eg: logon, logoff, startup, shutdown
        sysdate, -- logon date
        TO_CHAR(sysdate, 'hh24:mi:ss'), -- logon time
        NULL,
        NULL
    );
    COMMIT;
END;
/

CREATE OR REPLACE TRIGGER log_off_audit
BEFORE LOGOFF ON SCHEMA
BEGIN
    INSERT INTO hr_evnt_audit VALUES(
        ora_sysevent,
        NULL,
        NULL,
        SYSDATE,
        TO_CHAR(sysdate, 'hh24:mi:ss')
    );
    COMMIT;
END;
/


SELECT * FROM hr_evnt_audit;
DISC;
CONN hr/hr;
-- connect with system user
CONN system/321654@localhost:1521/xe
SHOW user;

-- Schema/Database Level Logoff System Event Trigger and
-- DROP TABLE system_evnt_audit;

-- Create Startup Trigger In Oracle Database By Manish Sharma NEED SYS PREVELAGE:https://www.rebellionrider.com/startup-shutdown-database-event-triggers-in-oracle-pl-sql/



-- Instead Of Trigger(ON VIEWS ONLY): a way of modifying views that cannot be modified directly through the DML statements. (using INSTEAD OF TRIGGER we can make non-updatable views updatable)
    -- https://www.rebellionrider.com/how-to-create-instead-of-insert-trigger-in-oracle-pl-sql/
-- Restriction on Instead-of View: 

CREATE TABLE trainer(
    full_name VARCHAR2(20)
);

CREATE TABLE subject(
    subject_name VARCHAR2(15)
);

INSERT INTO trainer VALUES ('Manish Sharma');
INSERT INTO subject VALUES ('Oracle');

CREATE VIEW vw_sooo AS
SELECT full_name, subject_name FROM trainer, subject;

-- INSERT INTO vw_sooo VALUES ('DING', 'DONG'); -- ERROR: ORA-01732: data manipulation operation not legal on this view
CREATE OR REPLACE TRIGGER tr_Io_Insert
INSTEAD OF INSERT ON vw_sooo
FOR EACH ROW
BEGIN
    INSERT INTO trainer (full_name) VALUES (:new.full_name);
    INSERT INTO subject (subject_name) VALUES (:new.subject_name);
END;
/

INSERT INTO vw_sooo VALUES ('DING', 'DONG');
SELECT * FROM vw_sooo;


-- Create Instead-Of Update Trigger: https://www.rebellionrider.com/how-to-create-instead-of-update-trigger-in-oracle-pl-sql/
CREATE OR REPLACE TRIGGER io_update
INSTEAD OF UPDATE ON vw_sooo
FOR EACH ROW
BEGIN
    UPDATE trainer SET FULL_NAME = :new.full_name 
    WHERE FULL_NAME = :old.full_name;
    UPDATE subject SET subject_NAME = :new.subject_name 
    WHERE subject_NAME = :old.subject_name;
END;
/

UPDATE vw_sooo
SET full_name = 'Manish Sharma', subject_name = 'Oracle'
WHERE full_name = 'DING' AND subject_name = 'DONG';

SELECT * FROM vw_sooo;


-- :https://www.rebellionrider.com/how-to-create-instead-of-delete-trigger-in-oracle-pl-sql/

CREATE OR REPLACE TRIGGER io_delete
INSTEAD OF DELETE ON vw_sooo
FOR EACH ROW
BEGIN
    DELETE FROM trainer WHERE FULL_NAME = :old.FULL_NAME;
    DELETE FROM subject WHERE SUBJECT_NAME= :old.SUBJECT_NAME;
END;
/

DELETE FROM vw_sooo WHERE FULL_NAME = 'Manish Sharma' AND SUBJECT_NAME = 'Oracle';
SELECT * FROM vw_sooo;

select * from SCHEMA_AUDIT;

CREATE OR REPLACE TRIGGER hr_audit_trigger
AFTER DDL ON SCHEMA
DISABLE
-- AFTER TRUNCATE OR ALTER ON SCHEMASCHEMA
BEGIN
    INSERT INTO schema_audit VALUES (
        SYSDATE,
        sys_context('USERENV', 'CURRENT_USER'), -- current SESSION user NAME
        ora_dict_obj_type,
        ora_dict_obj_name,
        ora_sysevent
    );
END;






COMMIT;
ROLLBACK;

-- need to fix: 
DESCRIBE SCHEMA_AUDIT;



drop table SCHEMA_AUDIT;

SELECT * FROM SCHEMA_AUDIT;

SHOW user;

TRUNCATE table SCHEMA_AUDIT;

ALTER TABLE SCHEMA_AUDIT
MODIFY DDL_USER VARCHAR2(50);
commit;

drop trigger NORTHWIND_DB.hr_audit_trigger;

ALTER TRIGGER HR_AUDIT_TR DISABLE;



DECLARE
  v_trigger_name VARCHAR2(100);
BEGIN
  -- Cursor to select all user-defined triggers
  FOR trigger_rec IN (SELECT trigger_name FROM user_triggers WHERE status = 'ENABLED') LOOP
    v_trigger_name := trigger_rec.trigger_name;
    -- Generate and execute the ALTER TRIGGER statement to disable the trigger
    EXECUTE IMMEDIATE 'ALTER TRIGGER ' || v_trigger_name || ' DISABLE';
    -- Output to confirm the trigger has been disabled
    DBMS_OUTPUT.PUT_LINE('Trigger ' || v_trigger_name || ' disabled.');
  END LOOP;
END;
/