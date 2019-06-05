# SUBQUERIES

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

# The IN Operator

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

# Subqueries vs JOINS

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

# The ALL Keyword

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

# The ANY Keyword

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

# Correlated Subqueries

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

# The EXISTS Operator

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

# Subqueries in the SELECT clause

```sql
SELECT
  invoice_id,
  invoice_total,
  (SELECT AVG(invoice_total) FROM invoices) AS average
FROM invoices;
```

# Subqueries in the FROM clause

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
