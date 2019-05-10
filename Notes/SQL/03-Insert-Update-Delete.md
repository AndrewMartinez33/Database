# COLUMN ATTRIBUTES

# INSERTING ROW

```sql
-- we specify the values for each column in the row, including deafult values, like auto-increment, and NUlls
INSERT INTO table_name
VALUES (DEFAULT, 'John', 'Smith', NULL, NULL, '4100 Street', 'Long Beach', 'CA', DEFAULT );


-- we can also specify which specific data we are inputing and let the database insert the default or null values
INSERT INTO table_name (
  last_name,
  first_name,
  address,
  city,
  state
)
VALUES (
  'John',
  'Smith',
  '4100 Street',
  'Long Beach',
  'CA');
```

# INSERTING MULTIPLE ROWS

```SQL
INSERT INTO table_name (column1, column2)
VALUES (value_1, value_2),
       (value_3, value_4),
       (value_5, value_6);
```

# INSERTING HIERARCHICAL ROWS

```sql
INSERT INTO table_name (
  column_ID,
  column_2,
  column_3
)
VALUES (DEFAULT, value_2, value_3),

-- LAST INSERT ID is a built in function in MYSQL
INSERT INTO table_name
VALUES (LAST_INSERT_ID(), value_2, value_3);
```

# CREATING A COPY OF A TABLE

```sql
-- NOTE: when we create a table from another table, some of the column properties, like auto-increment, are not transferred over. The primary key is not labeled either.
-- You can use the subquery to copy the whole table or a subset of the table.
CREATE TABLE new_table_name AS
SELECT * FROM table_name;

```

# UPDATING

```sql
UPDATE table_name
SET column_1 = new_value
WHERE condition = something;

```

# USING SUBQUERIES IN UPDATES

```sql
UPDATE table_name
SET column_1 = new_value
WHERE condition = (
    SELECT column_1
    FROM table_name
    WHERE condition
);

```

# DELETING ROWS

```sql
DELETE FROM table_name
WHERE 'condition or subquery';
```
