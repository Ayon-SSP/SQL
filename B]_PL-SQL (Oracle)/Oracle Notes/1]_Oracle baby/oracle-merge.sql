-- Merge data from source_table to target_table
CREATE TABLE target_table (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    age NUMBER
);

CREATE TABLE source_table (
    id NUMBER,
    name VARCHAR2(50),
    age NUMBER
);

INSERT INTO target_table VALUES (1, 'John', 30);
INSERT INTO target_table VALUES (2, 'Alice', 25);

INSERT INTO source_table VALUES (1, 'John', 31);
INSERT INTO source_table VALUES (3, 'Bob', 28);

SELECT * FROM target_table;
SELECT * FROM source_table;

MERGE INTO target_table tgt
USING source_table src
ON (tgt.id = src.id)
WHEN MATCHED THEN
  UPDATE SET tgt.name = src.name, tgt.age = src.age
WHEN NOT MATCHED THEN
  INSERT (id, name, age)
  VALUES (src.id, src.name, src.age);

SELECT * FROM target_table;
/*
ID  | NAME  | AGE
------------------
1   | John  | 31
2   | Alice | 25
3   | Bob   | 28
*/