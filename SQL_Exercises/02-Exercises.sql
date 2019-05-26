-- All exercises use the TSQLV4 sample database

-- 1
-- 1-1
-- Write a query that generates 5 copies out of each employee row
-- Tables involved: TSQLV4 database, Employees 
SELECT E.empid, E.firstname, E.lastname, N.n
FROM HR.Employees AS E
	CROSS JOIN Nums AS N
WHERE N.n <= 5;

-- 1-2 (Optional, Advanced)
-- Write a query that returns a row for each employee and day 
-- in the range June 12, 2016 – June 16 2016.
-- Tables involved: TSQLV4 database, Employees and Nums tables
SELECT E.empid, CAST(CONCAT('2016-06-', N.n) AS DATE) AS dt
FROM HR.Employees AS E
  CROSS JOIN Nums AS N
WHERE N.n >= 12 AND N.n <= 16
ORDER BY empid, dt;

-- 2
-- Explain what’s wrong in the following query and provide a correct alternative
SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
FROM Sales.Customers AS C
  INNER JOIN Sales.Orders AS O
  ON Customers.custid = Orders.custid;

-- EXPLANATION
-- The prefixes for each column are incorrect because they do not match the table alias' in the FROM and INNER JOIN. 
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  INNER JOIN Sales.Orders AS O
  ON C.custid = O.custid;

-- 3
-- Return US customers, and for each customer the total number of orders 
-- and total quantities.
-- Tables involved: TSQLV4 database, Customers, Orders and OrderDetails tables
SELECT C.custid, COUNT(*) AS numorders, SUM(OD.qty) AS totalqty
FROM Sales.Customers AS C
  INNER JOIN
  Sales.Orders AS O
  ON C.custid = O.custid
  INNER JOIN
  Sales.OrderDetails AS OD ON O.orderid = OD.orderid
WHERE C.country = 'USA'
GROUP BY C.custid
ORDER BY C.custid;


-- 4
-- Return customers and their orders including customers who placed no orders
-- Tables involved: TSQLV4 database, Customers and Orders tables
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN
  Sales.Orders AS O
  ON C.custid = O.custid;

-- 5
-- Return customers who placed no orders
-- Tables involved: TSQLV4 database, Customers and Orders tables
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN
  Sales.Orders AS O
  ON C.custid = O.custid
WHERE O.orderid IS NULL;

-- 6
-- Return customers with orders placed on Feb 12, 2016 along with their orders
-- Tables involved: TSQLV4 database, Customers and Orders tables
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  INNER JOIN
  SALES.Orders AS O
  ON C.custid = O.custid
WHERE O.orderdate = '20160212';

-- 7 (Optional, Advanced)
-- Write a query that returns all customers in the output, but matches
-- them with their respective orders only if they were placed on February 12, 2016
-- Tables involved: TSQLV4 database, Customers and Orders tables
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN
  Sales.Orders AS O
  ON C.custid = O.custid
    AND O.orderdate = '20160212';



-- 8 (Optional, Advanced)
-- Explain why the following query isn’t a correct solution query for exercise 7.
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
  ON O.custid = C.custid
WHERE O.orderdate = '20160212'
  OR O.orderid IS NULL;

-- EXPLANATION
-- The Left Outer Join creates a table with all the customers and their order. 
-- If they did not place an order then the orderid and orderdate columns have a null.
-- In the WHERE clause we filter for customers who placed an order on Feb 2, 2016 OR
-- customers who have not placed an order (NULL),
-- BUT any customer who placed an order before or after Feb 2, 2016 is filtered out.
-- This is not what we want in the ouput.


-- 9 (Optional, Advanced)
-- Return all customers, and for each return a Yes/No value
-- depending on whether the customer placed an order on Feb 12, 2016
-- Tables involved: TSQLV4 database, Customers and Orders tables
SELECT DISTINCT C.custid, C.companyname,
  CASE 
    WHEN O.orderid IS NOT NULL THEN 'Yes' 
    ELSE 'No' END AS HasOrderOn20160212
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
  ON O.custid = C.custid
    AND O.orderdate = '20160212';