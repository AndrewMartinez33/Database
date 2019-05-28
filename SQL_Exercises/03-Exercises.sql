
-- All exercises use the TSQLV4 sample database

-- 1 
-- Write a query that returns all orders placed on the last day of
-- activity that can be found in the Orders table
-- Tables involved: TSQLV4 database, Orders table
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders AS O
WHERE orderdate = (
	  SELECT MAX(orderdate)
FROM Sales.Orders);

-- 2 (Optional, Advanced)
-- Write a query that returns all orders placed
-- by the customer(s) who placed the highest number of orders
-- * Note: there may be more than one customer
--   with the same number of orders
-- Tables involved: TSQLV4 database, Orders table
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders
WHERE custid IN
  (SELECT TOP (1) WITH TIES
  O.custid
FROM Sales.Orders AS O
GROUP BY O.custid
ORDER BY COUNT(*) DESC);

-- 3
-- Write a query that returns employees
-- who did not place orders on or after May 1st, 2016
-- Tables involved: TSQLV4 database, Employees and Orders tables
SELECT empid, lastname, firstname
FROM HR.Employees
WHERE empid NOT IN (SELECT DISTINCT empid
FROM Sales.Orders
WHERE orderdate >= '20160501');

-- 4
-- Write a query that returns
-- countries where there are customers but not employees
-- Tables involved: TSQLV4 database, Customers and Employees tables
SELECT DISTINCT C.country
FROM Sales.Customers AS C
WHERE country NOT IN 
  (SELECT DISTINCT E.country
FROM HR.Employees AS E
);

-- 5
-- Write a query that returns for each customer
-- all orders placed on the customer's last day of activity
-- Tables involved: TSQLV4 database, Orders table
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderdate =
  (SELECT MAX(O2.orderdate)
FROM Sales.Orders AS O2
WHERE O2.custid = O1.custid)
ORDER BY custid;

-- 6
-- Write a query that returns customers
-- who placed orders in 2015 but not in 2016
-- Tables involved: TSQLV4 database, Customers and Orders tables
SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS 
(SELECT *
  FROM Sales.Orders AS O
  WHERE C.custid = O.custid
    AND YEAR(O.orderdate) = 2015)
  AND NOT EXISTS
(SELECT *
  FROM Sales.Orders AS O2
  WHERE C.custid = O2.custid
    AND YEAR(O2.orderdate) = 2016);

-- 7 (Optional, Advanced)
-- Write a query that returns customers
-- who ordered product 12
-- Tables involved: TSQLV4 database,
-- Customers, Orders and OrderDetails tables
SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS
(SELECT *
FROM Sales.Orders AS O
WHERE C.custid = O.custid
  AND EXISTS
(SELECT *
  FROM Sales.OrderDetails AS OD
  WHERE O.orderid = OD.orderid
    AND OD.productid =12
));

-- 8 (Optional, Advanced)
-- Write a query that calculates a running total qty
-- for each customer and month using subqueries
-- Tables involved: TSQLV4 database, Sales.CustOrders view
SELECT custid, ordermonth, qty,
  (SELECT SUM(O2.qty)
  FROM Sales.CustOrders AS O2
  WHERE O2.custid = O1.custid
    AND O2.ordermonth <= O1.ordermonth) AS runqty
FROM Sales.CustOrders AS O1
ORDER BY custid, ordermonth;

-- 9
-- Explain the difference between IN and EXISTS

-- EXPLANATION
-- The IN predicate uses three-valued logic, 
-- The EXISTS predicate uses two-valued logic. 
-- When no NULLs are involved in the data,
-- IN and EXISTS give you the same meaning in both their positive
-- and negative forms (with NOT). 
-- When NULLs are involved, IN and EXISTS give you the same meaning in their positive form, but not in their negative form. 
-- In the positive form, when looking for a value that
-- appears in the set of known values in the subquery both return TRUE,
-- and when looking for a value that doesn’t appear in the set of known values
-- both return FALSE. In the negative forms (with NOT), when looking for
-- a value that appears in the set of known values both return FALSE; 
-- however, when looking for a value that doesn’t appear in the set of 
-- known values NOT IN returns UNKNOWN (outer row is discarded), 
-- whereas NOT EXISTS returns TRUE (outer row returned).

-- 10 (Optional, Advanced)
-- Write a query that returns for each order the number of days that past
-- since the same customer’s previous order. To determine recency among orders,
-- use orderdate as the primary sort element and orderid as the tiebreaker.
-- Tables involved: TSQLV4 database, Sales.Orders table

-- Step 1: get previous order date
SELECT custid, orderdate, orderid,
  (SELECT TOP (1)
    O2.orderdate
  FROM Sales.Orders AS O2
  WHERE O2.custid = O1.custid
    AND (    O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid
    OR O2.orderdate < O1.orderdate )
  ORDER BY O2.orderdate DESC, O2.orderid DESC) AS prevdate
FROM Sales.Orders AS O1
ORDER BY custid, orderdate, orderid;

-- Step 2: compute the difference
SELECT custid, orderdate, orderid,
  DATEDIFF(day,
    (SELECT TOP (1)
    O2.orderdate
  FROM Sales.Orders AS O2
  WHERE O2.custid = O1.custid
    AND (O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid
    OR O2.orderdate < O1.orderdate )
  ORDER BY O2.orderdate DESC, O2.orderid DESC),
    orderdate) AS diff
FROM Sales.Orders AS O1
ORDER BY custid, orderdate, orderid;