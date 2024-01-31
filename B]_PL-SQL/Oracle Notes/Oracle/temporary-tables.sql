CREATE GLOBAL TEMPORARY TABLE temp1(
    id INT,
    description VARCHAR2(100)
) ON COMMIT DELETE ROWS;

DROP TABLE temp1;

INSERT INTO temp1(id,description)
VALUES(1,'Transaction specific global temp table');

SELECT id, description 
FROM temp1;


COMMIT;