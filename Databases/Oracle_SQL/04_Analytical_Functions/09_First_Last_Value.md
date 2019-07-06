# FIRST_VALUE & LAST_VALUE

The FIRST_VALUE() is an analytic function that allows you to get the first value in an ordered set of value

The LAST_VALUE() is an analytic function that allows you to obtain the last value in an ordered set of values.

```sql
FIRST_VALUE (expression) [ {RESPECT | IGNORE} NULLS ])
OVER (
    [ query_partition_clause ]
    order_by_clause
    [windowing_clause]
)


LAST_VALUE (expression) [ {RESPECT | IGNORE} NULLS ])
OVER (
    [ query_partition_clause ]
    order_by_clause
    [windowing_clause]
)


-- IMPORTANT!
-- With most analytic function, the function is calculated after the WHERE and HAVING but before the ORDER BY.
-- With the first and last value functions, if you leave the order by and partition clause's empty,
-- the function uses the order by statement in the select query. So, the function is calculated after the order by statement
SELECT employee_id, salary,
  FIRST_VALUE(salary) OVER()
FROM employees
ORDER BY salary

-- More Examples
SELECT employee_id, salary,
  first_value(salary) OVER( ORDER BY salary )
FROM employees
ORDER BY salary

SELECT val,
  FIRST_VALUE(val) IGNORE NULLS OVER( ORDER BY val DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
FROM understand_RESPECT_IGNORE
```
