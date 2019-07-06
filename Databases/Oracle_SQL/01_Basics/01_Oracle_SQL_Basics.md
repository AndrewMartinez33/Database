# THE ORDER IN WHICH A QUERY IS LOGICALLY PROCESSED

1.  FROM - In this clause you specify the names of the tables you want to query and the table operators that operate on those tables.

2.  WHERE - In this clause you specify a predicate or logical expression to filter the rows returned by the FROM phase.

3.  GROUP BY - Arranges the rows returned by the previous phase into groups. Elements that do not participate in the GROUP BY clause are allowed only as inputs to an aggregate function such as COUNT, SUM, AVG, MIN, or MAX. For Example, the following would produce an error because Freight is not in the GROUP BY clause:

```sql
SELECT YEAR(orderDate), Freight
FROM Sales.Orders
GROUP BY YEAR(orderDate);

-- NOTE: all aggregate functions ignore NULLS with one exception, COUNT(*).
```

4. HAVING - this clause is a GROUP filter. GROUPs for which the predicate evaluates to TRUE are returned and FALSE and UNKNOWNS are discarded.

5. SELECT - In this clause you specify the attributes (columns) you want to return in the result table of the query. To specify a column alias use the AS keyword

```sql
SELECT YEAR(orderDate) AS orderYear
FROM Sales.Orders
GROUP BY YEAR(orderDate);

-- NOTE: Because the alias in the SELECT is logically processed after FROM, WHERE, GROUP BY and HAVING, it does not exist to those clauses.
```

6.  ORDER BY - Use the ORDER BY clause to sort the rows in the output for presentation purposes. This is the only way to guarantee order in a result table. - You can specify ASC or DESC. ASC is the default if nothing is specified. - With T-SQL you can order by elements that do not appear in the SELECT clause - When you use DISTINCT, you are restricted to only elements in the SELECT clause

# Section 2: Sorting data

- default is ASC order

```sql
SELECT
    column_1,
    column_2,
    column_3,
    ...
FROM
    table_name
ORDER BY
    column_1 [ASC | DESC] [NULLS FIRST | NULLS LAST],
    column_1 [ASC | DESC] [NULLS FIRST | NULLS LAST];
```

# Section 3: Filtering data

- DISTINCT – introduce you how to eliminate duplicate rows from the output of a query.
- WHERE – specify a condition for rows in the result set returned by a query.
- AND – combine two or more Boolean expressions and return true if all expressions are true.
- OR– combine two or more Boolean expressions and return true if one of the expressions is true.
- IN – determine if a value matches any value in a list or a subquery.
- BETWEEN – filter data based on a range of values.
- LIKE – perform matching based on specific patterns.
- FETCH – limit rows returned by a query using the row limiting clause.

```sql
-- DISTINCT
-- return distinct values
SELECT DISTINCT state
FROM customers;
```

```sql
-- WHERE
-- we use the where clause to filter data
-- if the condition is true, it returns the data
SELECT *
FROM customers
WHERE state = 'VA';

-- Conditional Operators
>   -- greater than
>=  -- greater than or equal to
<   -- less than
<=  -- less than or equal to
=   -- equal to
!=  -- not equal to
<>  -- not equal to
```

```sql
-- AND, OR, NOT, operators
-- we can combine conditions when filtering data with these operators
SELECT *
FROM customers
WHERE state = 'VA' AND state = 'CA'

-- Customers from VA or Customers from CA who have more than 100 points
SELECT *
FROM customers
WHERE state = 'VA' OR (state = 'CA' AND points > 100);

-- all other customers
SELECT *
FROM customers
WHERE NOT (state = 'VA' OR (state = 'CA' AND points > 100));
```

```sql
-- IN operator
-- We can use the IN operator when we want to compare to a list of values
SELECT *
FROM customers
WHERE state IN ('CA', 'FL', 'VA');

-- we can also combine this with the NOT operator
SELECT *
FROM customers
WHERE state NOT IN ('CA', 'FL', 'VA');
```

```sql
-- BETWEEN Operator
-- compare to a range of values
SELECT *
FROM customers
WHERE points BETWEEN 1000 and 2000;
```

```sql
-- LIKE operator
-- get values that match a specicific string pattern
SELECT *
FROM customers
-- name starts with b
WHERE last_name LIKE 'b%'
-- name ends with b
WHERE last_name LIKE '%b'
-- name has 3 characters between y and b
WHERE last_name LIKE 'b___y'
-- name containes 'field' anywhere
WHERE last_name LIKE '%field%'

-- % means any number of characters
-- _ means a single character
-- not case sensitive
```

-
