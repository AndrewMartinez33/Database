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

# Sorting Data: ORDER BY

```sql
SELECT
    select_list
FROM
    table_name
ORDER BY
    [column_name | expression] [ASC | DESC ]

-- example
SELECT
    firstname,
    lastname
FROM
    sales.customers
ORDER BY
    first_name DESC;

-- example
SELECT
    first_name,
    last_name
FROM
    sales.customers
ORDER BY
    LEN(first_name) DESC;
```

## Limiting Rows with OFFSET and FETCH

The OFFSET and FETCH clauses are the options of the ORDER BY clause. They allow you to limit the number of rows to be returned by a query.

The OFFSET and FETCH clauses are preferable for implementing the query paging solution than the TOP clause.

```sql
ORDER BY column_list [ASC |DESC]
-- offset is mandatory
OFFSET offset_row_count {ROW | ROWS}
-- fetch is optional
FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY

-- Skip the first ten products and return the rest
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name
OFFSET 10 ROWS;

-- skip the first 10 and return the next 10
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price,
    product_name
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

-- top 10 most expensive products
SELECT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC,
    product_name
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY;
```

## Limiting Rows with SELECT TOP

The SELECT TOP clause allows you to limit the number of rows or percentage of rows returned in a query result set.

- Because the order of rows stored in a table is unpredictable, the SELECT TOP statement is always used in conjunction with the ORDER BY clause.

```sql
SELECT TOP (expression) [PERCENT]
    [WITH TIES]
FROM
    table_name
ORDER BY
    column_name;

-- example
SELECT TOP 10
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;

-- example
SELECT TOP 1 PERCENT
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;

-- example
SELECT TOP 3 WITH TIES
    product_name,
    list_price
FROM
    production.products
ORDER BY
    list_price DESC;
```

# Filtering Data

```sql
-- DISTINCT
-- return distinct values
SELECT DISTINCT column_name
FROM schema.table_name;
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

# Joins

## INNER JOIN (default) : ALL MATCHES FROM BOTH TABLES

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
INNER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## LEFT OUTER JOIN : ALL VALUES FROM LEFT WITH MATCHES FROM RIGHT (NON MATCHES WILL BE DISPLAYED AS NULL)

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
LEFT OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## RIGHT OUTER JOIN : ALL RECORDS IN THE RIGHT TABLE WITH MATCHES FROM LEFT. NULL FOR NON MATCH

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
RIGHT OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## FULL OUTER JOIN : ALL THE ROWS IN BOTH TABLES. IF NO MATCH THEN NULL.

```sql
SELECT p.Name, pr.ProductReviewID, pr.Comments
FROM Production.Product p
FULL OUTER JOIN Production.ProductReview pr
ON p.ProductID = pr.ProductID;
GO
```

## CROSS JOIN : ALL RECORDS FROM RIGHT WITH ALL RECORDS FROM LEFT. LARGE RESULTS

```sql
SELECT
 select_list
FROM
 T1
CROSS JOIN T2;
```

## SELF JOIN : ALL RECORDS MATCHED WITH OTHER RECORDS FROM THE SAME TABLE.

```sql
SELECT
    select_list
FROM
    T1
[INNER | LEFT]  JOIN T2 ON
    join_predicate;

-- example
SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;
```

# Grouping Data

## GROUP BY

```sql
SELECT
  client_id,
  SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
-- The GROUP BY clause is always always the WHERE clause and before the ORDER BY clause.
-- You can also group by multiple columns
-- RULE of THUMB: when you have a SUM function in the SELECT statement, you should GROUP BY all the columns in the SELECT statement
GROUP BY client_id
ORDER BY total_sales DESC
```

## HAVING

```sql
-- if we want to filter our rows we would normally use the WHERE clause.
-- but the WHERE clause comes before the GROUP BY clause, therefore we cannot filter rows after we have grouped them with GROUP BY
-- when we want to filter grouped rows, we need to use the HAVING clause
SELECT
  client_id,
  SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
