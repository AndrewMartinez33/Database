```sql
-- specify the database you are using
USE sql_store;

```

```sql
-- SELECT Statement
-- this is where we specify what columns we want returned
SELECT *
FROM customers;

SELECT last_name, first_name
FROM customers;

-- AS keyword
-- we can give columns better, descriptive names with an alias
SELECT points * 10 + 100 AS discount_factor
FROM customers;

-- if you want to use spaces between the alias name, you must use single quotes
SELECT points * 10 + 100 AS 'discount factor'
FROM customers;
```

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

```sql
-- REGEXP
-- regular expressions
SELECT
-- all names that have an e in it
WHERE last_name REGEXP 'e'
-- all names that start with an e
WHERE last_name REGEXP '^e'
-- all names that end with an e
WHERE last_name REGEXP 'e$'
-- names that end with e and the e is preceded by any of these [afhr]
WHERE last_name REGEXP '[afhr]e$'

-- ^ begins with
-- $ ends with
-- | logical OR
-- [abcd] contains any of the values inside the brackets
-- [a-f] contains any of the values in the range
```

```sql
-- IS NULL
-- to find the values that are null
-- all customers who don't have a phone number
SELECT *
FROM customers
WHERE phone IS NULL;

-- all customers who do have a phone number
SELECT *
FROM customers
WHERE name IS NOT NULL;
```

```sql
-- ORDER BY
-- use to sort results
SELECT last_name, first_name, points * 10 AS discount
FROM customers
-- Order by last name, default is ascending order
ORDER BY last_name;
-- descending order
ORDER BY last_name DESC;
-- order by column not in SELECT statement
ORDER BY birth_date;
-- order by alias
ORDER BY discount;
-- order by multiple columns.
ORDER BY last_name, first_name;
```

```sql
-- LIMIT
-- limit the number of records returned in a query
SELECT *
FROM customers
-- limits the first 300 records only
LIMIT 300;

-- we can use an offset with the LIMIT. This can be used for pagination
SELECT *
FROM customers
-- offset, or skip, the first 6 records and then return the 3 records after that.
LIMIT 6, 3
```
