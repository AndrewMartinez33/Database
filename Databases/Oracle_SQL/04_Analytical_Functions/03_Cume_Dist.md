# Cumulative Distribution

Sometimes, you want to pull the top or bottom x% values from a data set e.g., top 5% salesman by volume. To do this, you can use the Oracle CUME_DIST() function.

The CUME_DIST() function is an analytic function that calculates the cumulative distribution of a value in a set of values. The result of CUME_DIST() is greater than 0 and less than or equal to 1. Tie values evaluate to the same cumulative distribution value.

NOTE:

- The range of values returned by CUME_DIST is >0 to <=1
- CUME_DIST = ( the last record number of rank in its partition ) / (number of rows in the partition )

```sql
CUME_DIST() OVER (
    [ query_partition_clause ]
    order_by_clause
)


-- EXAMPLE
--The following statement calculates the sales percentile for each salesman in 2017:

SELECT
    salesman_id id,
    sales,
    CUME_DIST() OVER(ORDER BY sales DESC) cume_dist
FROM
    salesman_performance
WHERE
    YEAR = 2017;
```

RESULT: As shown in the output, 33.33 % of salesman have sales amount greater than 1.99 million.

```txt
id    sales     cume_dist
----  -----     ---------
62    3768999   0.1111
60    2092044   0.2222
55    1090776   0.3333
61    1581459   0.4444
...
```

# AGGREGATE CUME_DIST

```SQL
CUME_DIST(expression, expression_N...) WITHIN GROUP (ORDER BY expression )

-- NOTE:
-- There must be the same number of expressions in the first expression list as there is in the ORDER BY clause.
-- The expression lists match by position so the data types must be compatible between the expressions in the first expression list as in the ORDER BY clause
-- imagine that you insert a new record, then, use the formula:
-- CUME_DIST = ( the last record number of rank in its partition ) / (number of rows in the partition )

--EXAMPLE
SELECT
  CUME_DIST(7) WITHIN GROUP (ORDER BY no_of_votes)
FROM movies
```
