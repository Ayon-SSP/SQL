SET SERVEROUTPUT ON;
DECLARE
    v_test VARCHAR2(20) := 'Hello World';
BEGIN
    dbms_output.put_line(v_test);
END;

-- write a plsql code to display the 1 to 10 numbers
-- SET SERVEROUTPUT ON;
-- DECLARE
--     v_test NUMBER := 1;
-- BEGIN
--     WHILE v_test <= 10 LOOP
--         dbms_output.put_line(v_test);
--         v_test := v_test + 1;
--     END LOOP;
-- END;

-- SELECT * FROM tab;


-- write sql query to create employee table create and insert some random data.
CREATE TABLE employee (
    emp_id NUMBER,
    emp_name VARCHAR2(20),
    emp_salary NUMBER,
    emp_dept VARCHAR2(20)
);

INSERT INTO employee VALUES (1, 'John', 10000, 'IT');
INSERT INTO employee VALUES (2, 'Smith', 20000, 'IT');
INSERT INTO employee VALUES (3, 'Raj', 30000, 'IT');
INSERT INTO employee VALUES (4, 'Rahul', 40000, 'IT');
INSERT INTO employee VALUES (5, 'Ramesh', 50000, 'IT');
INSERT INTO employee VALUES (6, 'Rajesh', 60000, 'IT');

SELECT * FROM employee;
DROP TABLE employee;