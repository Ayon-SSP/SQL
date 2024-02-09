-- Oracle Date Functions

Function	Example	Result	Description
ADD_MONTHS	ADD_MONTHS( DATE '2016-02-29', 1 )	     31-MAR-16	                 Add a number of months (n) to a date and return the same day which is n of months away.
LAST_DAY    LAST_DAY( DATE '2016-02-29' )	         29-FEB-16	                 Return the last day of the month for a date.
TO_CHAR	    TO_CHAR( DATE'2017-01-01', 'DL' )	     Sunday, January 01, 2017	Convert a DATE or an INTERVAL value to a character string in a specified format.
TO_DATE	    TO_DATE( '01 Jan 2017', 'DD MON YYYY' )	 01-JAN-17	                Convert a date which is in the character string to a DATE value.
TRUNC	    TRUNC(DATE '2017-07-16', 'MM')	         01-JUL-17	                Return a date truncated to a specific unit of measure.


SELECT ADD_MONTHS(SYSDATE, 1) AS project_due_date FROM dual;
SELECT ADD_MONTHS(DATE '2016-02-20', 1) AS project_due_date FROM dual;


-- TO_CHAR
/* 
DD for day of month.
MM for month.
YYYY for year.
HH for hour.
MI for minute.
SS for second. 

TO_CHAR(123.456, '$0,0.00')
TO_CHAR(SYSDATE, 'DD-MON-YYYY')



*/