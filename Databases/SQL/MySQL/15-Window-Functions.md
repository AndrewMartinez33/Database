# What are Window Functions?

A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities. Behind the scenes, the window function is able to access more than just the current row of the query result.

MySQL has supported window functions since version 8.0. The window functions allow you to solve query problems in new, easier ways, and with better performance.

Note that window functions are performed on the result set after all JOIN, WHERE, GROUP BY, and HAVING clauses and before the ORDER BY, LIMIT and SELECT DISTINCT.

# ROW_NUMBER

MySQL introduced the ROW_NUMBER() function since version 8.0. The ROW_NUMBER() is a window function or analytic function that assigns a sequential number to each row to which it applied beginning with one.

```sql
ROW_NUMBER() OVER (
    PARTITION BY <expression>
    ORDER BY <expression> ASC|DESC
)

-- The PARTITION BY clause breaks the rows into smaller sets. The expression can be any valid expression that would be used in the GROUP BY clause. You can use multiple expressions separated by commas.

-- The PARTITION BY clause is optional. If you omit it, the entire result set is considered a partition. However, when you use the PARTITION BY clause, each partition can be also considered as a window.

-- The purpose of the ORDER BY clause is to set the orders of rows. This ORDER BY clause is independent of the ORDER BY clause of the query.

-- Example
-- Assigns a sequential number to each row from the products table
SELECT
 ROW_NUMBER() OVER (
 ORDER BY productName
 ) row_num,
    productName,
    msrp
FROM
 products
ORDER BY
 productName;

 -- NOTE: Because the ROW_NUMBER() assigns each row in the result set a unique number, you can use it for pagination.
```

# RANK

The RANK() function assigns a rank to each row within the partition of a result set. The rank of a row is specified by one plus the number of ranks that come before it.

```sql
RANK() OVER (
    PARTITION BY <expression>
    ORDER BY <expression> ASC|DESC
)

-- Example
SELECT
    sales_employee,
    fiscal_year,
    sale,
    RANK() OVER (PARTITION BY
                     fiscal_year
                 ORDER BY
                     sale DESC
                ) AS sales_rank
FROM
    sales;

-- First, the PARTITION BY clause breaks the result sets into partitions by fiscal year.
-- Then, the ORDER BY clause sorts the sales employees by sales in descending order.

-- NOTE: Unlike the ROW_NUMBER() function, the RANK() function does not always return consecutive integers.
```

# DENSE_RANK

The DENSE_RANK() is a window function that assigns a rank to each row within a partition or result set with no gaps in ranking values.

The rank of a row is increased by one from the number of distinct rank values which come before the row.

```sql
DENSE_RANK() OVER (
    PARTITION BY <expression>
    ORDER BY <expression> ASC|DESC
)

--Example
SELECT
    sales_employee,
    fiscal_year,
    sale,
    DENSE_RANK() OVER (PARTITION BY
                     fiscal_year
                 ORDER BY
                     sale DESC
                ) sales_rank
FROM
    sales;

-- First, the PARTITION BY clause divided the result sets into partitions using fiscal year.
-- Second, the ORDER BY clause specified the order of the sales employees by sales in descending order.
-- Third, the DENSE_RANK() function is applied to each partition with the rows order specified by the ORDER BY clause.

```

# PERCENT_RANK

The PERCENT_RANK() is a window function that calculates the percentile rank of a row within a partition or result set.

The PERCENT_RANK() function returns a number that ranges from zero to one.

For a specified row, PERCENT_RANK() calculates the rank of that row minus one, divided by 1 less than number of rows in the evaluated partition or query result set

The PERCENT_RANK() function always returns zero for the first row in a partition or result set. The repeated column values will receive the same PERCENT_RANK() value.

```sql
PERCENT_RANK()
    OVER (
        PARTITION BY <expression>
        ORDER BY <expression> ASC|DESC
)

```
