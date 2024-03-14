-- PL/SQL Collections
/*
Collections(an array in Oracle Database): A homogeneous(same data type) single dimension data structure which is made up of elements of same datatype is called collection in Oracle Database.
    index -> data
    1d (can't `data[index1][index2]`)

Bounded & Unbounded Collection – A collection which has lower or upper limits on values of row number or say a collection which can hold only limited number of elements are called bounded collections. A collection which has no lower or upper limits on row numbers are called unbounded collections.
Dense & Sparse Collection. – Collections is said to be dense if all the rows between the first and the last are defined and given a value. And a collection in which rows are not defined and populated sequentially are called sparse collection.


PL/SQL collections:
    1. Persistent: stores the collection structure with the data physicaly in to the db
        - Nested Tables: single-dimensional, unbounded collections of homogeneous elements || TYPE t_num IS TABLE OF NUMBER;
        - Variable Sized Arrays or VARRAYs: single-dimensional, bounded collections of homogeneous elements || TYPE t_num IS VARRAY(2) OF NUMBER;

    2. Non-persistent: stores just for one session
        - Associative arrays: single-dimensional, unbounded, sparse collections(not sequential) of homogeneous elements. || TYPE t_num IS TABLE OF NUMBER INDEX BY NUMBER;

*/

-- -- PL/SQL Nested Tables
-- create nested table using user defined data type
TYPE nested_table_type 
    IS TABLE OF element_datatype [NOT NULL];

nested_table_variable nested_table_type;

CREATE [OR REPLACE] TYPE nested_table_type
    IS TABLE OF element_datatype [NOT NULL];

DROP TYPE type_name [FORCE];

nested_table_variable := nested_table_type();

nested_table_variable nested_table_type := nested_table_type();


-- -- Add elements to a nested table
nested_table_variable.EXTEND;

-- :=
nested_table_variable := element;


-- multiple elements
nested_table_variable.EXTEND(n);

nested_table_variable := element_1;
nested_table_variable := element_2;
..
nested_table_variable := element_n;

-- Accessing elements by their indexes
nested_table_variable(index);

-- Iterate over the elements of a nested table
FOR l_index IN nested_table_variable.FIRST..nested_table_variable.LAST
LOOP
    -- access element

END LOOP;


-- Putting it all together
-- Example 1 (Working)
CREATE TABLE customers(
    id NUMBER,
    name VARCHAR2(100)
);

INSERT ALL
    INTO customers VALUES(1, 'John')
    INTO customers VALUES(2, 'Doe')
    INTO customers VALUES(3, 'Smith')
    INTO customers VALUES(4, 'Johnson')
    INTO customers VALUES(5, 'Williams')
    INTO customers VALUES(6, 'Brown')
    INTO customers VALUES(7, 'Jones')
    INTO customers VALUES(8, 'Miller')
    INTO customers VALUES(9, 'Davis')
    INTO customers VALUES(10, 'Garcia')
    INTO customers VALUES(11, 'Rodriguez')
    INTO customers VALUES(12, 'Wilson')
    INTO customers VALUES(13, 'Martinez')
    INTO customers VALUES(14, 'Anderson')
    INTO customers VALUES(15, 'Taylor')
    INTO customers VALUES(16, 'Thomas')
    INTO customers VALUES(17, 'Hernandez')
    INTO customers VALUES(18, 'Moore')
    INTO customers VALUES(19, 'Martin')
    INTO customers VALUES(20, 'Jackson')
SELECT * FROM dual;

DECLARE
    -- declare a cursor that return customer name
    CURSOR c_customer IS 
        SELECT name 
        FROM customers
        ORDER BY name 
        FETCH FIRST 10 ROWS ONLY;
    -- declare a nested table type   
    TYPE t_customer_name_type 
        IS TABLE OF customers.name%TYPE;
    
    -- declare and initialize a nested table variable(like creating an object)
    t_customer_names t_customer_name_type := t_customer_name_type(); 
    
BEGIN
    -- populate customer names from a cursor
    FOR r_customer IN c_customer 
    LOOP
        t_customer_names.EXTEND;
        t_customer_names(t_customer_names.LAST) := r_customer.name;
    END LOOP;
    
    -- display customer names
    FOR l_index IN t_customer_names.FIRST..t_customer_names.LAST 
    LOOP
        dbms_output.put_line(t_customer_names(l_index));
    END LOOP;
END;
/


-- Example 2 (Not working)
/*
-- drop all
DROP TABLE Base_Table;
DROP TYPE My_NT;
DROP TYPE object_type;

CREATE OR REPLACE TYPE object_type AS OBJECT (
    obj_id  NUMBER,
    obj_name  VARCHAR2(10)
);
/
-- object =  | obj_id | obj_name | -> My_NT(col name)
CREATE OR REPLACE TYPE My_NT IS TABLE OF object_type;
/

CREATE TABLE Base_Table(
    tab_id  NUMBER,
    tab_ele My_NT := My_NT();
) NESTED TABLE tab_ele STORE AS stor_tab_1;
/

-- Base_Table = | tab_id | tab_ele               |
-- ______________________________________________
            --  | tab_id | ( obj_id | obj_name ) |
*/


