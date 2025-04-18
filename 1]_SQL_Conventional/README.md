### 💥 Examples of SQL Conventional [Link](https://github.com/Ayon-SSP/SQL/blob/main/B%5D_PL-SQL%20(Oracle)/Oracle%20Notes/1%5D_Oracle%20baby/README.md)

> 1. **Consistency**: Use consistent formatting and naming conventions throughout your code.
> 2. **Readability**: Write clear and concise code that is easy to understand.
> 3. **Maintainability**: Make your code easy to modify and extend.
> 4. **Performance**: Consider performance implications when writing queries. [🔑 Key Points](https://gemini.google.com/app/88fb0a8eb06acc68)

### 24 Rules to the SQL Formatting Standard [Link](https://learnsql.com/blog/24-rules-sql-code-formatting-standard/)
- **Avoid** table/column in the plural ✅ `employee` instead of ❌`employees`
- **CamelCase style || using '_' || paka more than one word**: eg: employee_city, employee_name
- Check that the name is not already used as a keyword in SQL
- For the primary key column avoid the name id. A good idea is to combine id with the name of a table, for example: id_employee.

### SQL Style Guide [Link](https://handbook.gitlab.com/handbook/business-technology/data-team/platform/sql-style-guide/)

### Trigger naming convention

Certainly! Here are some more naming conventions for triggers in Oracle databases:
```sql
TRG_<TABLE_NAME>_<EVENT>: Naming convention where <TABLE_NAME> refers to the table associated with the trigger and <EVENT> represents the database event that triggers the action, such as INSERT, UPDATE, or DELETE. For example, TRG_EMPLOYEE_INSERT or TRG_ORDER_UPDATE.

<ACTION>_<TABLE_NAME>_TRG: Naming convention where <ACTION> represents the action that triggers the event, such as BEFORE or AFTER, and <TABLE_NAME> refers to the associated table. For example, BEFORE_EMPLOYEE_UPDATE_TRG or AFTER_ORDER_INSERT_TRG.

<EVENT>_TRG_<TABLE_NAME>: Naming convention where <EVENT> represents the database event and <TABLE_NAME> refers to the table associated with the trigger. For example, INSERT_TRG_EMPLOYEE or UPDATE_TRG_ORDER.

<TABLE_NAME>_<ACTION>_TRIGGER: Naming convention where <TABLE_NAME> refers to the associated table, and <ACTION> represents the action that triggers the event. For example, EMPLOYEE_BEFORE_INSERT_TRIGGER or ORDER_AFTER_UPDATE_TRIGGER.

<PREFIX>_<DESCRIPTION>: Customized naming convention where <PREFIX> is a descriptive prefix indicating the type of trigger (e.g., BEF for BEFORE triggers, AFT for AFTER triggers), and <DESCRIPTION> provides a brief description of the trigger's purpose. For example, BEF_EMPLOYEE_INSERT_CHECK or AFT_ORDER_UPDATE_AUDIT.

```
