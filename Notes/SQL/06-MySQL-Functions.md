# Numeric Functions

```sql
ROUND(number, decimal_places) -- rounds the number
TRUNCATE(number, decimal_places) -- removes the numbers after the specified decimal place
CEILING(number) -- returns smallest integer that is >= to the number
FLOOR(number) -- returns the largest number that is <= to the number
ABS(number) -- returns the absolute number
RAND() -- returns a random floating point number between 0 and 1

```

# String Functions

```sql
LENGTH(string) -- returns number of characters in a string
UPPER(string) -- returns string in upper case
LOWER(string) -- returns string in lower case
LTRIM(string) -- removes white space on the left of the string
RTRIM(string) -- removes white space on the right of the string
TRIM(string)  -- removes white space on either side of the string
LEFT(string, number_of_chars) -- returns specified number of characters from the left side of the string
RIGHT(string, number_of_chars) -- returns specified number of characters from the right side of the string
SUBSTRING(string, start, length) -- returns substring from the start posiition to the length specifies. The length begins at the start position. if length is not specified, the substring from the start position to the end is returned
LOCATE(search_string, string) -- returns the position of the search_string in the string. This is not case sensitive. If character does not exist, 0 is returned.
REPLACE(string, string_to_replace, replacement_string)
CONCAT(string1, string2,...stringN) -- concatenates string that are passed in

```

# Date Functions

```sql
NOW() -- returns the current date and time
CURDATE() -- returns the current date without the time component
CURTIME() -- returns the current time without the date component
YEAR(date) -- extracts the year from a date ex.2019
MONTH(date) -- extracts the month from a date as a number 1 - 12 (1 is January)
DAY(date) -- extracts day of the month
HOUR(date) -- returns the hour
MIN(date) -- returns the minutes
SECOND(date) -- returns the seconds
DAYNAME(date) -- returns the name of the day as a string, ex.Monday
DAYMONTH(date) --returns the name of the month as a string, ex. January
EXTRACT(specified_unit FROM date_time_value) -- this is part of the SQL standards and can be ported to other DBMS'
  EXTRACT(YEAR FROM NOW())
  EXTRACT(DAY FROM NOW())
  EXTRACT(MONTH FROM NOW())
```

# Formatting Dates and Times

```sql
DATE_FORMAT(date_value, format)
DATE_FORMAT(date_value, '%y') -- returns a 2-digit year
DATE_FORMAT(date_value, '%Y') -- returns a 4-digit year
DATE_FORMAT(date_value, '%m') -- returns a 2-digit month
DATE_FORMAT(date_value, '%M') -- returns a month name
DATE_FORMAT(date_value, '%d') -- returns day of the month
DATE_FORMAT(NOW(), '%M %d %Y') -- May 14 2019

TIME_FORMAT(NOW(), '%H:%i %p') -- 12:53 pm

-- Look at documentation for more specifiers

```

# Calculating Dates and Times

```sql
DATE_ADD(date_time_value, INTERVAL value unit)
DATE_ADD(NOW(), INTERVAL 1 DAY) -- adds one day
DATE_ADD(NOW(), INTERVAL 1 YEAR) -- adds one year

DATE_SUB(NOW(), INTERVAL 1 DAY) -- subtracts one day
DATE_SUB(NOW(), INTERVAL 1 YEAR) -- subtracts one year

DATEDIFF(date1, date2) -- returns difference, in days, between two date values

TIME_TO_SEC(time) -- number of seconds elapsed since midnight
TIME_TO_SEC(time) - TIME_TO_SEC(time2) -- the difference between two time values

```

# IFNULL and COALESCE

```sql
IFNULL(column_name, 'assigned_value') -- if column name is null return assigned value

COALESCE(column_1, column_2, 'assigned value') -- pass in a list of values and the function will return the first Non-Null value

```

# IF Function

```sql
--can be used in the SELECT statement
IF(expression, return_argument_true, return_argument_false)

SELECT
  order_id,
  IF(
    YEAR(order_date) = YEAR(NOW()),
    'ACTIVE',
    'ARCHIVED') AS category
FROM orders

```

# CASE operator

```sql
-- if we have multiple expressions to test, we can use the CASE operator
SELECT
  order_id,
  CASE
    WHEN YEAR(order_date) = YEAR(NOW())
      THEN 'ACTIVE'
    WHEN YEAR(order_date) = YEAR(NOW()) - 1
      THEN 'Last Year'
    ELSE 'return default value'
  -- you need the END keyword to close the CASE statement
  END AS category
FROM orders


```
