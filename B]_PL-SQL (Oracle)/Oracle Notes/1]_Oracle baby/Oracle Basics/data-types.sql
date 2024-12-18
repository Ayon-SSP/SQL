/*
Character Data Types:
    CHAR(n): Fixed-length character string with a maximum length of n characters.
    VARCHAR2(n): Variable-length character string with a maximum length of n characters.
    NCHAR(n): Fixed-length Unicode character string with a maximum length of n characters.
    NVARCHAR2(n): Variable-length Unicode character string with a maximum length of n characters.
    CLOB: Character large object for storing large amounts of character data.

Numeric Data Types:
    NUMBER(precision, scale): Fixed-point or floating-point number with specified precision and scale.
    INTEGER: Whole numbers within the range of -2,147,483,648 to 2,147,483,647.
    FLOAT: Floating-point number with binary precision p.
    DOUBLE PRECISION: Double-precision floating-point number.

Date and Time Data Types:
    DATE: Date and time data in the format 'YYYY-MM-DD HH:MI:SS'.
    TIMESTAMP: Date and time data with fractional seconds precision.
    INTERVAL: Represents a period of time.

Binary Data Types:
    BLOB: Binary large object for storing large amounts of binary data.
    RAW(n): Fixed-length binary data with a maximum length of n bytes.
    LONG RAW: Variable-length binary data.

Large Object Data Types:
    BFILE: Binary file data stored outside the database.
    NCLOB: Unicode character large object.

Row Identifier Data Types:
    ROWID: Binary representation of a row's address.
    UROWID: Universal row identifier, encoded as base 64.

*/


-- CHAR(size)
/*
* DEFAULT 1
* CHARACERS ARE FIXED LENGTH
* IF YOU INSERT LESS THAN THE SIZE IT WILL BE FILLED WITH SPACE
* CHARACTERS RANGE FROM 1 TO 2000 bytes
*/


CREATE TABLE Temp_1 (col1 CHAR(5));
INSERT INTO Temp_1 VALUES ('AYON');
INSERT INTO Temp_1 VALUES ('KAYON');
INSERT INTO Temp_1 VALUES ('abc');

SELECT * FROM Temp_1;
-- HOW TO CALCULATE THE SPACE OF col1 FOR ORACLE
SELECT SUM(VSIZE(col1)) FROM Temp_1; -- 15 CAUSE 5*3 TAKING WHOLE SPACE
DROP TABLE Temp_1;

-- VARCHAR2(size)
/*
* DEFAULT 1
* CHARACERS ARE VARIABLE LENGTH
* IF YOU INSERT LESS THAN THE SIZE IT WILL BE Take the size of the string
* CHARACTERS RANGE FROM 1 TO 4000 bytes
*/


CREATE TABLE Temp_2 (col1 VARCHAR2(5));
INSERT INTO Temp_2 VALUES ('AYON');
INSERT INTO Temp_2 VALUES ('SSP');

SELECT * FROM Temp_2;
SELECT col1, VSIZE(col1) FROM Temp_2; -- 8 CAUSE 5+3 TAKING WHOLE SPACE




CREATE TABLE t (
    x CHAR(10),
    y VARCHAR2(10)
);
INSERT INTO t(x, y )
VALUES('Oracle', 'Oracle');
SELECT
    x, DUMP(x),
    y, DUMP(y)
FROM t;

-- X,         DUMP(X),                                        Y,      DUMP(Y)
-- Oracle    ,Typ=96 Len=10: 79,114,97,99,108,101,32,32,32,32,Oracle,Typ=1 Len=6: 79,114,97,99,108,101


SELECT
    LENGTHB(x),
    LENGTHB(y)
FROM
    t;

-- LENGTHB(X),LENGTHB(Y)
-- 10,        6

-- to compare the strings with different data types use
select * from t where rtrim(x) = :v;




CREATE TABLE Temp_number_demo ( 
    number_value NUMERIC(6, 2) 
);

INSERT INTO Temp_number_demo
VALUES(9999.99);

INSERT INTO Temp_number_demo
VALUES(-9999.99);

INSERT INTO Temp_number_demo
VALUES(9999.999); -- ERROR

SELECT * FROM Temp_number_demo;

DELETE FROM Temp_number_demo;

ALTER TABLE Temp_number_demo
MODIFY number_value NUMERIC(6, 0);

INSERT INTO Temp_number_demo VALUES (9999.99);
INSERT INTO Temp_number_demo VALUES (-9999.99);
INSERT INTO Temp_number_demo VALUES (-9999.999);
INSERT INTO Temp_number_demo VALUES (976354.978);
INSERT INTO Temp_number_demo VALUES (976364.978);
INSERT INTO Temp_number_demo VALUES (976314.978);
INSERT INTO Temp_number_demo VALUES (976314.978);
INSERT INTO Temp_number_demo VALUES (976314.578);
INSERT INTO Temp_number_demo VALUES (976314.478);

SELECT * FROM Temp_number_demo;

-- DATEDIFF()


-- THIS IS VERY CONFUSION
CREATE TABLE number_demo ( 
    number_value NUMERIC(6, 2) 
);


INSERT INTO number_demo
VALUES(100.99);

INSERT INTO number_demo
VALUES(90.551);

INSERT INTO number_demo
VALUES(8.556014527);
