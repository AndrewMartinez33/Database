# What are window functions?

A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities. Behind the scenes, the window function is able to access more than just the current row of the query result.

Query processing using analytic functions takes place in three stages.

1. JOIN, WHERE, GROUP BY, and HAVING clauses are performed
2. The result set is made available to the analytic functions and all their calculations take place
3. If the query has an ORDER BY clause at its end, the ORDER BY is processed to allow for precise output ordering.

# RANK

The RANK() function assigns a rank to each row within the partition of a result set. The rank of a row is specified by one plus the number of ranks that come before it.

- the partition clause is optional
- the order by clause is mandatory

```sql
RANK() OVER( [query_partition_clause] order_by_clause )

-- EXAMPLE
SELECT emp_id, name, salary,
  RANK() OVER(ORDER BY salary DESC) sal_rank
FROM emp

-- PARTITION EXAMPLE
-- With partition, the rank value resets whenever the group changes
SELECT emp_id, name, salary,
  RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) sal_rank
FROM emp
```

NOTE: with RANK there are gaps in the rank values returned.

```txt
rank
----
 1
 1
 3
 3
 3
 3
 7
 7
```

# DENSE_RANK

The DENSE_RANK() is a window function that assigns a rank to each row within a partition or result set with no gaps in ranking values.

The rank of a row is increased by one from the number of distinct rank values which come before the row.

```txt
rank
----
 1
 1
 2
 2
 2
 2
 3
 3
```

```sql
DENSE_RANK() OVER( [query_partition_clause] order_by_clause )

--EXAMPLE
SELECT emp_id, name, salary,
  DENSE_RANK() OVER(ORDER BY salary DESC) sal_rank
FROM emp

-- PARTITION EXAMPLE
-- With partition, the rank value resets whenever the group changes
SELECT emp_id, name, salary,
  DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) sal_rank
FROM emp
```

# DEALING WITH NULLS

When using ORDER BY DESC , the NULL's appear first

We have 2 solutions

```sql
SELECT emp_id, name, salary , DENSE_RANK() OVER(ORDER BY NVL(salary ,0) DESC) sal_rank
FROM emp

SELECT emp_id, name, salary , DENSE_RANK() OVER(ORDER BY salary DESC NULLS LAST) sal_rank
FROM emp
```

# AGGREGATE RANK AND DENSE_RANK

Used as aggregate functions, RANK and DENSE_RANK will return the rank or dense rank value of a row within a group of rows.

```SQL
RANK(expression, expression_N...) WITHIN GROUP (ORDER BY expression )

-- NOTE:
-- There must be the same number of expressions in the first expression list as there is in the ORDER BY clause.
-- The expression lists match by position so the data types must be compatible between the expressions in the first expression list as in the ORDER BY clause

--EXAMPLE
SELECT
  DENSE_RANK(1000, 500) WITHIN GROUP (ORDER BY salary, bonus)
FROM employees;

-- You can also use values not in the table. This would return the DENSE_RANK value of 30000 if it did exist in the table.
SELECT DENSE_RANK (30000) WITHIN GROUP (ORDER BY salary DESC ) ranks
FROM employees ;

-- The WHERE clause will be executed first
SELECT
  DENSE_RANK (10000) WITHIN GROUP (ORDER BY salary DESC ) ranks
FROM employees
WHERE DEPARTMENT_ID=80
```
