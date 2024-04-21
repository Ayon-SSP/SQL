-- data types should be same
-- UNION - removes duplicates
-- UNION ALL - does not remove duplicates
-- INTERSECT - returns common rows
-- MINUS - returns rows from first query that are not in second query



-- Creating sample tables
CREATE TABLE table1 (
    id NUMBER,
    name VARCHAR2(50)
);

CREATE TABLE table2 (
    id NUMBER,
    name VARCHAR2(50)
);

-- Inserting sample data
INSERT INTO table1 (id, name) VALUES (1, 'John');
INSERT INTO table1 (id, name) VALUES (2, 'Alice');
INSERT INTO table1 (id, name) VALUES (3, 'Bob');

INSERT INTO table2 (id, name) VALUES (3, 'Bob');
INSERT INTO table2 (id, name) VALUES (4, 'Charlie');


-- Query using UNION
SELECT id, name FROM table1
UNION
SELECT id, name FROM table2;
/*
ID   NAME
---- -------
1    John
2    Alice
3    Bob
4    Charlie

*/



-- Query using UNION ALL
SELECT id, name FROM table1
UNION ALL
SELECT id, name FROM table2;

/*
ID   NAME
---- -------
1    John
2    Alice
3    Bob
3    Bob
4    Charlie
*/

-- Intersect
/*
1    John
2    Alice
3    Bob

3    Bob
4    Charlie
*/

SELECT id, name FROM table1
INTERSECT
SELECT id, name FROM table2;

/*
ID   NAME
---- -------
3    Bob
*/

-- Minus
SELECT id, name FROM table1
MINUS
SELECT id, name FROM table2;

/*
ID   NAME
---- -------
1    John
2    Alice
*/