-- The GROUP BY clause is always after the WHERE clause and before the ORDER BY clause.
-- You can also group by multiple columns
GROUP BY client_id
-- we use HAVING instead of WHERE
-- IMPORTANT: the columns we use in the HAVING clause must be a part of the SELECT statement
HAVING total_sales > 2000
ORDER BY total_sales DESC
```

## Aggregations with Grouping Sets

Imagine you have an orders table, and you want to perform T-SQL query aggregations across multiple groups. In the context of the Sales.SalesOrderHeader table of the AdventureWorks2012 database, these groupings can be something like the following:

- A grouping across “everything”
- GROUP BY SalesPersonID, YEAR(OrderDate)
- GROUP BY CustomerID, YEAR(OrderDate)
- GROUP BY CustomerID, SalesPersonID, YEAR(OrderDate)

When you want to perform these individual groupings with a traditional T-SQL query, you need multiple statements, where you perform a UNION ALL between the individual result sets. Let’s have a look at such a query:

```sql
SELECT * FROM
(
	-- 1st Grouping Set
	SELECT
		NULL AS 'CustomerID',
		NULL AS 'SalesPersonID',
		NULL AS 'OrderYear',
		SUM(TotalDue) AS 'TotalDue'
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL

	UNION ALL

	-- 2nd Grouping Set
	SELECT
		NULL AS 'CustomerID',
		SalesPersonID,
		YEAR(OrderDate) AS 'OrderYear',
		SUM(TotalDue) AS 'TotalDue'
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID, YEAR(OrderDate)

	UNION ALL

	-- 3rd Grouping Set
	SELECT
		CustomerID,
		NULL AS 'SalesPersonID',
		YEAR(OrderDate) AS 'OrderYear',
		SUM(TotalDue) AS 'TotalDue'
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY CustomerID, YEAR(OrderDate)

	UNION ALL

	-- 4th Grouping Set
	SELECT
		CustomerID,
		SalesPersonID,
		YEAR(OrderDate) AS 'OrderYear',
		SUM(TotalDue) AS 'TotalDue'
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY CustomerID, SalesPersonID, YEAR(OrderDate)
) AS t
ORDER BY CustomerID, SalesPersonID, OrderYear
GO
```

The approach used by this T-SQL statement has multiple disadvantages:

- The T-SQL statement itself is huge, because every individual group is one distinct query.
- The table Sales.SalesOrderHeader has to be accessed 4 times – once for every distinct query.
- When you look at the execution plan, you can see that SQL Server performs an Index Seek (NonClustered) operation 4 times – once for every query.

You can dramatically simplify the T-SQL code that you need, if you use the grouping sets functionality introduced back in SQL Server 2008. The following code shows you the same query, but this time implemented with grouping sets.

```sql
SELECT
	CustomerID,
	SalesPersonID,
	YEAR(OrderDate) AS 'OrderYear',
	SUM(TotalDue) AS 'TotalDue'
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY GROUPING SETS
(
	-- Our 4 different grouping sets
	(CustomerID, SalesPersonID, YEAR(OrderDate)),
	(CustomerID, YEAR(OrderDate)),
	(SalesPersonID, YEAR(OrderDate)),
	()
)
GO
```

As you can see from the code itself, you just specify the needed grouping sets inside the GROUP BY GROUPING SETS clause – everything else is performed transparently by SQL Server. The empty parentheses specify the so-called Empty Grouping Set, the aggregation across the whole table. When you also look at the output of STATISTICS IO, you can see that the table Sales.SalesOrderHeader was accessed only once! That’s a huge difference from the previous manual implementation that we have performed.

## Grouping Sets: Cube Subclause

With Grouping Sets it is very easy to perform individual groupings by simply defining the necessary grouping sets. But what if you want to have all possible groups from a given set of columns – the so-called Power Set? Of course, you can generate the power set manually with the syntax of the grouping set functionality, but that’s still a lot of code to write.

With the CUBE subclause you can generate all possible grouping sets for a given set of columns. This is the so-called Power Set. When you have the 3 columns a, b, and c, CUBE (a, b, c) produces the following groupings for you:

- (a, b, c)
- (a, b)
- (a, c)
- (b, c)
- (a)
- (b)
- (c)
- ()

### Example without CUBE

```sql
-- Calculates the power set of CustomerID, SalesPersonID, YEAR(OrderDate)
SELECT
	CustomerID,
	SalesPersonID,
	YEAR(OrderDate) AS 'OrderYear',
	SUM(TotalDue) AS 'TotalDue'
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY GROUPING SETS
(
	(CustomerID, SalesPersonID, YEAR(OrderDate)),
	(CustomerID, SalesPersonID),
	(CustomerID, YEAR(OrderDate)),
	(SalesPersonID, YEAR(OrderDate)),
	(CustomerID),
	(SalesPersonID),
	(YEAR(OrderDate)),
	()
)
GO
```

### Example with CUBE

```sql
-- Calculates the power set of CustomerID, SalesPersonID, YEAR(OrderDate) with the CUBE subclause
SELECT
	CustomerID,
	SalesPersonID,
	YEAR(OrderDate) AS 'OrderYear',
	SUM(TotalDue) AS 'TotalDue'
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY CUBE(CustomerID, SalesPersonID, YEAR(OrderDate))
GO
```

## Grouping Sets: Rollup Subclause

With the ROLLUP subclause you are able to define a subset of the power set. The ROLLUP subclause also assumes a hierarchy between the individual columns. Imagine that we have again our 3 columns a, b, and c. When you use ROLLUP(a, b, c), it produces the following grouping sets:

- (a, b, c)
- (a, b)
- (a)
- ()

You can very easily see from these individual grouping sets that there is a hierarchy between these columns. Just substitute the columns a, b, and c with columns like OrderYear, OrderMonth, and OrderDate, and you will get the idea of the kind of analytical queries you can perform here.

```sql
-- Calculates the following grouping sets:
-- => (OrderYear, OrderMonth, OrderDay)
-- => (OrderYear, OrderMonth)
-- => (OrderYear)
-- => ()
SELECT
	YEAR(OrderDate) AS 'OrderYear',
	MONTH(OrderDate) AS 'OrderMonth',
	DAY(OrderDate) AS 'OrderDay',
	SUM(TotalDue) AS 'TotalDue'
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY ROLLUP(YEAR(OrderDate), MONTH(OrderDate), DAY(OrderDate))
GO
```

The output of that query gives you the following individual grouping sets:

- (OrderYear, OrderMonth, OrderDay)
- (OrderYear, OrderMonth)
- (OrderYear)
- ()

# Subqueries

A select statement within a select statement

```sql
SELECT *
FROM PRODUCTS
WHERE unit_price > (
  SELECT unit_price
  FROM products
  WHERE product_id = 3
);

