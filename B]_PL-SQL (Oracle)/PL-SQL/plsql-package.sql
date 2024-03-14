-- PL/SQL Packages
/*
- packages are logical groups of related pl/sql object'-- Select rows from a Table
- packages are named pl/sql blocks || they are permanently stored in the schema's. and can be referenced or reused by your program.

Packages contains:
    - Stored Procedures & functions
    - cursers
    - variables
    - Collections
    - records


Package Architecture:
    - Package Specification(Header):
        - declatation of all the element's (publically available/can be accessed by other packages)
        - declare public items can access only the declaration of the package like pak_name.funk or pak_name.var
    - Package Body (Implementation):


Package state:
    If the package specification has at least one variable, constant, or cursor, the package is stateful; or else it is stateless.
*/

-- Syntax of Package specification && package body
CREATE [OR REPLACE] PACKAGE [schema_name.]<package_name> 
IS | AS
    declarations;
END [<package_name>];

CREATE [OR REPLACE] PACKAGE BODY [schema_name.]<package_name> 
IS | AS
    declarations
    implementations;
[BEGIN
EXCEPTION]
END [<package_name>];


-- Example 1:
CREATE OR REPLACE PACKAGE order_mgmt AS
    gc_shipped_status  CONSTANT VARCHAR(10) := 'Shipped';
    gc_pending_status CONSTANT VARCHAR(10) := 'Pending';
    gc_canceled_status CONSTANT VARCHAR(10) := 'Canceled';

    -- cursor that returns the order detail
    CURSOR g_cur_order(p_order_id NUMBER) AS
        SELECT
            customer_id,
            status,
            salesman_id,
            order_date,
            item_id,
            product_name,
            quantity,
            unit_price
        FROM order_items
        INNER JOIN orders USING (order_id)
        INNER JOIN products USING (product_id)
        WHERE order_id = p_order_id;

    -- get net value of a order
    FUNCTION get_net_value(
        p_order_id NUMBER
    ) RETURN NUMBER;

    -- Get net value by customer
    FUNCTION get_net_value_by_customer(
        p_customer_id NUMBER,
        p_year        NUMBER
    ) RETURN NUMBER;

    PROCEDURE update_order_status(
        p_order_id NUMBER,
        p_status   VARCHAR2
    );

    TYPE order_rec IS RECORD(
        customer_id   orders.customer_id%TYPE,
        status        orders.status%TYPE,
        salesman_id   orders.salesman_id%TYPE,
        order_date    orders.order_date%TYPE,
    );
END order_mgmt;
/



CREATE OR REPLACE PACKAGE BODY order_mgmt AS
    -- both the functions are independent of each other
    -- get net value of a order
    FUNCTION get_net_value(
        p_order_id NUMBER
    ) RETURN NUMBER
    IS
        ln_net_value NUMBER 
    BEGIN
        SELECT SUM(unit_price * quantity) INTO ln_net_value
        FROM order_items
        WHERE order_id = p_order_id;

        RETURN p_order_id;

    EXCEPTION
        WHEN no_data_found THEN
            DBMS_OUTPUT.PUT_LINE( SQLERRM );
    END get_net_value;

    -- Get net value by customer
    FUNCTION get_net_value_by_customer(
        p_customer_id NUMBER,
        p_year        NUMBER
    ) RETURN NUMBER
    IS
        ln_net_value NUMBER 
    BEGIN
        SELECT SUM(quantity * unit_price)
        INTO ln_net_value
        FROM order_items
        INNER JOIN orders USING (order_id)
        WHERE extract(YEAR FROM order_date) = p_year
                        AND customer_id = p_customer_id
                        AND status = gc_shipped_status;
    RETURN ln_net_value;
        EXCEPTION
            WHEN no_data_found THEN
                DBMS_OUTPUT.PUT_LINE( SQLERRM );
    END get_net_value_by_customer;
END order_mgmt;
/

SELECT
    order_mgmt.get_net_value_by_customer(1,2017) sales
FROM dual;






-- Example 2:
CREATE TABLE new_superheroes (
    f_name VARCHAR2(50),
    l_name VARCHAR2(50)
);
-- Package Specification
CREATE OR REPLACE PACKAGE pkg_foo IS
    FUNCTION prnt_strng RETURN VARCHAR2;
    PROCEDURE proc_superhero(f_name VARCHAR2, l_name VARCHAR2);
END pkg_foo;
/

--Package Body
CREATE OR REPLACE PACKAGE BODY pkg_foo IS
    --Function Implementation
    FUNCTION prnt_strng RETURN VARCHAR2 IS
        BEGIN
            RETURN 'foo.com';
        END prnt_strng;
    
    --Procedure Implementation
    PROCEDURE proc_superhero(f_name VARCHAR2, l_name VARCHAR2) IS
        BEGIN
            INSERT INTO new_superheroes (f_name, l_name) VALUES(f_name, l_name);
        END;
    
END pkg_foo;
/

--Package Calling Function
BEGIN
    -- create the table new_superheroes
    DBMS_OUTPUT.PUT_LINE (pkg_foo.prnt_strng);
    pkg_foo.proc_superhero('Clark', 'Kent');
    
END;

SELECT * FROM new_superheroes;






