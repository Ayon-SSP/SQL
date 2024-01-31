alter session set "_ORACLE_SCRIPT"=true;
create user myuser identified by root;

--############ creating user on oracle instance for custom schema
alter session set "_ORACLE_SCRIPT"=true;
-- Create user 
create user myuser IDENTIFIED by root;
 
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
-- ################################################################	
-- DCL: Grant Control
-- ################################################################
   grant create session to myuser;     
   grant create table to myuser; 
   grant create view to myuser;
   grant create any trigger to myuser;
   grant create any procedure to myuser;
   grant create SEQUENCE to myuser;
   grant create SYNONYM to myuser;
   grant all PRIVILEGES to myuser;
   grant connect to myuser;
   grant RESOURCE to myuser;
   grant dba to myuser;
-- 