```

## The IN Operator

we can use the IN operator to compare a value to values IN a list

we can combine the IN operator with the NOT operator to check for items NOT in the specified list

```sql
SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM order_items
);

```

## Subqueries vs JOINS

Often, subqueries can be rewritten as JOINS. Two things to keep in mind when deciding whether to use a subquery or a JOIN is readability and performance.

```sql
SELECT *
FROM clients
WHERE client_id NOT IN (
  SELECT DISTINCT client_id
  FROM invoices
);

--rewritten as a JOIN
SELECT *
FROM clients
LEFT JOIN invoices USING(client_id)
WHERE invoice_id IS NULL;

```

## The ALL Keyword

the condition must be met against ALL the values in a list

```sql
SELECT *
FROM invoices
-- invoice_total must be greater than all the values in the subquery
WHERE invoice_total > ALL (
  SELECT invoice_total
  FROM invoices
  WHERE client_id = 3
)


```

## The ANY Keyword

the condition my be met against any one of the values in a list

```sql
SELECT *
FROM invoices
-- invoice_total must be greater than at least one of the values in the subquery
WHERE invoice_total > ANY (
  SELECT invoice_total
  FROM invoices
  WHERE client_id = 3
)

```

## Correlated Subqueries

A correlated subquery is when you reference the outer query inside of the subquery. When we use a correlated subquery, the subquery is executed for each record

In non-correlated subqueries the subquery runs only once and the result is returned.

```sql
SELECT *
FROM employees e
-- the subquery is executed for each record.
WHERE salary > (
  -- this subquery calculates the average salary for all employees in the same office
  SELECT AVG(salary)
  FROM employees
  -- here we reference alias (e) from the outer query
  WHERE office_id = e.office_id
)

