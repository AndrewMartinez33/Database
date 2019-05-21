# Data Modeling

```sql
-- 1. Understand the Requirements
      --Fully understant the business requirements by talking to the business end users, documents, databases, etc.

-- 2. Build a Conceptual Model
      -- Identify the entitities and concepts in the business and their relationship to one another.
      -- It is a visual representation of the business. We use this to communicate with the stakeholders to ensure we are on the same page.
      -- Entity Relationship Diagram or UML Diagram

-- 3. Build a Logical Model
      -- An abstract data model, independent of a database technology.
      -- More detailed than the conceptual model.
      -- Add data types
      -- Add relationship types ( one-to-one, one-to-many)

-- 4. Build a physical model
      -- An implementation of the logical model for a particular database technology.
      -- Should have the exact data types, constraints, primary keys, foreign keys, columns, tables, views, stored procedures, etc.

```

# Keys

```sql
-- PRIMARY KEY
-- Uniquely identifies each record.

-- FOREIGN KEY
-- a column in one table that references the primary key of another table.

-- Foreign Key Constraints
-- In the event that a primary key in a table changes, we want to make sure that the change is reflected in the tables that reference the primary key.
-- There are a few types of constraints that we can put on foreign keys:
    -- CASCADE   - automatically updates the records in the child tables if the primary key changes
    -- RESTRICT  - rejects updates from happening
    -- SET NULL  - if the primary key changes, the foreign key is set to null. This results in a child record without a parent table, called a orphaned record.
    -- NO ACTION - same as restrict

-- We can set the foreign key constraints for ON UPDATE (when the primary key changes) or ON DELETE (when a record in the parent table is deleted.)
-- BEST practice is to set the ON DELETE constraint to NO ACTION or RESTRICT because we mostly likely want to keep those records. If we were to set the ON DELETE constraint to CASCADE, then all the records in the child table that referece the deleted records in the parent table would automatically be deleted. BUT always check the business requirements because it might not matter if those records are deleted.
```

# Normalization

```sql
-- 1NF         - Each cell should have a single value and we cannot have repeated columns
-- Link Tables - in relational databases we should only have one-to-one or one-to-many relationships.
--               if you have a many-to-many relationship then you need to create a link table.
--               For example, if you have a students table and a courses table, that is a many-to-many relationship.
--               The link table would be an enrollments table that has a one-to-many relationship with students and courses.
-- 2NF         - Every table should describe one entity, and every column in that table should describe that entity
-- 3NF         - A column in a table should NOT be derived from other columns.

```

# MySQL workbench tools

```sql
-- Forward Engineering a Model
-- Synchronizing a Model with a Database
-- Reverse Engineering a Database

```

# Creating and Dropping Databases

```sql
CREATE DATABASE IF NOT EXISTS database_name;

DROP DATABASE IF EXISTS database_name;

```

# Creating Tables

```sql
CREATE DATABASE IF NOT EXISTS database_name;
USE database_name;

CREATE TABLE IF NOT EXISTS table_name     -- we can also drop table if exists before the create table statement
(
  column_1 INT PRIMARY KEY AUTO_INCREMENT,
  column_2 VARCHAR(50) NOT NULL,
  column_3 INT NOT NULL DEFAULT 0,
  column_4 VARCHAR(255) NOT NULL UNIQUE
);

```

# Altering Tables

```sql
ALTER TABLE table_name
-- you can place the new column in a specific position using he AFTER kerword
ADD column_5 VARCHAR(50) NOT NULL AFTER column_2,
MODIFY COLUMN column_name VARCHAR(55) DEFAULT '',   -- modify a column
DROP column_name;   -- remove a column
```

# Creating Relationships

```sql
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
  order_id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  FOREIGN KEY fk_orders_customers (customer_id)
      REFERENCES customers (customer_id)
      ON UPDATE CASCADE
      ON DELETE NO ACTION
);
```

# Altering Primary and Foreign Key Constraints

```sql
ALTER TABLE table_name
  ADD PRIMARY KEY (column_name),
  DROP PRIMARY KEY,
  DROP FOREIGN KEY fk_name,
  ADD FOREIGN KEY fk_name (column_name)
      REFERENCES parent_table (column_name)
      ON UPDATE CASCADE
      ON DELETE NO ACTION;

```

# Character Sets and Collations

```sql
-- a character set is a table that maps each character to a number
-- in MySQL the default is utf8. This supports all international languages.
-- collation is set of rules that determines how the characters in a given laguage are sorted.
-- in MySQL the default collation is UTF8_general_ci. ci means case insensitive.
-- utf8 reserves a maximum of 3bytes for each character.

-- Suppose that your business will no support asian languages(3 bytes), you can change the character set to...say latin1, which uses 1 byte per character.
-- at the db level
CREATE DATABASE db_name
  CHARACTER SET latin1;

-- table level. if creating a table just add to the end.
ALTER TABLE table_name
  CHARACTER SET latin1;

-- column level
CREATE TABLE IF NOT EXISTS table_name
(
  column_1 INT PRIMARY KEY AUTO_INCREMENT,
  column_2 VARCHAR(50) CHARACTER SET latin1 NOT NULL,  -- add after the type and before the constraints
  column_3 INT NOT NULL DEFAULT 0,
  column_4 VARCHAR(255) NOT NULL UNIQUE
);


```

# Storage Engines

```sql
-- Storage engines determine how data is stored and which features are available to us.
-- In the most current version innoDB is the default storage engine
-- If your business is using an older version of MySQL and you want to update to the current storage engine, we do this at the table level
ALTER TABLE table_name
ENGINE = InnoDB;

-- but remember that changine the storage engine on a table can be an expensive operation because MySQL has to rebuild the table and the table will be inaccessible during this time.
```
