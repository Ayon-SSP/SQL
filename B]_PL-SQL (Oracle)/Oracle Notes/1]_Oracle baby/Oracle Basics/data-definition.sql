-- . Create Table
-- . Constraint
--  . Create Table As
--  . Alter Table
--  . Drop Table
--  . Global Temp Tables
--  . Local Temp Tables
-- . Create Sequence & Synonym, Grant Option



-- Create Table As
CREATE TABLE new_table_name AS
SELECT column1, column2, ...
FROM existing_table_name
WHERE condition;

-- Global Temp Tables
CREATE GLOBAL TEMPORARY TABLE temp_table_name
(column1 datatype, column2 datatype, ...);

-- Local Temp Tables
CREATE TEMPORARY TABLE temp_table_name
(column1 datatype, column2 datatype, ...);

-- Create Sequence & Synonym, Grant Option
CREATE SEQUENCE sequence_name
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;