```

## The EXISTS Operator

```sql
-- Select clients that have an invoice

-- this problem can be solved with the subquery below, BUT imagine if you have hundreds of thousands or millions of
-- customers with invoices. This subquery will return a very large list and will impact performance.
SELECT *
FROM clients
WHERE client_id IN (
  SELECT DISTINCT client_id
  FROM invoices
)

-- Instead, we can use a correlated subquery and the EXISTS operator. Here, as we run through each record in the outer query,
-- the subquery is executed each time
SELECT *
FROM clients c
-- EXISTS returns true if any rows in the outer query return the search condition in the subquery, returns false otherwise
WHERE EXISTS (
  SELECT client_id
  FROM invoices
  -- when the dbms finds a row where the client_id matches the client id of the outer query, it stops and returns true.
  -- this is similar to nested loops in programming. when a condition is met, we break out of the inner loop.
  WHERE client_id = c.client_id
)
```

## Subqueries in the SELECT clause

```sql
SELECT
  invoice_id,
  invoice_total,
  (SELECT AVG(invoice_total) FROM invoices) AS average
FROM invoices;
```

## Subqueries in the FROM clause

```sql
SELECT *
FROM (
  SELECT
    invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total) FROM invoices) AS average
  FROM invoices
-- IMPORTANT: when we use a subquery in the FROM clause, we MUST give it an alias
) AS sales

```

# Set Operators

## Rules on Set Operations:

- The results sets of each query must have the same number of columns and the same corresponding data types
- In order to sort the result, an ORDER BY is used in the last query.
- The column names or aliases for the result set are created in the first (top) query

Four Set Operators:

1. UNION - Combines two tables into a single set, without duplicates.
2. UNION ALL - Combines two tables into a single set, including all duplicates.
3. INTERSECT - Returns rows that are found in both tables
4. EXCEPT - Returns all rows found in table 1, but not in table 2

```sql
query_1 AS One
UNION
query_2
Order By One;


query_1
UNION ALL
query_2;


query_1
INTERSECT
query_2;


