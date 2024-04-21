-- Oracle String Functions
-- ASCII: Returns the ASCII code value of the leftmost character of a string.
ASCII( 'ABC' )  -> 65
-- CHR: Returns the character having the binary equivalent to n as a VARCHAR2 value.
CHR( 65 )  -> A
-- CONCAT: Concatenate two strings and return the combined string.
CONCAT( 'ABC', 'DEF' )  -> ABCDEF
-- CONVERT: Convert a string from one character set to another.
CONVERT( 'ABC', 'UTF8', 'WE8MSWIN1252' )  -> ABC
-- DUMP: Returns a VARCHAR2 value that includes the datatype code, length in bytes, and internal representation of a raw or character string.
DUMP( 'ABC', 1016 )  -> Typ=96 Len=3: 65,66,67
-- INITCAP: Converts the first character in each word in a specified string to uppercase and the rest to lowercase.
INITCAP( 'abc def' )  -> Abc Def
-- INSTR: Returns the position of a substring in a string.
INSTR( 'ABCDEF', 'C' )  -> 3

SELECT
  INSTR( 'This is a playlist', 'is', 1, 1 ) third_occurrence,  -- 16 
  INSTR( 'This is a playlist', 'is', -1, 1 ) second_occurrence, -- 6 (-1 means search from the end of the string))
  INSTR( 'This is a playlist is', 'is', 1, 4 ) third_occurrence,  -- 20 
  INSTR( 'This is a playlist is', 'is', 1, 5 ) third_occurrence,  -- 0 if not foutnd 
  INSTR( 'This is a playlist', 'is',-1 ) substring_location -- -1 means search from the end of the string
FROM dual;
-- LENGTH
LENGTH( 'ABC' )  -> 3
-- LOWER: Converts all letters in the specified string to lowercase.
LOWER( 'ABC' )  -> abc
-- UPPER: Converts all letters in the specified string to uppercase.
UPPER( 'abc' )  -> ABC
-- LPAD: Left-pads a string to the specified length with the specified characters.
LPAD( 'ABC', 5, 'X' )  -> XXABC
-- SUBSTR: Returns a substring from a string, using a specified starting position and length.
SUBSTR( 'ABCDEF', 2, 3 )  -> BCD
-- TRIM: Removes all specified characters from the beginning and end of a string.
TRIM( 'ABC', 'A' )  -> BC
-- LTRIM: Removes all occurrences of a specified set of characters from the left end of a string.
LTRIM(' ABC ')  -> 'ABC '
RTRIM(' ABC ')  -> ' ABC'
-- REGEXP_COUNT: Returns the number of times a pattern occurs in a string.
REGEXP_COUNT( 'This is a playlist', 'is' )  -> 2
-- REGEXP_INSTR: Returns the position of the first occurrence of a regular expression in a string.
REGEXP_INSTR( 'This is a playlist', 'is' )  -> 3
-- REGEXP_REPLACE: REGEXP_REPLACE( string, pattern, replace_with, position, occurrence, match_param )
REGEXP_REPLACE( 'This is a playlist', 'is', 'IS' )  -> ThIS IS a playlist
-- REGEXP_SUBSTR: Returns the first occurrence of a regular expression in a string.
REGEXP_SUBSTR( 'This is a playlist', 'is' )  -> is
-- ...THERE ARE MANY READ FORM DOCS: https://www.oracletutorial.com/oracle-string-functions/
REPLACE( 'This is a test', 'is', 'IS' ) -> ThIS IS a test

TRANSLATE("12345", "143", "bx") | 1 -> b, 4 -> x, 3 -> ''; | -> 'b2x5'

REPLACE('JACK AND JOND','J','BL'); -> BLACK AND BLOND

-- LISTAGG: Concatenates the values of a column into a single string.
-- LISTAGG(expression [ WITHIN GROUP ( ORDER BY expression [, expression] ... ) [, DISTINCT ] [ , delimiter ] )
SELECT 
  customer_id, 
  LISTAGG(order_id, ', ') 
    WITHIN GROUP (ORDER BY order_date DESC) AS order_list
FROM orders
GROUP BY customer_id
FILTER (WHERE proficiency_level > 2)
ORDER BY customer_id;

SELECT level, department_id, LISTAGG(employee_name, ', ') AS dept_employees
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER BY level, department_id;

