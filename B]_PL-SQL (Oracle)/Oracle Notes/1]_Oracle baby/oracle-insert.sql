
-- Modifying data


-- INSERT – learn how to insert a row into a table.
INSERT INTO table_name (column_list)
VALUES( value_list);

INSERT INTO discounts(discount_name, amount, start_date, expired_date)
VALUES('Summer Promotion', 9.5, DATE '2017-05-01', DATE '2017-08-31');


-- INSERT INTO SELECT – insert data into a table from the result of a query.
INSERT INTO target_table (col1, col2, col3)
SELECT col1,
      col2,
      col3
FROM source_table
WHERE condition;

-- INSERT ALL – discuss multitable insert statement to insert multiple rows into a table or multiple tables.
INSERT ALL
    INTO table_name(col1,col2,col3) VALUES(val1,val2, val3)
    INTO table_name(col1,col2,col3) VALUES(val4,val5, val6)
    INTO table_name(col1,col2,col3) VALUES(val7,val8, val9)
Subquery;
