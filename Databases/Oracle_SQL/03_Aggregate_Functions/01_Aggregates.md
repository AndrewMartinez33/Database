# AGGREGATE FUNCTIONS

```sql
-- These functions only operate on non-null values
SELECT
  MAX(invoice_total) AS highest,   -- highest in the column
  MIN(invoice_total) AS lowest,    -- lowest in the column
  AVG(invoice_total) AS average,   -- average of the whole column
  SUM(invoice_total) AS total,     -- total of the whole column
  COUNT(payments) AS total_count,  -- this will not include a count of the records with nulls in the column
  COUNT(*) AS total_records        -- to get a count of all records, including null, use *
FROM invoices;

```

# GROUP BY

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

# HAVING

```sql
-- if we want to filter our rows we would normally use the WHERE clause.
-- but the WHERE clause comes before the GROUP BY clause, therefore we cannot filter rows after we have grouped them with GROUP BY
-- when we want to filter grouped rows, we need to use the HAVING clause
SELECT
  client_id,
  SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
-- The GROUP BY clause is always always the WHERE clause and before the ORDER BY clause.
-- You can also group by multiple columns
GROUP BY client_id
-- we use HAVING instead of WHERE
-- IMPORTANT: the columns we use in the HAVING clause must be a part of the SELECT statement
HAVING total_sales > 2000
ORDER BY total_sales DESC

```
