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

## Regular Expressions
