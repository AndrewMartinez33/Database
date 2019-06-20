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

# SELECT Statement

```sql
SELECT column_name1, column_name2
FROM table_name;
```

## ALIAS

We can use an alias to give columns better, descriptive names or to shorten the names of tables.

```sql
SELECT column_name1, column_name2 AS alias2
FROM table_name AS t1;

-- if you want to use spaces between the alias name, you must use single quotes
SELECT column_name1 AS 'Alias Name One'
FROM customers AS c;
```
