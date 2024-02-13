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