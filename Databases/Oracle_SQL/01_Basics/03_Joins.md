# Section 4: Joining tables

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- FULL OUTER
- CROSS JOIN
- Self-join

# INNER JOINS

Join columns from multiple tables

```sql
-- because customer id is in both tables, we need to prefix customer_id with the specific table
SELECT order_id, o.customer_id, first_name, last_name
-- we can simplify our code by giving our tables aliases, in this case o and c
FROM orders o
-- the INNER keyword is optional
INNER JOIN customers c
  ON o.customer_id = c.customer_id;
```

# JOINING ACROSS DATABASES

When we need to join tables from different tables, we use the database name as the prefix for the table name. You only have to prefix the tables that are not a part of the current database.

```sql
SELECT column1, alias2.column2
FROM  table_name alias1
JOIN  db_name.table_name alias2
  ON  alias1.column1 = alias2.column2;


-- EXAMPLE
SELECT *
FROM order_items oi
JOIN sql_inventory.products p
  ON oi.product_id = p.product_id;
```

# SELF JOINS

Sometimes all the information we need is on one table. For example, we have an employees table with employee id's and a column reports_to. reports_to is each individual employee's manager's id. We can join the employees table with itself to find the name of each manager.

```sql
SELECT
  e.employee_id,
  e.first_name,
  m.first_name AS manager
FROM employees e
JOIN employees m
  ON e.reports_to = m.employee_id;

```

# JOINING MULTIPLE TABLES

```sql
SELECT
  o.order_id,
  o.order_date,
  c.first_name,
  c.last_name,
  os.name AS status
FROM orders o
JOIN customers c
  ON o.customer_id = c.customer_id
JOIN order_statuses os
  ON o.status = os.order_status_id;

```

# COMPOUND JOIN CONDITIONS

A compound join condition is when we have multiple conditions to join tables. For example, If we have a table that has a composite primary key, we cannot join on a single column because the values may be duplicated. Instead, we join on the multiple columns that make up the composite primary key.

```sql
SELECT *
FROM order_items oi
JOIN order_item_notes oin
  ON oi.order_id = oin.order_id
  AND oi.product_id = oin.product_id;

```

# IMPLICIT JOIN SYNTAX

When we write joins with the JOIN keyword we are using explicit syntax. But there is another way to write joins, implicit syntax.

```sql
-- when using implicit syntax, be sure to use the WHERE clause. Otherwise, you will be creating a cross join.
SELECT
-- the join happens in the from clause
FROM table1 T1, table2 T2
WHERE t1.customer_id = T2.customer_id;

```

# OUTER JOINS

In SQL there are two types of JOINS, INNER and OUTER.

OUTER JOINS solve a specific problem. Lets say you have a Customers table and an Orders table and you want to see a list of all your customer and their orders.

```sql
-- we can use an inner join to get a list of customers and their orders
SELECT
  c.customer_id,
  c.first_name,
  o.order_id
FROM order o
JOIN customers c
  ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

-- the problem here is that if a customer has no order in the system they would not be included in the results. This is because they do no meet the ON condition.
-- we can use OUTER joins to solve this
```

# LEFT OUTER JOIN

Returns all the records in the left table, regardless if they meet the condition

```sql
SELECT
  c.customer_id,
  c.first_name,
  o.order_id
FROM order o
-- the outer keyword is optional
LEFT OUTER JOIN customers c
  ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

```

# RIGHT OUTER JOIN

Returns all the records in the right table, regardless if they meet the condition.

```sql
SELECT
  c.customer_id,
  c.first_name,
  o.order_id
FROM order o
-- the outer keyword is optional
RIGHT JOIN customers c
  ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
```

# OUTER JOIN BETWEEN MULTIPLE TABLES

```sql
SELECT
  c.customer_id,
  c.first_name,
  o.order_id,
  sh.name AS shipper
FROM customers c
LEFT JOIN orders o
  ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
  ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id;
```

# SELF OUTER JOINS

Return every employee and their managers, but also include employees that don't have a manager.

```sql
SELECT
  e.employee_id,
  e.first_name,
  m.first_name AS manager
FROM employees e
LEFT JOIN employees m
  ON e.reports_to = m.employee_id

```

# THE USING CLAUSE

We can shorten the ON clause syntax with the USING syntax if the columns have the same name

```sql
SELECT
  o.order_id,
  c.first_name
FROM orders o
JOIN customers c
-- this is the same as 'ON c.customer_id = o.customer_id'
  USING (customer_id)
LEFT JOIN shippers sh
-- this is the same as 'ON o.shipper_id = sh.shipper_id'
  USING (shipper_id);

-- BUT what if we have multiple join conditions
--for example
SELECT *
FROM order_items oi
JOIN order_item_notes oin
  ON oi.order_id = oin.order_id
  AND oi.product_id = oin.product_id;

-- we can still simply the join conditions with USING
SELECT *
FROM order_items oi
JOIN order_item_notes oin
-- we just separate them with a comma
  USING (order_id, product_id);

```

# NATURAL JOINS

With natural joins we do not specify on which columns to join the table. Instead, the database joins the tables based on common columns betweens the tables. This is not recommended as it can produce unexpected results.

```sql
SELECT
  o.order_id,
  c.first_name
FROM orders o
NATURAL JOIN customers c;

```

# CROSS JOINS

Combines every record from the first table is combined with every record from the second table. Cross joins can be dangerous because the results can get very large, very quickly. But they can still be useful.

For example, lets say you have a table of clothing sizes and table of clothing colors. If you want a list of all the possible combinations, you can use a cross join

```sql
SELECT *
FROM sizes_table
CROSS JOIN colors_table;

```

# UNIONS

When we use JOINS we are combining columns from different table, but we can also combine rows from different table with UNION

For example, lets say we have a table Orders and we want to return all the order with a status column. In status we want to label all orders in the current year as 'active' and all orders before the current year as 'inactive'.

```sql
-- we can use UNION to combine the results of two queries on the same table
SELECT
-- the first query determines the names of the columns
  order_id,
  order_date,
  "Active" AS status
FROM orders
WHERE order_date >= "2019-01-01"
UNION
SELECT
  order_id,
  order_date,
  "Archived" AS status
FROM orders
WHERE order_date < "2019-01-01";

```
