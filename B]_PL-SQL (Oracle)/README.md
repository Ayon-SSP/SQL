# 🛢️ PL/SQL

## Overview
- PL/SQL is Oracle's proprietary extension of SQL. 
- Used Server-side programming language.

## 📐 Setting Up PL/SQL on Linux Ubuntu/WSL
> REFER TO [SETUP.md](SETUP.md) or [`Setting Up PL/SQL on Linux Ubuntu/WSL`](https://dev.to/ayon_ssp/setting-up-plsql-on-linux-ubuntuwsl-376d) FOR SETUP.

## 📚 Resources & 📑 Notes: [`my chatGPT`](https://chat.openai.com/c/6b158380-a1a0-47dc-82c8-89b1d013a655)
> before we start, let's see the basic structure of PL/SQL block.
Example 1:
```sql
DECLARE
   qty_on_hand  NUMBER(5);
BEGIN
   SELECT quantity INTO qty_on_hand FROM inventory
      WHERE product = 'TENNIS RACKET'
      FOR UPDATE OF quantity;
   IF qty_on_hand > 0 THEN  -- check quantity
      UPDATE inventory SET quantity = quantity - 1
         WHERE product = 'TENNIS RACKET';
      INSERT INTO purchase_record
         VALUES ('Tennis racket purchased', SYSDATE);
   ELSE
      INSERT INTO purchase_record
         VALUES ('Out of tennis rackets', SYSDATE);
   END IF;
   COMMIT;
END;
```
Example 2:
```sql
-- available online in file 'sample1'
DECLARE
   x NUMBER := 100;
BEGIN
   FOR i IN 1..10 LOOP
      IF MOD(i,2) = 0 THEN     -- i is even
         INSERT INTO temp VALUES (i, x, 'i is even');
      ELSE
         INSERT INTO temp VALUES (i, x, 'i is odd');
      END IF;
      x := x + 100;
   END LOOP;
   COMMIT;
END;
-- look 👇
```

Output Table
```
SQL> SELECT * FROM temp 
        ORDER BY col1;

NUM_COL1 NUM_COL2  CHAR_COL
-------- --------  ---------
       1      100  i is odd
       2      200  i is even
       3      300  i is odd
       4      400  i is even
       5      500  i is odd
       6      600  i is even
       7      700  i is odd
       8      800  i is even
       9      900  i is odd
      10     1000  i is even
```

> More examples: [PL/SQL samps](https://docs.oracle.com/cd/B10500_01/appdev.920/a96624/a_samps.htm)


### **PL/SQL Block Types**: 
  - Anonymous Block
  - Named Block
  - Subprogram
```sql
DECLARE
    Declaration Statements(Variables, Constants, Cursors, User-defined exceptions, Records, Collections, Subprograms, etc.) - Optional
BEGIN
    Executable Statements(Queries, DML, DDL, Transaction Control Statements, etc.) - Mandatory
EXCEPTION
    Exception Handling Statements(Handling Exceptions, Propagating Exceptions, etc.) - Optional
END;
```

