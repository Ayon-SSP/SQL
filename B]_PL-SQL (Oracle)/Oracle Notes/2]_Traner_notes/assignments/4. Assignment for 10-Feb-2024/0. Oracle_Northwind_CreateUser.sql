/*
QUESTIONS:
    Create an user name "assignmentUser" Connect to "assignmentUser".
    Create all entities/tables found 3nf of Assignment_001.
    While creating the tables ensure to consider all Constraints are used.
*/

--Assignment_002   2-FEB-24 

-- Create an user name "assignmentUser"
alter session set "_ORACLE_SCRIPT"=true;
CREATE USER northwind_schema IDENTIFIED BY 321654;

------------------------------------------------------
-- DCL: Grant Control
------------------------------------------------------
GRANT CREATE SESSION TO northwind_schema;
GRANT CREATE TABLE TO northwind_schema;
GRANT CREATE VIEW TO northwind_schema;
GRANT CREATE ANY TRIGGER TO northwind_schema;
GRANT CREATE ANY PROCEDURE TO northwind_schema;
GRANT CREATE SYNONYM TO northwind_schema;
GRANT ALL PRIVILEGES TO northwind_schema;
GRANT CONNECT TO northwind_schema;
GRANT RESOURCE TO northwind_schema;

-- Grant all privileges to northwind_schema
GRANT ALL PRIVILEGES TO northwind_schema;
GRANT DBA TO northwind_schema;                   -- system-level privileges
-- GRANT SELECT, INSERT, UPDATE, DELETE ON exampleTable TO northwind_schema; -- object-level privileges

-- dba_users display
SELECT 
		username, 
		default_tablespace, 
		profile, 
		authentication_type
	FROM
		dba_users 
	WHERE 
		account_status = 'OPEN'
	ORDER BY
		username; 

-- drop user northwind_schema
-- drop user northwind_schema;
