-- Section 5. Roles
-- CREATE ROLE – show you how to group object or system privileges into a role and grant the role to users.
-- SET ROLE – enable and disable roles for your current session.
-- ALTER ROLE – modify the authorization needed to enable a role.
-- DROP ROLE – learn how to remove a role from the database.




-- 1) Using Oracle CREATE ROLE without a password example

CREATE ROLES mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON customers
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON contacts
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON products
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON product_categories
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON warehouses
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON locations
TO mdm;

GRANT SELECT, INSERT, UPDATE, DELETE
ON employees
TO mdm;


CREATE USER alice IDENTIFIED BY abcd1234;

GRANT CREATE SESSION TO alice;


-- Fourth, log in to the database as alice:

-- Enter user-name: alice@pdborcl
-- Enter password:


























-- 2) Using Oracle CREATE ROLE to create a role with IDENTIFIED BY password example
CREATE ROLE order_entry IDENTIFIED BY xyz123;
GRANT SELECT, INSERT, UPDATE, DELETE
ON orders
TO order_entry;

GRANT SELECT, INSERT, UPDATE, DELETE
ON order_items
TO order_entry;
