# What are window functions?

A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities. Behind the scenes, the window function is able to access more than just the current row of the query result.

Query processing using analytic functions takes place in three stages.

1. JOIN, WHERE, GROUP BY, and HAVING clauses are performed
2. The result set is made available to the analytic functions and all their calculations take place
3. If the query has an ORDER BY clause at its end, the ORDER BY is processed to allow for precise output ordering.

Window functions may appear in the SELECT list and ORDER BY clause, but NOT in the FROM clause, WHERE clause, GROUP BY clause, or HAVING clause

A window function is defined using the OVER() clause. There are three parts to the OVER() clause:

1. PARTITION BY
2. ORDER BY
3. FRAMING

```sql
window_function() OVER([partition_clause] [orderBy_clause] [framing_clause]);
```

## Window Ranking Functions

- RANK - The RANK() function assigns a rank to each row within the partition of a result set. The rank of a row is specified by one plus the number of ranks that come before it.
- DENSE_RANK - The DENSE_RANK() is a window function that assigns a rank to each row within a partition or result set with no gaps in ranking values.The rank of a row is increased by one from the number of distinct rank values which come before the row.
- NTILE - The NTILE analytic function allows you to break a result set into a specified number of approximately equal groups.
- ROW_NUMBER - An incrementing number unique within a partition

- the partition clause is optional
- the order by clause is mandatory

## RANK()

The RANK() function assigns a rank to each row within the partition of a result set. The rank of a row is specified by one plus the number of ranks that come before it.

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

## DENSE_RANK()

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

## NTILE FUNCTION

The NTILE analytic function allows you to break a result set into a specified number of approximately equal groups.

```sql
NTILE(expr) OVER ([ query_partition_clause ] order_by_clause)

-- EXAMPLE
-- suppose the table has 12 students
-- Here we split the rows into 4 groups, based on the name.
SELECT student_id, name,
  NTILE(4) OVER(ORDER BY name ) group
FROM class_list;
```

RESULT: since there are 12 students, they are split into four groups of 3. Each group is numbered 1-4.

```txt
id   name     group
--   ------   -----
2    Alexis    1
4    Ali       1
1    David     1
5    Ford      2
3    Khaled    2
9    Leen      2
6    Max       3
11   Mazen     3
7    Noor      3
12   Randi     4
10   Sajed     4
8    Sara      4
```

```sql
-- Adding two more students
insert into class_list values (13,'Fatima');
insert into class_list values (14,'Aya');

SELECT student_id, name,
  NTILE(4) OVER(ORDER BY name ) group
FROM class_list;
```

RESULT: We now have 14 rows. 12 rows are split equally amongst the 4 groups, but the extra rows are then added to each group one by one until there are none left.

```txt
id   name     group
--   ------   -----
2    Alexis    1
4    Ali       1
14   Aya       1  -- first extra row is added to group 1
1    David     1
13   Fatima    2  -- second extra row is added to group 2
5    Ford      2
3    Khaled    2
9    Leen      2
6    Max       3
11   Mazen     3
7    Noor      3
12   Randi     4
10   Sajed     4
8    Sara      4
```

# ROW_NUMBER

ROW_NUMBER assigns a unique number from 1-N to the rows within a partition.
At first glance this may seem similar to the RANK and DENSE_RANK analytic functions,
but the ROW_NUMBER function ignores ties and always gives a unique number to each row.

```sql
ROW_NUMBER() OVER ([ query_partition_clause ] order_by_clause)

-- EXAMPLE
select employee_id, first_name, salary,
  ROWNUMBER() OVER (order by salary desc ) r_num
from
  EMPLOYEES;
```

## Solving Real World Problems with Ranking Functions

- The Islands Problem
- First N
- Deduplication
- Gold Star

# Window Aggregate Functions

We can use supported aggregate functions as window functions as well.

```sql
-- support for the order by clause was not available prior to 2012
AggFunction(expression) OVER( [partition clause] [orderby_clause] [framing_clause]);

-- With window aggregates we can have an empty OVER clause.
-- The partition would be the entire result set
AggFunction(expression) OVER();
```

Supported aggregates:

- SUM
- AVG
- COUNT
- COUNT_BIG
- MIN
- MAX
- CHECKSUM_AGG
- STDEV
- STEVP
- VAR
- VARP

```sql
--Example
SELECT P.ProductID, P.name AS ProductName,
	C.Name AS CategoryName, ListPrice,
	COUNT(*) OVER(PARTITION BY C.ProductCategoryID) CountOfProduct,
	AVG(ListPrice) OVER(PARTITION BY C.ProductCategoryID) AS AvgListPrice,
	MIN(ListPrice) OVER() AS MinListPrice,
	MAX(ListPrice) OVER() AS MaxListPrice
FROM Production.Product AS P
JOIN Production.ProductSubcategory AS S
	ON S.ProductSubcategoryID = P.ProductSubcategoryID
JOIN Production.ProductCategory AS C
	ON C.ProductCategoryID = S.ProductCategoryID
WHERE FinishedGoodsFlag = 1;
```

# FRAMING

The frame starts with the word

- ROWS - use rows for now. Range is not fully functional yet
- RANGE - Dont use
  Then it is followed by a framing term that described which rows the frame will include
- Current Row: The row where the calculation is being performed
- Unbounded Preceding: This means that the frame starts at the first row
- Unbounded Following: This refers to the last row of the partition
- Between:
- N Preceding: A Number of rows preceding the current row
- N Following: A Number of rows following the current row

```sql
-- Examples
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING

ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING
```

# Accumulating Aggregates

