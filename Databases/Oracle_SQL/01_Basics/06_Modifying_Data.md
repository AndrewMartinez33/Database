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

# INSERT ALL

```SQL
INSERT ALL
    INTO table_name1(col1,col2,col3) VALUES(val1,val2, val3)
    INTO table_name2(col1,col2,col3) VALUES(val4,val5, val6)
    INTO table_name3(col1,col2,col3) VALUES(val7,val8, val9)
Subquery;

-- In this statement, each value expression val1, val2, or val3 must refer to a column returned by the select list of the subquery.

-- If you want to use literal values instead of the values returned by the subquery, you use the following subquery:
SELECT * FROM dual;

-- EXAMPLE
INSERT ALL
    INTO fruits(fruit_name, color)
    VALUES ('Apple','Red')

    INTO fruits(fruit_name, color)
    VALUES ('Orange','Orange')

    INTO fruits(fruit_name, color)
    VALUES ('Banana','Yellow')
SELECT 1 FROM dual;                   -- THIS IS THE SUBQUERY
```

Conditional Oracle INSERT ALL Statement
The conditional multitable insert statement allows you to insert rows into tables based on specified conditions.

The following shows the syntax of the conditional multitable insert statement:

```SQL
-- ALL: evaluates each condition in the WHEN clauses. If a condition evaluates to true, Oracle executes the corresponding INTO clause.
-- FIRST: for each row returned by the subquery, evaluates each condition in the WHEN clause from top to bottom. If Oracle has found a condition that evaluates to true, It executes the corresponding INTO clause and skips subsequent WHEN clauses for the given row.
INSERT [ ALL | FIRST ]
    WHEN condition1 THEN
        INTO table_1 (column_list ) VALUES (value_list)
    WHEN condition2 THEN
        INTO table_2(column_list ) VALUES (value_list)
    ELSE
        INTO table_3(column_list ) VALUES (value_list)
Subquery;

-- EXAMPLE
INSERT FIRST
   WHEN amount < 1000000 THEN
      INTO small_orders
   WHEN amount >= 10000 AND amount <= 30000 THEN
      INTO medium_orders
   ELSE
      INTO big_orders
  SELECT order_id,        -- THIS IS THE SUBQUERY
         customer_id,
         (quantity * unit_price) amount
  FROM orders
  INNER JOIN order_items USING(order_id);
```

## Oracle INSERT ALL restrictions

The Oracle multitable insert statement is subject to the following main restrictions:

- It can be used to insert data into tables only, not views or materialized view.
- It cannot be used to insert data into remote tables.
- The sum of the columns in all the INSERT INTO clauses must not exceed 999.
- A table collection expression cannot be used in a multitable insert statement.
- The subquery of the multitable insert statement cannot use a sequence.

# CREATING A COPY OF A TABLE

```sql
-- NOTE: when we create a table from another table, some of the column properties, like auto-increment, are not transferred over. The primary key is not labeled either.
-- You can use the subquery to copy the whole table or a subset of the table.
CREATE TABLE new_table_name AS
SELECT * FROM table_name;

```

# CREATE AN EMPTY COPY OF A TABLE

```SQL
CREATE TABLE sales_2017
AS SELECT
    *
FROM
    sales
WHERE
    1 = 0;

-- The condition in the WHERE clause ensures that the data from the sales table is not copied to the sales_2017 table.

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

# MERGE

Introduction to the Oracle MERGE statement
The Oracle MERGE statement selects data from one or more source tables and updates or inserts it into a target table. The MERGE statement allows you to specify a condition to determine whether to update data from or insert data into the target table.

```SQL
MERGE INTO target_table
USING source_table
ON search_condition
    WHEN MATCHED THEN
        UPDATE SET col1 = value1, col2 = value2,...
        WHERE <update_condition>
        [DELETE WHERE <delete_condition>]
    WHEN NOT MATCHED THEN
        INSERT (col1,col2,...)
        values(value1,value2,...)
        WHERE <insert_condition>;
```

-
