-- create a user with name ayon and grant all the permission to ayon
alter session set "_ORACLE_SCRIPT"=true;
create user ayon identified by 321654;
grant all privileges to ayon;

--  where to check the user create or not
select * from dba_users
where username='SYSTEM' or username='MYUSER' or username='AYONSSP' or username='AYON';

-- drop user ayon
drop user ayon;




-- CREATE USER
alter session set "_ORACLE_SCRIPT"=true;
CREATE USER ayonssp IDENTIFIED BY 321654;

-- dba_users display
SELECT username, default_tablespace, profile, authentication_type 
FROM dba_users 
WHERE username='AYONSSP';


-- GRANT PRIVILEGES
GRANT CREATE SESSION TO ayonssp;
GRANT CREATE TABLE TO ayonssp;
GRANT CREATE SEQUENCE TO ayonssp;
GRANT CREATE VIEW TO ayonssp;
GRANT CREATE PROCEDURE TO ayonssp;
GRANT CREATE TRIGGER TO ayonssp;
GRANT CREATE TYPE TO ayonssp;
GRANT CREATE MATERIALIZED VIEW TO ayonssp;
GRANT CREATE JOB TO ayonssp;
GRANT CREATE ANY DIRECTORY TO ayonssp;
GRANT CREATE EXTERNAL JOB TO ayonssp;
GRANT CREATE DATABASE LINK TO ayonssp;
GRANT CREATE LIBRARY TO ayonssp;
GRANT CREATE OPERATOR TO ayonssp;
GRANT CREATE INDEXTYPE TO ayonssp;
GRANT CREATE DIMENSION TO ayonssp;
GRANT CREATE EVALUATION CONTEXT TO ayonssp;
GRANT CREATE ANY CONTEXT TO ayonssp;
GRANT CREATE ANY INDEXTYPE TO ayonssp;
GRANT CREATE ANY LIBRARY TO ayonssp;
GRANT CREATE ANY OPERATOR TO ayonssp;
GRANT CREATE ANY PROCEDURE TO ayonssp;


GRANT CONNECT TO ayonssp;
GRANT RESOURCE TO ayonssp;
GRANT dba to ayonssp;

-- check the GRANT for user AYONSSP
-- GRANT PRIVILEGES
GRANT SELECT ANY DICTIONARY TO ayonssp;

SELECT * FROM USER_SYS_PRIVS 
WHERE GRANTEE='AYONSSP';



-- create a user ayon

alter session set "_ORACLE_SCRIPT"=true;
create user myuser identified by 321654;
--  where to check the user create or not

select * from dba_users
where username='SYSTEM' or username='MYUSER' or username='AYONSSP';

























GRANT ALL PRIVILEGES TO super;

-- oracle docs Section 4: https://www.oracletutorial.com/oracle-administration/

-- Create an user name "assignmentUser"
alter session set "_ORACLE_SCRIPT"=true;
CREATE USER assignmentUser IDENTIFIED BY 321654;

-- dba_users display

GRANT SELECT ANY DICTIONARY TO assignmentUser;

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

-- grant connect to assignmentUser
-- DCL: Grant Control
grant create session to assignmentUser;     
grant create table to assignmentUser; 
grant create view to assignmentUser;
grant create any trigger to assignmentUser;
grant create any procedure to assignmentUser;
grant create SEQUENCE to assignmentUser;
grant create SYNONYM to assignmentUser;
grant all PRIVILEGES to assignmentUser;
grant connect to assignmentUser;
grant RESOURCE to assignmentUser;
grant dba to assignmentUser;


GRANT SELECT ON table_name TO {user | role};

ALTER USER username IDENTIFIED BY password ACCOUNT UNLOCK;


SELECT * FROM DBA_USERS
ORDER BY created DESC;






SQLPLUS / AS SYSDBA
step 1: Find the container name
SHOW CON_NAME;

CON_NAME
------------------------------
CDB$ROOT

CDB -> Container Database (SYS, SYSTEM)
PDB -> Pluggable Database (HR, OE, SH, AYONSSP) (user created database)

