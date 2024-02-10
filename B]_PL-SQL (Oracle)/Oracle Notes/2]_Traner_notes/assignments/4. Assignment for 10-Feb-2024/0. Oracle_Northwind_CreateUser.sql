/*
QUESTIONS:
    Create an user name "assignmentUser" Connect to "assignmentUser".
    Create all entities/tables found 3nf of Assignment_001.
    While creating the tables ensure to consider all Constraints are used.
*/

--Assignment_002   2-FEB-24 

-- Create an user name "assignmentUser"
alter session set "_ORACLE_SCRIPT"=true;
CREATE USER northwind_db IDENTIFIED BY 321654;

------------------------------------------------------
-- DCL: Grant Control
------------------------------------------------------
GRANT CREATE SESSION TO northwind_db;
GRANT CREATE TABLE TO northwind_db;
GRANT CREATE VIEW TO northwind_db;
GRANT CREATE ANY TRIGGER TO northwind_db;
GRANT CREATE ANY PROCEDURE TO northwind_db;
GRANT CREATE SYNONYM TO northwind_db;
GRANT ALL PRIVILEGES TO northwind_db;
GRANT CONNECT TO northwind_db;
GRANT RESOURCE TO northwind_db;

-- Grant all privileges to northwind_db
GRANT ALL PRIVILEGES TO northwind_db;
GRANT DBA TO northwind_db;                   -- system-level privileges
GRANT SELECT, INSERT, UPDATE, DELETE ON exampleTable TO northwind_db; -- object-level privileges

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

-- drop user northwind_db
drop user northwind_db;


