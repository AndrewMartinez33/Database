# ROWNUM

If you were to implement a Top-N or pagination query in an Oracle database, you wouldn’t find any dedicated clause to limit the query result like TOP, LIMIT or FETCH FIRST. For each row returned by the query, Oracle provides a ROWNUM pseudocolumn that returns a number indicating the order in which the database selects the row from a table or set of joined views.

ROWNUM is a pseudocolumn that gets many people into trouble. A ROWNUM value is not permanently assigned to a row (this is a common misunderstanding). It may be confusing when a ROWNUM value is actually assigned. A ROWNUM value is assigned to a row after it passes filter predicates of the query but before query aggregation or sorting. What is more, a ROWNUM value is incremented only after it is assigned.

```sql
SELECT employee_id, first_name, salary
FROM
  (
  SELECT employee_id, first_name, salary
  FROM
    EMPLOYEES
  ORDER BY salary DESC
  )
WHERE ROWNUM <= 2
```

# ROW_NUMBER

ROW_NUMBER assigns a unique number from 1-N to the rows within a partition.
At first glance this may seem similar to the RANK and DENSE_RANK analytic functions,
but the ROW_NUMBER function ignores ties and always gives a unique number to each row.

```sql
ROW_NUMBER() OVER ([ query_partition_clause ] order_by_clause)

-- EXAMPLE
select employee_id, first_name, salary,
  ROW_NUMBER() OVER (order by salary desc ) r_num
from
  EMPLOYEES;

```
