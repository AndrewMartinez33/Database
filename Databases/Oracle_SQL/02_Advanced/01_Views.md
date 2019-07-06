# Creating Views

So by definition, a view is a “virtual” table whose data is the result of a stored query, which is derived each time when you query against the view.

A view is a virtual table because you can use it like a table in your SQL queries. Every view has columns with data types so you can execute a query against views or manage their contents (with some restrictions) using the INSERT, UPDATE, DELETE, and MERGE statements.

Unlike a table, a view does not store any data. To be precise, a view only behaves like a table. And it is just a named query stored in the database. When you query data from a view, Oracle uses this stored query to retrieve the data from the underlying tables.

```sql
-- sometimes we have queries that we want to reuse, such as the query below. We store a VIEW of the query below and use it as a table.
SELECT
  c.client_id,
  c.name,
  SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

-- create a view object
CREATE OR REPLACE VIEW view_name AS
SELECT
  c.client_id,
  c.name,
  SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

-- now we can use this view just like any other table or query
SELECT *
FROM view_name
ORDER BY total_sales DESC;
```

# Altering or Dropping Views

If we find there there is a problem with the view we created, we need to alter the view and fix the issue. There are two ways to do this:

```sql
-- 1. Drop the view and recreate it
DROP VIEW view_name;

CREATE VIEW view_name AS
SELECT
  c.client_id,
  c.name,
  SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

-- 2. the second option is to use the REPLACE keyword. This is the preferred method.
CREATE OR REPLACE VIEW view_name AS
SELECT
  c.client_id,
  c.name,
  SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

```

# Updateable Views

```sql
-- views can be used in INSERT, UPDATE, DELETE statements only if
-- they DON'T contain the following:
    -- DISTINCT
    -- Aggregate Functions
    -- GROUP BY / HAVING
    -- UNION

UPDATE view_name
SET column_name = value
WHERE id = 1;
```

# WITH OPTION CHECK clause

```sql
-- sometimes when we modify/update rows through Views instead of tables, those rows are no longer included in the view.
-- to prevent this from happeneing we can use the WITH CHECK OPTION clause
-- WITH CHECK OPTION throws an error if we attempt to modify/update a row, through a view, in a way that will cause the row to disappear from the view.
CREATE OR REPLACE VIEW view_name AS
SELECT
  invoice_id,
  number,
  client_id,
  invoice_total,
  payment_total,
  invoice_total - payment_total AS balance,
  invoice_date,
  due_date,
  payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION

```

# Other benefits of views

```sql
-- simplifies queries
-- reduces the impact of changes. Instead of making changed to the underlying tables, we can make changes to the views instead.
-- we can use views to restrict access to data in the underlying tables.
--

```
