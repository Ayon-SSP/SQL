

- **Dual :** DUAL is a table automatically created by Oracle Database along with the data dictionary. DUAL is in the schema of the user SYS but is accessible by the name DUAL to all users. It has one column, DUMMY , defined to be VARCHAR2(1) , and contains one row with a value X .
#### **SYS & SYSTEM :** [sys-and-system-accounts-in-oracle-database](https://medium.com/@ykods/sys-and-system-accounts-in-oracle-database-6113c3a29765)
1. **SYS:** `superuser` (system administrator account) && `highest level of privileges`
2. both created automatically during the database installation, AND account is used for performing critical administrative tasks and managing the Oracle Database instance itself.
3. privileges: creating and modifying database structures managing, memory and storage, and creating and managing other database users.
4. **SYSTEM**: `another administrative account` && `fewer privileges` compared to SYS.
5. privileges: system-related tasks
6. used for day-to-day management activities and is typically used for managing database schema objects, security, and application-related tasks





- [data dictionary objects](https://chat.openai.com/c/5b7fc911-9988-4722-9648-2329b670400e): ALL_TABLES, ALL_TAB_COLUMNS, ALL_VIEWS, ALL_INDEXES, ALL_CONS_COLUMNS, ALL_CONSTRAINTS, ALL_TAB_PRIVS, ALL_SYNONYMS, DBA_OBJECTS, DBA_USERS.