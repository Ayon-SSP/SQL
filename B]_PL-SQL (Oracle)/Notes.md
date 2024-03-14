
- all the high privileged users like SYS, SYSTEM were placed inside the container databaswe and other schemas like HR, OE, SH were placed inside the pluggable database.
- - In Oracle Database, a pluggable database (PDB) is a self-contained database unit within a larger container database (CDB)
- 
- 
- A **schema** is a collection of database objects. A **schema is owned by a database user** and has the **same name** as that user. Schema objects are logical structures created by users. **Objects such as tables or indexes hold data**, or can consist of a definition only, such as a view or synonym.

- **SQL*Plus** is a command-line interface provided by Oracle for interacting with the Oracle Database. **PL/SQL** is a language used within SQL*Plus to write procedural code and interact with the database
- **Dual :** DUAL is a table automatically created by Oracle Database along with the data dictionary. DUAL is in the schema of the user SYS but is accessible by the name DUAL to all users. It has one column, DUMMY , defined to be VARCHAR2(1) , and contains one row with a value X .
#### **SYS & SYSTEM :** [sys-and-system-accounts-in-oracle-database](https://medium.com/@ykods/sys-and-system-accounts-in-oracle-database-6113c3a29765)
1. **SYS:** `superuser` (system administrator account) && `highest level of privileges`
2. both created automatically during the database installation, AND account is used for performing critical administrative tasks and managing the Oracle Database instance itself.
3. privileges: creating and modifying database structures managing, memory and storage, and creating and managing other database users.
4. **SYSTEM**: `another administrative account` && `fewer privileges` compared to SYS.
5. privileges: system-related tasks
6. used for day-to-day management activities and is typically used for managing database schema objects, security, and application-related tasks





- [data dictionary objects](https://chat.openai.com/c/5b7fc911-9988-4722-9648-2329b670400e): ALL_TABLES, ALL_TAB_COLUMNS, ALL_VIEWS, ALL_INDEXES, ALL_CONS_COLUMNS, ALL_CONSTRAINTS, ALL_TAB_PRIVS, ALL_SYNONYMS, DBA_OBJECTS, DBA_USERS.
- [plsql-exception-propagation-example-3](https://www.oracletutorial.com/wp-content/uploads/2019/08/plsql-exception-propagation-example-3.png)




## interviewbit.com
- tables: object of type table that are modeled as db tables
- WHERE CURRENT: we use this clause while referencing the current row from an explicit cursor. This clause allows applying updates and deletion of the row currently under consideration without explicitly referencing the row ID.
- EXCEPTION_INIT: assigns a name to an Oracle error so that you can reference it in your exception-handling routine.