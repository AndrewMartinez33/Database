# Percent Rank

The PERCENT_RANK() is a window function that calculates the percentile rank of a row within a partition or result set.

The PERCENT_RANK() function returns a number that ranges from zero to one.

For a specified row, PERCENT_RANK() calculates the rank of that row minus one, divided by 1 less than number of rows in the evaluated partition or query result set

(rank - 1) / (total_rows - 1)

The PERCENT_RANK() function always returns zero for the first row in a partition or result set. The repeated column values will receive the same PERCENT_RANK() value.

```sql
PERCENT_RANK()
    OVER (
        PARTITION BY <expression>
        ORDER BY <expression> ASC|DESC
)

-- EXAMPLE
SELECT
    first_name,
    last_name,
    salary,
    department_name,
    ROUND(
        PERCENT_RANK() OVER (
            PARTITION BY e.department_id
            ORDER BY salary
        )
    ,2) percentile_rank
FROM
    employees e
    INNER JOIN departments d
        ON d.department_id = e.department_id;

-- If a row in which salary of 44,000 returned a percent rank of 0.82, this means that the salary is larger than 82% of all salaries.

--The following query returns the top 30% of employees in the company based on their pay.
SELECT *
FROM
  (
    SELECT employee_id, first_name, salary,
    RANK() OVER(ORDER BY salary) sal_rank_in_Asc ,
    PERCENT_RANK() OVER(ORDER BY salary) sal_PERCENT_RANK
    FROM employees
  )
WHERE sal_PERCENT_RANK >= 0.7;

```

# AGGREGATE PERCENT_RANK

As an aggregate function, PERCENT_RANK calculates, for a hypothetical row "r", the rank of row "r" minus 1 divided by the number of rows in the aggregate group. This calculation is made as if the hypothetical row "r" were inserted into the group of rows. The arguments of the function identify a single hypothetical row within each aggregate group.

```SQL
PERCENT_RANK(expression, expression_N...) WITHIN GROUP (ORDER BY expression )

-- NOTE:
-- There must be the same number of expressions in the first expression list as there is in the ORDER BY clause.
-- The expression lists match by position so the data types must be compatible between the expressions in the first expression list as in the ORDER BY clause

--EXAMPLE
SELECT PERCENT_RANK(1500) WITHIN GROUP (ORDER BY no_of_votes)
FROM movies
```
