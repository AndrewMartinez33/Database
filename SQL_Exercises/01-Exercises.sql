
-- All exercises use the TSQLV4 sample database

-- 1 
-- Return orders placed in June 2015
-- Tables involved: TSQLV4 database, Sales.Orders table
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015
  AND MONTH(orderdate) = 6;

-- 2 
-- Return orders placed on the last day of the month
-- Tables involved: Sales.Orders table
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

-- 3 
-- Return employees with last name containing the letter 'e' twice or more
-- Tables involved: HR.Employees table
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%e%e%';

-- 4 
-- Return orders with total value(qty*unitprice) greater than 10000
-- sorted by total value
-- Tables involved: Sales.OrderDetails table
SELECT orderid, SUM(unitprice * qty) AS totalvalue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(unitprice * qty) > 10000
ORDER BY totalvalue DESC;

-- 5
-- Write a query against the HR.Employees table that returns employees
-- with a last name that starts with a lower case letter.
-- Remember that the collation of the sample database
-- is case insensitive (Latin1_General_CI_AS).
-- For simplicity, you can assume that only English letters are used
-- in the employee last names.
-- Tables involved: HR.Employees table
SELECT empid, lastname
FROM HR.Employees
WHERE SUBSTRING(lastname, 1, 1) COLLATE Latin1_General_CS_AS = LOWER(SUBSTRING(lastname, 1, 1));

-- 6
-- Explain the difference between the following two queries
-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;

-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';

-- The WHERE clause in Query 1 is a row filter and the HAVING clause in Query 2 is a group filter.
-- Query 1: filters out any order since May 1, 2016 and returns the number of orders each employee processed.
-- Query 2: Groups the orders by employee, returns the number of orders processed by each employee,
--          but filters out any employees who have processed an order since May 1, 2016


-- 7 
-- Return the three ship countries with the highest average freight for orders placed in 2015
-- Tables involved: Sales.Orders table
SELECT TOP (3)
  shipcountry, AVG(freight) as avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015
GROUP BY shipcountry
ORDER BY avgfreight DESC;


-- 8 
-- Calculate row numbers for orders
-- based on order date ordering (using order id as tiebreaker)
-- for each customer separately
-- Tables involved: Sales.Orders table
SELECT custid, orderdate, orderid,
  ROW_NUMBER() OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS rownum
FROM Sales.Orders
ORDER BY custid, rownum;

-- 9
-- Figure out and return for each employee the gender based on the title of courtesy
-- Ms., Mrs. - Female, Mr. - Male, Dr. - Unknown
-- Tables involved: HR.Employees table
SELECT empid, firstname, lastname, titleofcourtesy,
  CASE titleofcourtesy
		WHEN 'Ms.' THEN 'Female'
		WHEN 'Mrs.' THEN 'Female'
		WHEN 'Mr.' THEN 'Male'
		ELSE 'Unknown'
	END AS gender
FROM HR.Employees;

-- 10
-- Return for each customer the customer ID and region
-- sort the rows in the output by region
-- having NULLs sort last (after non-NULL values)
-- Note that the default in T-SQL is that NULLs sort first
-- Tables involved: Sales.Customers table
SELECT custid, region
FROM Sales.Customers
ORDER BY 
	CASE WHEN region IS NULL THEN 1 ELSE 0 END, region;