-- -- PL/SQL VARRAYs (variable sized arrays)
TYPE type_name 
    IS VARRAY(max_elements) OF element_type [NOT NULL];

nested_table_variable nested_table_type;

CREATE [OR REPLACE] TYPE nested_table_type
    IS TABLE OF element_datatype [NOT NULL];

nested_table_variable := nested_table_type();

nested_table_variable nested_table_type := nested_table_type();
nested_table_variable.EXTEND;
nested_table_variable := element;

nested_table_variable.EXTEND(n);

nested_table_variable := element_1;
nested_table_variable := element_2;
..
nested_table_variable := element_n;


nested_table_variable(index);

FOR l_index IN nested_table_variable.FIRST..nested_table_variable.LAST
LOOP
    -- access element

END LOOP;



-- ALL IN ONE Example:
DECLARE
    -- declare a cursor that return customer name
    CURSOR c_customer IS 
        SELECT name 
        FROM customers
        ORDER BY name 
        FETCH FIRST 10 ROWS ONLY;
    -- declare a nested table type   
    TYPE t_customer_name_type 
        IS TABLE OF customers.name%TYPE;
    
    -- declare and initialize a nested table variable
    t_customer_names t_customer_name_type := t_customer_name_type(); 
    
BEGIN
    -- populate customer names from a cursor
    FOR r_customer IN c_customer 
    LOOP
        t_customer_names.EXTEND;
        t_customer_names(t_customer_names.LAST) := r_customer.name;
    END LOOP;
    
    -- display customer names
    FOR l_index IN t_customer_names.FIRST..t_customer_names.LAST 
    LOOP
        dbms_output.put_line(t_customer_names(l_index));
    END LOOP;
END;

-- Example 2
DECLARE
    TYPE r_customer_type IS RECORD(
        customer_name customers.name%TYPE,
        credit_limit customers.credit_limit%TYPE
    ); 

    TYPE t_customer_type IS VARRAY(5) 
        OF r_customer_type;
    
    t_customers t_customer_type := t_customer_type();

    CURSOR c_customer IS 
        SELECT NAME, credit_limit 
        FROM customers 
        ORDER BY credit_limit DESC 
        FETCH FIRST 5 ROWS ONLY;
BEGIN
    -- fetch data from a cursor
    FOR r_customer IN c_customer LOOP
        t_customers.EXTEND;
        t_customers(t_customers.LAST).customer_name := r_customer.name;
        t_customers(t_customers.LAST).credit_limit  := r_customer.credit_limit;
    END LOOP;

    -- show all customers
    FOR l_index IN t_customers.FIRST..t_customers.LAST 
    LOOP
        dbms_output.put_line(
            'The customer ' ||
            t_customers(l_index).customer_name ||
            ' has a credit of ' ||
            t_customers(l_index).credit_limit
        );
    END LOOP;
END;
/


-- PL/SQL Associative Array
TYPE associative_array_type 
    IS TABLE OF datatype [NOT NULL]
    INDEX BY index_type;


associative_array associative_array_type 
t_capital t_capital_type;
array_name(index)
array_name(index) := value;


DECLARE
    -- declare an associative array type
    TYPE t_capital_type 
        IS TABLE OF VARCHAR2(100) 
        INDEX BY VARCHAR2(50);
    -- declare a variable of the t_capital_type
    t_capital t_capital_type;
BEGIN
    
    t_capital('USA')            := 'Washington, D.C.';
    t_capital('United Kingdom') := 'London';
    t_capital('Japan')          := 'Tokyo';
    
    -- display the capital of Japan
    dbms_output.put_line('The capital of Japan is ' || t_capital('Japan'));

END;
/

DECLARE
    -- declare an associative array type
    TYPE t_capital_type 
        IS TABLE OF VARCHAR2(100) 
        INDEX BY VARCHAR2(50);
    -- declare a variable of the t_capital_type
    t_capital t_capital_type;
    -- local variable
    l_country VARCHAR2(50);
BEGIN
    
    t_capital('USA')            := 'Washington, D.C.';
    t_capital('United Kingdom') := 'London';
    t_capital('Japan')          := 'Tokyo';
    
    l_country := t_capital.FIRST;
    
    WHILE l_country IS NOT NULL 
    LOOP
        dbms_output.put_line('The capital of ' || 
            l_country || 
            ' is ' || 
            t_capital(l_country));
        l_country := t_capital.NEXT(l_country);
    END LOOP;
END;
/