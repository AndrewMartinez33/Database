# LAG & LEAD

The LAG function provides access to a row at a given offset prior to the current position.

The LEAD function provides access to a row at a given offset after the current position.

```sql
-- value_expr - Can be a column or a built-in function
-- offset - The number of rows preceeding/following the current row, from which the data is to be retrieved. The default value is 1.
-- default - The value returned if the offset is outside the scope of the window. The default value is NULL

LAG(value_expr [, offset ][, default ]) OVER ([ query_partition_clause ] order_by_clause)

LEAD(value_expr [, offset ][, default ]) OVER ([ query_partition_clause ] order_by_clause)

-- EXAMPLES
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
  LAG(HIRE_DATE) OVER ( ORDER BY HIRE_DATE ) prev_hire_date,
  LEAD(HIRE_DATE) OVER ( ORDER BY HIRE_DATE ) next_hire_date
FROM EMPLOYEES

-- Here we specify an offset of three, so we get the value 3 rows behind and the value 3 rows ahead
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
  LAG(HIRE_DATE,3) OVER ( ORDER BY HIRE_DATE ) prev_3_hire_date,
  LEAD(HIRE_DATE,3) OVER ( ORDER BY HIRE_DATE ) next_3_hire_date
FROM EMPLOYEES

-- Here we replace NULL's with the 'no data' string
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
  LAG(to_char(HIRE_DATE),3,'no data') OVER ( ORDER BY HIRE_DATE ) prev_3_hire_date,
  LEAD(to_char(HIRE_DATE),3,'no data') OVER ( ORDER BY HIRE_DATE ) next_3_hire_date
FROM EMPLOYEES

-- Here we partition by department id
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, DEPARTMENT_ID,
  LAG(HIRE_DATE) OVER ( partition by department_id ORDER BY HIRE_DATE ) prev_hire_date ,
  LEAD(HIRE_DATE) OVER ( partition by department_id ORDER BY HIRE_DATE ) next_hire_date
FROM EMPLOYEES
```