Normally, you don't need the order by clause for window aggregates. For example, you don't need ordered rows to calculate an average.

But the ORDER BY clause in window aggregates allow us to calculate:

- Running Totals
- Moving Averages

And by adding a partition by, we can get a running total or moving average for each customer, for example.

```sql
AggFunction(expression) OVER( [partition clause][orderby_clause] [framing_clause]);

--EXAMPLES
--Running average
WITH Totals AS (
	SELECT MONTH(OrderDate) AS OrderMonth,
		SUM(TotalDue) AS TotalSales
	FROM Sales.SalesOrderHeader
	WHERE OrderDate >= '2012-01-01' AND OrderDate < '2013-01-01'
	GROUP BY MONTH(OrderDate)
	)
SELECT OrderMonth, TotalSales,
	AVG(TotalSales) OVER(ORDER BY OrderMonth)
		AS Average
FROM Totals;

--Calculate 3 month moving average
WITH Totals AS (
	SELECT MONTH(OrderDate) AS OrderMonth,
		SUM(TotalDue) AS TotalSales
	FROM Sales.SalesOrderHeader
	WHERE OrderDate >= '2012-01-01' AND OrderDate < '2013-01-01'
	GROUP BY MONTH(OrderDate)
	)
SELECT OrderMonth, TotalSales,
	AVG(TotalSales) OVER(ORDER BY OrderMonth
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
			AS ThreeMonthRunningAverage
FROM Totals;


--Leave out months with less than 3
WITH Totals AS (
	SELECT MONTH(OrderDate) AS OrderMonth,
		SUM(TotalDue) AS TotalSales
	FROM Sales.SalesOrderHeader
	WHERE OrderDate >= '2012-01-01' AND OrderDate < '2013-01-01'
	GROUP BY MONTH(OrderDate)
	)
SELECT OrderMonth, TotalSales,
  -- count the # of rows, if greater than two get 3 month avg, else return null
	CASE WHEN COUNT(*) OVER(ORDER BY OrderMonth
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) >2
	THEN AVG(TotalSales) OVER(ORDER BY OrderMonth
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
	ELSE NULL END AS ThreeMonthRunningAverage
FROM Totals;


--Reverse running total
SELECT CustomerID, SalesOrderID, TotalDue,
	SUM(TotalDue) OVER(PARTITION BY CustomerID
		ORDER BY SalesOrderID
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
		AS ReverseRunningTotal
FROM Sales.SalesOrderHeader
ORDER BY CustomerID, SalesOrderID;
```

# LAG & LEAD

The LAG function provides access to a row at a given offset prior to the current position.

The LEAD function provides access to a row at a given offset after the current position.

```sql
-- value_expr - Can be a column or a built-in function
-- offset - The number of rows preceeding/following the current row, from which the data is to be retrieved. The default value is 1.
-- default - The value returned if the offset is outside the scope of the window. The default value is NULL

LAG(value_expr [, offset ][, default ]) OVER ([ query_partition_clause ] order_by_clause)

LEAD(value_expr [, offset ][, default ]) OVER ([ query_partition_clause ] order_by_clause)

-- EXAMPLES
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
  LAG(HIRE_DATE) OVER ( ORDER BY HIRE_DATE ) AS prev_hire_date,
  LEAD(HIRE_DATE) OVER ( ORDER BY HIRE_DATE ) AS next_hire_date
FROM EMPLOYEES

-- Here we specify an offset of three, so we get the value 3 rows behind and the value 3 rows ahead
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
  LAG(HIRE_DATE,3) OVER ( ORDER BY HIRE_DATE ) AS prev_3_hire_date,
  LEAD(HIRE_DATE,3) OVER ( ORDER BY HIRE_DATE ) AS next_3_hire_date
FROM EMPLOYEES

-- Here we replace NULL's with the 'no data' string
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE,
  LAG(to_char(HIRE_DATE),3,'no data') OVER ( ORDER BY HIRE_DATE ) AS prev_3_hire_date,
  LEAD(to_char(HIRE_DATE),3,'no data') OVER ( ORDER BY HIRE_DATE ) AS next_3_hire_date
FROM EMPLOYEES

-- Here we partition by department id
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, DEPARTMENT_ID,
  LAG(HIRE_DATE) OVER ( partition by department_id ORDER BY HIRE_DATE ) AS prev_hire_date ,
  LEAD(HIRE_DATE) OVER ( partition by department_id ORDER BY HIRE_DATE ) AS next_hire_date
FROM EMPLOYEES
```

# FIRST_VALUE & LAST_VALUE

The FIRST_VALUE() allows you to get the first value in an ordered partition

The LAST_VALUE() allows you to obtain the last value in an ordered partition

- ORDER BY is required
- FRAMING clause is required
- The default frame is RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW

```sql
FIRST_VALUE(expression)
OVER (
    [ query_partition_clause ]
    order_by_clause
    framing_clause
    )


LAST_VALUE(expression)
OVER (
    [ query_partition_clause ]
    order_by_clause
    framing_clause
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
  FIRST_VALUE(val) OVER( ORDER BY val DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW )
FROM understand_t1
```

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
    , 2) AS percentile_rank
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
    RANK() OVER(ORDER BY salary) AS sal_rank_in_Asc ,
    PERCENT_RANK() OVER(ORDER BY salary) AS sal_PERCENT_RANK
    FROM employees
  )
WHERE sal_PERCENT_RANK >= 0.7;
```

# Cumulative Distribution

Sometimes, you want to pull the top or bottom x% values from a data set e.g., top 5% salesman by volume. To do this, you can use the CUME_DIST() function.

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
