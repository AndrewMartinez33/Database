```txt
Function	          Example	                            Result	Description
--------            -------                             ------  -----------
ADD_MONTHS	        ADD_MONTHS(DATE '2016-02-29', 1)	                      Add a number of months (n) to a date and return the same day which is n of months away.
CURRENT_DATE	      SELECT CURRENT_DATE FROM dual	                          Return the current date and time in the session time zone
CURRENT_TIMESTAMP	  SELECT CURRENT_TIMESTAMP FROM dual	                    Return the current date and time with time zone in the session time zone
DBTIMEZONE	        SELECT DBTIMEZONE FROM dual;	                          Get the current database time zone
EXTRACT	            EXTRACT(YEAR FROM SYSDATE)	                            Extract a value of a date time field e.g., YEAR, MONTH, DAY, … from a date time value.
FROM_TZ	            FROM_TZ(TIMESTAMP '2017-08-08 08:09:10', '-09:00')	    Convert a timestamp and a time zone to a TIMESTAMP WITH TIME ZONE value
LAST_DAY	          LAST_DAY(DATE '2016-02-01')	                            Gets the last day of the month of a specified date.
LOCALTIMESTAMP	    SELECT LOCALTIMESTAMP FROM dual	                        Return a TIMESTAMP value that represents the current date and time in the session time zone.
MONTHS_BETWEEN	    MONTHS_BETWEEN( DATE '2017-07-01', DATE '2017-01-01' )  Return the number of months between two dates.
NEW_TIME	          NEW_TIME( TO_DATE( '08-07-2017 01:30:45', 'MM-DD-YYYY HH24:MI:SS' ), 'AST', 'PST' )	 Convert a date in one time zone to another
NEXT_DAY	          NEXT_DAY( DATE '2000-01-01', 'SUNDAY' )	                Get the first weekday that is later than a specified date.
ROUND	              ROUND(DATE '2017-07-16', 'MM')	                        Return a date rounded to a specific unit of measure.
SESSIONTIMEZONE	    SELECT SESSIONTIMEZONE FROM dual;	                      Get the session time zone
SYSDATE	            SYSDATE	                                                Return current system date and time of the operating system where the Oracle Database resides.
SYSTIMESTAMP	      SELECT SYSTIMESTAMP FROM dual;	                        Return the system date and time that includes fractional seconds and time zone.
TO_CHAR	            TO_CHAR( DATE'2017-01-01', 'DL' )	                      Convert a DATE or an INTERVAL value to a character string in a specified format.
TO_DATE	            TO_DATE( '01 Jan 2017', 'DD MON YYYY' )	                Convert a date which is in the character string to a DATE value.
TRUNC	              TRUNC(DATE '2017-07-16', 'MM')	                        Return a date truncated to a specific unit of measure.
TZ_OFFSET	          TZ_OFFSET( 'Europe/London' )	                          Get time zone offset of a time zone name from UTC
```
