# LISTAGG

The listagg function transforms values from a group of rows into a list of values that are delimited by a configurable separator. Listagg is typically used to denormalize rows into a string of comma-separated values (CSV) or other comparable formats suitable for human reading.

Listagg does not apply any escaping: it is not generally possible to tell whether an occurrence of the separator in the result is an actual separator, or just part of a value. The safe use of listagg for electronic data interfaces is therefore limited to cases in which an unambiguous separator can be selected, e.g. when aggregating numbers, dates, or strings that are known to not contain the separator.

```SQL
-- Aggregate Syntax: used more often
LISTAGG(measure_expr [, 'delimiter']) WITHIN GROUP (order_by_clause)
-- Analytic Syntax: used less often
LISTAGG(measure_expr [, 'delimiter']) WITHIN GROUP (order_by_clause)[OVER query_partition_clause]

-- For a specified measure, LISTAGG orders data within each group specified in the ORDER BY clause and then concatenates the values of the measure column.
--Aggregate Examples
SELECT LISTAGG(FIRST_NAME, ', ')
         WITHIN GROUP (ORDER BY  FIRST_NAME) "Emp_list"
FROM EMPLOYEES
WHERE department_id = 30;

SELECT DEPARTMENT_ID, LISTAGG(FIRST_NAME, ', ')
         WITHIN GROUP (ORDER BY  FIRST_NAME) "Emp_list"
FROM EMPLOYEES
WHERE department_id = 30
group by DEPARTMENT_ID
```

# ANALYTICAL LISTAGG

The analytical syntax will create the same list for each row