query_1
EXCEPT
query_2
```

# Aggregate Functions

```sql
AVG ()	-- The AVG() aggregate function calculates the average of non-NULL values in a set.
CHECKSUM_AGG()	-- The CHECKSUM_AGG() function calculates a checksum value based on a group of rows.
COUNT()	-- The COUNT() aggregate function returns the number of rows in a group, including rows with NULL values.
COUNT_BIG()	-- The COUNT_BIG() aggregate function returns the number of rows (with BIGINT data type) in a group, including rows with NULL values.
MAX()	-- The MAX() aggregate function returns the highest value (maximum) in a set of non-NULL values.
MIN()	-- The MIN() aggregate function returns the lowest value (minimum) in a set of non-NULL values.
STDEV()	-- The STDEV() function returns the statistical standard deviation of all values provided in the expression based on a sample of the data population.
STDEVP()	-- The STDEVP() function also returns the standard deviation for all values in the provided expression, but does so based on the entire data population.
SUM()	-- The SUM() aggregate function returns the summation of all non-NULL values a set.
VAR()	-- The VAR() function returns the statistical variance of values in an expression based on a sample of the specified population.
VARP()	-- The VARP() function returns the statistical variance of values in an expression but does so based on the entire data population.
```

# Dealing with NULLs

# Expressions

CASE
COALESCE
NULLIF

# Date Functions

LOOK AT PLURALSIGHT COURSE INTRO TO DATES AND TIMES IN SQL SERVER

## Returning the current date and time

```sql
CURRENT_TIMESTAMP	-- Returns the current system date and time without the time zone part.
GETUTCDATE	-- Returns a date part of a date as an integer number.
GETDATE	-- Returns the current system date and time of the operating system on which the SQL Server is running.
SYSDATETIME	-- Returns the current system date and time with more fractional seconds precision than the GETDATE() function.
SYSUTCDATETIME	-- Returns the current system date and time in UTC time
SYSDATETIMEOFFSET	-- Returns the current system date and time with the time zone.
```

## Returning the date and time Parts

```sql
DATENAME	-- Returns a date part of a date as a character string
DATEPART	-- Returns a date part of a date as an integer number
DAY	-- Returns the day of a specified date as an integer
MONTH	-- Returns the month of a specified date as an integer
YEAR	-- Returns the year of the date as an integer.
```

## Returning a difference between two dates

```sql
DATEDIFF	-- Returns a difference in date part between two dates.
```

## Modifying dates

```sql
DATEADD	-- Adds a value to a date part of a date and return the new date value.
EOMONTH	-- Returns the last day of the month containing the specified date, with an optional offset.
SWITCHOFFSET	-- Changes the time zone offset of a DATETIMEOFFSET value and preserves the UTC value.
TODATETIMEOFFSET	-- Transforms a DATETIME2 value into a DATETIMEOFFSET value.
```

## Constructing date and time from their parts

```sql
DATEFROMPARTS	-- Return a DATE value from the year, month, and day.
DATETIME2FROMPARTS	-- Returns a DATETIME2 value from the date and time arguments
DATETIMEOFFSETFROMPARTS	-- Returns a DATETIMEOFFSET value from the date and time arguments
TIMEFROMPARTS	-- Returns a TIME value from the time parts with the precisions
```

## Validating date and time values

```sql
ISDATE	-- Check if a value is a valid date, time, or datetime value
```

# String Functions

```sql
ASCII()	-- Return the ASCII code value of a character
CHAR()	-- Convert an ASCII value to a character
CHARINDEX()	-- Search for a substring inside a string starting from a specified location and return the position of the substring.
CONCAT()	-- Join two or more strings into one string
CONCAT_WS()	-- Concatenate multiple strings with a separator into a single string
DIFFERENCE()	-- Compare the SOUNDEX() values of two strings
FORMAT()	-- Return a value formatted with the specified format and optional culture
LEFT()	-- Extract a given a number of characters from a character string starting from the left
LEN()	-- Return a number of characters of a character string
LOWER()	-- Convert a string to lowercase
LTRIM()	-- Return a new string from a specified string after removing all leading blanks
NCHAR()	-- Return the Unicode character with the specified integer code, as defined by the Unicode standard
PATINDEX()	-- Returns the starting position of the first occurrence of a pattern in a string.
QUOTENAME()	-- Returns a Unicode string with the delimiters added to make the input string a valid delimited identifier
REPLACE()	-- Replace all occurrences of a substring, within a string, with another substring
REPLICATE()	-- Return a string repeated a specified number of times
REVERSE()	-- Return the reverse order of a character string
RIGHT()	-- Extract a given a number of characters from a character string starting from the right
RTRIM()	-- Return a new string from a specified string after removing all trailing blanks
SOUNDEX()	-- Return a four-character (SOUNDEX) code of a string based on how it is spoken
SPACE()	-- Returns a string of repeated spaces.
STR()	-- Returns character data converted from numeric data.
STRING_AGG()	-- Concatenate rows of strings with a specified separator into a new string
STRING_ESCAPE()	-- Escapes special characters in a string and returns a new string with escaped characters
STRING_SPLIT()	-- A table-valued function that splits a string into rows of substrings based on a specified separator.
STUFF()	-- Delete a part of a string and then insert another substring into the string starting at a specified position.
SUBSTRING()	-- Extract a substring within a string starting from a specified location with a specified length
TRANSLATE()	-- Replace several single-characters, one-to-one translation in one operation.
TRIM()	-- Return a new string from a specified string after removing all leading and trailing blanks
UNICODE()	-- Returns the integer value, as defined by the Unicode standard, of a character.
UPPER()	-- Convert a string to uppercase
```

# System Functions

```sql
CAST -- cast a value of one type to another.
CONVERT -- convert a value of one type to another.
CHOOSE -- return one of the two values based on the result of the first argument.
ISNULL -- replace NULL with a specified value.
ISNUMERIC -- check if an expression is a valid numeric type.
IIF -- add if-else logic to a query.
TRY_CAST -- cast a value of one type to another and return NULL if the cast fails.
TRY_CONVERT -- convert a value of one type to another and return the value to be translated into the specified type. It returns NULL if the cast fails.
TRY_PARSE -- convert a string to a date/time or a number and return NULL if the conversion fails.
CONVERT datetime to string -- show you how to convert a datetime value to a string in a specified format.
CONVERT string to datetime -- describe how to convert a string to a datetime value.
CONVERT datetime to date -- convert a datetime to a date.
```

# Common Table Expressions

A CTE, really, is a temporary table that exists only within the scope of some executing DML statement, such as a select, an insert, or an update.

- The CTE only lasts for the duration of the query, which means it exists in memory only, and not in the database as an object that you could reference later.
- CTEs do have the ability to reference themselves in a query, and you'll find the common uses for CTEs such as creating recursive queries, in other words, the query is calling itself, it can be a temporary view, in the event that you don't want to create or store a view in your database.
- They can also reference the result set multiple times in the same statement.
- Typically, you'll find them used to simplify complex queries by allowing you to divide the complexity into smaller segments that are easier to understand and write.
- CTEs can also exist in functions, store procedures, triggers, and views.

```sql
-- Define the CTE expression name and column list.
-- Here we are naming our CTE as Sales_CTE and we are
-- defining the column names it will use when referenced in a query later.

WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
-- This is the query that generates the structure of the CTE
-- and returns the data values that will be contained in the CTE.
(
    SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
-- Now that the inner query has been created, we can define the CTE outer query that will use the result set from the previous query.
-- Note that the previous query can execute by itself, but this query will generate an error if you execute it alone, demonstrating that the CTE only exists in the scope of the entire query operation
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;
GO
```

## Aliasing CTE Columns

```sql
-- inline form
WITH CTE_Name AS
(
  SELECT COL1 AS One,
         COL2 AS Two
  FROM Table1 AS t1
)
SELECT
...;

-- external form
WITH CTE_Name (One, Two) AS
(
  SELECT COL1, COL2
  FROM Table1 AS t1
)
SELECT
...;
```

## Defining Multiple CTE's

```sql
WITH CTE_One AS
(
  SELECT COL1 AS One,
         COL2 AS Two
  FROM Table1 AS t1
),
CTE_Two AS
(
  SELECT COL1 AS One,
         COL2 AS Two
  FROM CTE_One  -- We use CTE_One to create a new CTE
)
SELECT COL1, COL2
FROM CTE_Two;   -- We query against CTE_Two
```

# Recursive CTE's

# Pivoting and Unpivoting

Pivot
Unpivot

# Views

# Indexing

# CROSS APPLY & OUTER APPLY