COLUMN NAME FORMAT A20;
TO get the CONTAINER ID
	v$PDBS
	COLUMN name FORMAT a20;
	SELECT con_id, NAME FROM v$pdbs; --> WILL SHOW THE NAME AND THE CONTAINER ID OF ALL THE Pluggable Database (PDB)
	SELECT CON_ID, NAME FROM V$CONTAINERS ORDER BY CON_ID;

	SQL>    SELECT con_id, NAME FROM v$pdbs;

			CON_ID NAME
		---------- --------------------
				2 PDB$SEED
				3 XEPDB1   -> created during insrallation (user defined pluggable database)

		SQL>    SELECT CON_ID, NAME FROM V$CONTAINERS ORDER BY CON_ID;

			CON_ID NAME
		---------- --------------------
				1 CDB$ROOT
				2 PDB$SEED -> by default create if you create a container
				3 XEPDB1

step 2: Find the service name.
	- pluggable database shares the same name
	V$Active_services -> to get the service name of XEPDB1 Container.
		SELECT NAME, NETWORK_NAME, CON_ID FROM V$ACTIVE_SERVICES WHERE con_id = 3;

		NAME       NETWORK_NAME           CON_ID
		---------  ---------------------  ------
		XEPDB1     XEPDB1                 3
 -> service name is XEPDB1

step 3: Create an entry in TNSNAMES.ORA file
-- dude this is differente god please help me.

sqlplus OT@PDBORCL

SQL>@path_to_sql_file
SQL>@c:\dbsample\ot_schema.sql

-- display all table_name of a user/schema
SELECT table_name FROM user_tables ORDER BY table_name;

-- DISCONNECT USER AND RECONNECT ANOTHER
user -- -> returns the current user
CONN HR/HR

SHOW user;

DISC;
CONN hr/hr;
-- connect with system user
CONN system/321654@localhost:1521/xe
CONN NORTHWIND_DB/321654@localhost:1521/xe
-- login to ayonssp user
CONNECT ayonssp/321654@localhost:1521/xe
conn ayonssp/321654@localhost:1521/xepdb1
SQL> EXIT

PDB VS CDB: https://www.youtube.com/watch?v=msifGpn2QXo&pp=ygUWQ0RCICYgUERCIGluIG9yYWNsZSBkYg%3D%3D
non-cdb -> non container database -- (can't convert it to container database)
cdb -> container database  | cdb$root | -> it can host multiple pluggable database (pdb)
	| cdb$root | -> | multiple other databases | using dbca
					[hr, ayonssp, sap] > thease db are know as pdb
			-> when we create a container pdb$seed is created by default
		
		-> how to create pdb s you can copy the default pdb$seed and create a new pdb 
		-<or>-
			or it is reduced to one command [DB cloning = 1line/command]
		
		what is pdb?
	|    | -> it's a normal db you can shutdown and startup can create user and all the stuff
				every user/schema is independent of each other cant access other's users data but (cdb admin) -<or>- sys admin can access all the data
				| cdb$root | -> | hr, system, pdb$seed, ayonssp| pdb's are (hr, sap, ...) are the admins of there own db and every db has there own sysdba
									each pdb's has there own users like ayonssp or application users who connect to the db






+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
PS C:\Users\admin> sqlplus system/321654@//localhost:1521/xepdb1 -- no hr user

SQL*Plus: Release 21.0.0.0.0 - Production on Wed Feb 21 19:52:42 2024
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

Last Successful login time: Wed Feb 21 2024 19:50:49 +05:30

Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL>

system -> all administrative privileges,

sys -> more strong thant sys
	sql> sqlplus sys as sysdba

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
PS C:\Users\admin> sqlplus sys as sysdba

SQL*Plus: Release 21.0.0.0.0 - Production on Wed Feb 21 20:07:25 2024
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

Enter password:

Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL>


-<or>- sqlplus sys/password@//localhost:1521/service_name as sysdba
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


CREATE TABLE whoami(
	name VARCHAR2(100)
);

INSERT INTO whoami VALUES('sys as sysdba');
INSERT INTO whoami VALUES('sqlplus system/321654@//localhost:1521/xepdb1');
INSERT INTO whoami VALUES('sqlplus northwind_schema/321654@//localhost:1521/xepdb1');
INSERT INTO whoami VALUES('sqlplus ayonssp/321654@//localhost:1521/xepdb1');

conn ayonssp/321654@//localhost:1521/xepdb1