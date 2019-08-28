# Normalization

Normalization is the process of organizing a database to reduce redundancy and improve data integrity

## First Normal Form - 1NF

- One value per table cell
- One table per set of related data
- Each row must be unique (primary key)

## Second Normal Form - 2NF

- Database must be in 1NF
- No non-key attributes should be dependent on any proper subset of the key, which means...
  - Single column primary key

## Third Normal Form - 3NF

- Database must be in 2NF
- No transative functional dependencies, which means...
  - column values should only depend upon the key

## Other Normal Forms

Most databases don't need to go past 3NF

- Boyce Codd Normal Form (3.5NF)
- Fourth Normal Form - 4NF
- Fifth Normal Form - 5NF
- Sixth Normal Form - 6NF

# Naming Conventions for Database Objects

## Do Not use @ as the first character

- This is used for variable names in T-SQL

## Do not use # as the first character

- This is used for objects in tempdb

## Avoid delimited identifiers: [My Table]

## Use a consistent style for naming objects

- CamelCase: MyTable
- Underscore Separated: my_table
- Hybrid: UN_Angency

# DATA TYPES

## String Types

- char(n)
  - Fixed width character string with n is the number of characters to store.
  - Non-Unicode data. 8,000 characters
- varchar(n)
  - Variable width character string with n is the number of characters to store.
  - Non-Unicode data. 8,000 characters
- varchar(max)
  - Variable width character string with maximum number of characters is 2GB.
  - Non-Unicode data. 1,073,741,824 characters
- text
  - Variable width character string.
  - Non-Unicode data. 2GB of text data
- nchar(n)
  - Fixed width character string with n is the number of characters to store.
  - Unicode data. 4,000 characters
- nvarchar(n)
  - Variable width character string with n is the number of characters to store.
  - Unicode data. 4,000 characters
- nvarchar(max)
  - Variable width character string with maximum number of characters is 2GB.
  - Unicode data. 536,870,912 characters
- ntext
  - Variable width character string.
  - Unicode data. 2GB of text data
- binary(n)
  - Fixed width binary string.
  - 8,000 bytes
- varbinary
  - Variable width binary string.
  - 8,000 bytes
- varbinary(max)
  - Variable width binary string.
  - 2GB
- image
  - Variable width binary string.
  - 2GB

## Numeric

- bit
  - 0, 1, or NULL
- tinyint
  - From 0 to 255
  - 1 byte
- smallint
  - From -32,768 to 32,767
  - 2 bytes
- int
  - From -2,147,483,648 to 2,147,483,647
  - 4 bytes
- bigint
  - From -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
  - 8 bytes
- decimal(p,s)
  - Fixed precision and scale numbers.
  - p defaults to 18, if not specified.
  - s defaults to 0, if not specified.
  - 5-17 bytes
- dec(p,s)
  - Fixed precision and scale numbers.
  - p defaults to 18, if not specified.
  - s defaults to 0, if not specified.
  - 5-17 bytes
- numeric(p,s)
  - Fixed precision and scale numbers.
  - p defaults to 18, if not specified.
  - s defaults to 0, if not specified.
  - 5-17 bytes
- smallmoney
  - From -214,748.3648 to 214,748.3647
  - 4 bytes
- money
  - From -922,337,203,685,477.5808 to 922,337,203,685,477.5807
  - 8 bytes
- float(n)
  - Floating point number data from -1.79E + 308 to 1.79E + 308
  - n default to 53, if not specified.
  - 4 or 8 bytes
- real
  - Equivalent to float(24)
  - 4 bytes

## Date and Time

- datetime
  - From January 1, 1753 to December 31, 9999
  - 8 bytes
- datetime2
  - From January 1, 0001 to December 31, 9999
  - 6-8 bytes
- smalldatetime
  - From January 1, 1900 to June 6, 2079
  - 4 bytes
- date
  - Store a date only.
  - From January 1, 0001 to December 31, 9999
  - 3 bytes
- time
  - Store a time only.
  - From 00:00:00.0000000 to 23:59:59.9999999
  - 3-5 bytes
- datetimeoffset
  - From January 1, 0001 to December 31, 9999.
  - Time zone offset range from -14:00 to +14:00.
  - 8-10 bytes
- timestamp
  - Stores a unique number that gets updated every time a row gets created or modified. The timestamp value is based upon an internal clock and does not correspond to real time. Each table may have only one timestamp variable.

## Other Data Types

- rowversion
  - automatically generated binary numbers
- hierarchyid
  - represents a position hierarchy
- uniqueidentifier
  - 16-byte GUID - pair with the NEWID() function
- xml
  - xml data, either typed or untyped
- spatial types
  - geometry and geography
- user-defined
  - defined using .NET languages

# SCHEMAS

Schemas are used to organize objects into logical groupings. For example, all the employee related tables are in the HR schema.

- Every object in a SQL Server database gets added to a schema.
- If a schema is not specified, the object is added to the dbo (database owner) schema
- Permissions can be assigned at the schema level

```sql
-- CREATE A NEW SCHEMA
-- here we create a new schema and give dbo authorization
CREATE SCHEMA schema_name1 AUTHORIZATION dbo;
GO

-- CREATE A TABLE UNDER THE NEW SCHEMA
CREATE TABLE schema_name1.table_name (
column1 int IDENTITY(1000,1) PRIMARY KEY,
column2 nvarchar(50) NULL,
column3 nvarchar(50) NOT NULL
);
GO

-- MOVE TABLE FROM ONE SCHEMA TO ANOTHER
CREATE SCHEMA schema_name2 AUTHORIZATION dbo;
GO

ALTER SCHEMA schema_name2 TRANSFER schema_name1.table_name;
GO

-- VIEW ALL TABLES WITHIN AND SCHEMA
USE my_database;
GO

SELECT sys.schemas.name AS SchemaName, sys.tables.name AS TableName
  FROM sys.tables
  INNER JOIN sys.schemas
  ON sys.tables.[schema_id] = sys.schemas.[schema_id];
GO

-- VIEW ALL TABLES WITHIN SPECIFIC SCHEMA
-- view all tables within a schema
SELECT sys.schemas.name AS SchemaName, sys.tables.name AS TableName
  FROM sys.tables
  INNER JOIN sys.schemas
  ON sys.tables.[schema_id] = sys.schemas.[schema_id]
  WHERE sys.schemas.name = N'insert_schema_name';
GO
```

# CREATING AND ALTERING TABLES

```sql
-- create a new database
CREATE database DatabaseName;
GO

-- switch to the database
USE DatabaseName;
GO

-- CREATE TABLE
CREATE TABLE table_name1 (
  -- identity says that the first record will be assigned a value of 1000 for column 1, like an id.
  -- And each successive record will have a column1 value that is one higher than the previous
column_name1 int IDENTITY(1000,1) PRIMARY KEY,
column_name2 nvarchar(50) NULL,
column_name3 nvarchar(50) NOT NULL
);
GO

-- FOREIGN KEYS
CREATE TABLE table_name2 (
    column1 char(13) PRIMARY KEY,
    column2 nvarchar(100) NOT NULL,
    column3 int NOT NULL
        FOREIGN KEY REFERENCES reference_table_name (column_name)
);
GO

-- INSERTING VALUES
-- this inserts two records into the first table created above. We do not need to specify a value for column_name1 since it is automatically inserted
INSERT table_name1
    VALUES  ('value2','value3'),
            ('value2','value3');
GO

INSERT table_name2
    VALUES  ('column1','column2','column3'),
            ('column1','column2','column3');
GO

-- ALTER TABLE TO ADD NEW COLUMN
ALTER TABLE table_name2
    ADD column4 char(4);
GO

-- UPDATE RECORDS
UPDATE table_name2
    Set column4 = 'some_value'
    WHERE column1 = 'some_identifier';
```

# COMPUTED COLUMNS

```sql
-- CREATING A TABLE WITH CALCULATED COLUMNS
CREATE TABLE dbo.Products (
    ProductID int IDENTITY(1,1) PRIMARY KEY,
    ProductName nvarchar(100) NOT NULL,
    ProductPrice smallmoney NOT NULL,
    ProductDiscount decimal(2,2) NOT NULL,
    -- computed column
    ProductExtendedPrice AS ProductPrice - (ProductPrice * ProductDiscount)
);
GO

-- The computed column is not listed here because it is automatically generated
INSERT dbo.Products
    VALUES  ('Mixed Nuts',3.99,.15),
            ('Shelled Peanuts',5.49,.10),
            ('Roasted Almonds',7.29,0);
GO


-- Computed columns CANNOT be used in other computed column definitions. This would throw an error because ProductExtendedPrice is a computed columns.
ALTER TABLE dbo.Products
    ADD TaxRate decimal(4,4) NOT NULL DEFAULT(.0875),
        TotalPrice AS (ProductExtendedPrice + (ProductExtendedPrice * TaxRate));
GO

-- Instead, we calculate TotalPrice from scratch
ALTER TABLE dbo.Products
    ADD TaxRate decimal(4,4) NOT NULL DEFAULT(.0875),
        TotalPrice AS (ProductPrice - (ProductPrice * ProductDiscount) + ((ProductPrice - (ProductPrice * ProductDiscount)) * TaxRate));
GO

-- CALCULATED COLUMN AS A PRIMARY KEY
-- we must use the PERSISTED keyword
-- This is because only unique or primary key constraints can be used on a computed column.
-- to use NOT NULL, CHECK, or FOREIGN KEY constraints, the computed column must be persisted.
-- PERSISTED specifies that the values will be physically stored in the table rather than creating them as virtual values.
CREATE TABLE dbo.Departments (
    DepartmentLocation char(2) NOT NULL,
    DepartmentCode char(3) NOT NULL,
    DepartmentID AS DepartmentLocation + '-' + DepartmentCode PERSISTED PRIMARY KEY NOT NULL
);
GO
```

# USING COLLATION

"A collation specifies the bit patterns that represent each character in a data set. Collations also determine the rules that sort and compare data."

- You can specify the collations at the instance, database, column, and expression level.

- All character types have some collation.

- If not specified at the column level, it uses the database collation. If not specified at the database level, it inherits the instance collation.

- Used for sorting rules, case, and accent sensitivity

```sql
-- Show the collation configured on the instance
SELECT SERVERPROPERTY('collation') AS DatabaseCollationName;

-- Show the collation configured on the database
SELECT SERVERPROPERTY(DB_NAME(), 'collation') AS DatabaseCollationName;

-- Show the collation for all the columns in a table
SELECT name AS ColumnName, collation_name AS ColumnCollation
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'schema_name.table_name');

-- Show the description for the collation
SELECT name, description
    FROM sys.fn_helpcollations()
    WHERE name = N'SQL_Latin1_General_CP1_CI_AS';

-- Show SQL collations not containing 'LATIN'
SELECT name, description
    FROM sys.fn_helpcollations()
    WHERE name LIKE N'SQL_%' AND name not like N'SQL_Latin%';

-- Change collation on a column
ALTER TABLE schema_name.table_name
    ALTER COLUMN column_name data_type(n)
    COLLATE SQL_New_Collation_Name
    NOT NULL;
```

# CONSTRAINTS - DATA INTEGRITY

## Null and Default Constraints

- NULL is a special marker to signify the absence of a value.
- SQL has three-value logic: true, false, unknown
- A DEFAULT constraint is used to provide a default value for a column. The default value will be added to all new records if no other value is specified.

```sql
-- Adding a DEFAULT CONSTRAINT when we CREATE TABLE
CREATE TABLE Orders.Orders (
    -- identity says that the first record will be assigned a value of 1 for OrderID.
    -- And each successive record will have a value that is 1 higher than the previous
    OrderID int IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Orders_OrderID PRIMARY KEY,
    OrderDate date NOT NULL
        CONSTRAINT DF_Orders_OrderDate_Getdate
            DEFAULT GETDATE(),
    OrderRequestedDate date NOT NULL,
    OrderDeliveryDate datetime2(0) NULL,
    CustID int NOT NULL
        CONSTRAINT FK_Orders_CustID_Customers_CustID
            FOREIGN KEY REFERENCES Orders.Customers (CustID),
    OrderIsExpedited bit NOT NULL
        CONSTRAINT DF_Orders_OrderIsExpedited_False
            DEFAULT 0
 );

--
-- Add default constraints after tables have been created
ALTER TABLE Orders.Orders
    ADD CONSTRAINT DF_Orders_OrderDate_Getdate
        DEFAULT GETDATE() FOR OrderDate;

ALTER TABLE Orders.Orders
    ADD CONSTRAINT DF_Orders_OrderIsExpedited_False
        DEFAULT 0 FOR OrderIsExpedited;


-- Alter a default constraint that has already been created, the right way
ALTER TABLE Orders.Orders
    DROP CONSTRAINT DF_Orders_OrderDate_Getdate;

 ALTER TABLE Orders.Orders
    ADD CONSTRAINT DF_Orders_OrderDate_Getdate_Plus_1
        DEFAULT GETDATE()+1 FOR OrderDate;

```

## Primary Keys & Unique Constraints

### Primary Key

- Ensures uniqueness
- Backed by an index

  - Clustered Indexes sort and store the data rows in the table based on their key values. These are the columns included in the index definition. There can only be one clustered index per table.
  - Heap : if a table has no clustered index, it is called a heap. Data rows are stored wherever they fit, in no particular order.
  - Non-clustered Indexes contain the nonclustered index key values and each key value entry has a pointer to the data row that contains the key value.

### Unique Constraints

- Ensures no duplicate values
- Columns not in the primary key
- Allows null, but only one per index column
- Can be referenced by a foreign key
- Backed by an index: clustered or non-clustered?

- non-clustered is the default for Unique if not specified

```sql
-- "Normal" primary key and unique constraints
CREATE TABLE Orders.Salutations (
    SalutationID int IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_Salutations_SalutationID  -- Defaults to system-generated name
            -- Clustered is the default for a primary key if not specified
            PRIMARY KEY CLUSTERED,
    Salutation varchar(5) NOT NULL
        CONSTRAINT UQ_Salutations_Salutation    -- Defaults to system-generated name
            UNIQUE NONCLUSTERED
);

-- Switching the index types
DROP TABLE IF EXISTS Orders.Salutations;

CREATE TABLE Orders.Salutations (
    SalutationID int IDENTITY(1,1) NOT NULL
        CONSTRAINT UQ_Salutations_SalutationID
            UNIQUE CLUSTERED,
    Salutation varchar(5) NOT NULL
        CONSTRAINT PK_Salutations_Salutation
            PRIMARY KEY NONCLUSTERED
);

```

# Entity & Referential Integrity

## Entity Integrity

A table has entity integrity if:

1. The chosen primary key can uniquely identify each row, AND
2. There is NO NULL value in the primary key column(s)

## Referential Integrity

A table has referential integrity if every value in the foreign key EITHER:

1. finds a MATCH in the referenced table, OR
2. is NULL

We do not want to reference something that doesn't exists

## Foreign Keys and Cascading Updates

- A foreign key is a column whose values reference the values in another table's candidate key.
- A foreign key works by building and enforcing a link between two tables.
- Helps preserve referential integrity

```sql
-- FOREIGN KEYS
CREATE TABLE table_name2 (
    column1 char(13) PRIMARY KEY,
    column2 nvarchar(100) NOT NULL,
    column3 int NOT NULL
        FOREIGN KEY REFERENCES reference_table_name (column_name)
);
GO
```

## Cascading

```sql
-- Update referencing tables with the changes made to the referenced table
ON DELETE CASCADE;
ON UPDATE CASCADE;

-- Do not allow changes, throw an error
-- This is the default setting
ON DELETE NO ACTION;
ON UPDATE NO ACTION;

-- Set the foreign key values to null
-- foreign key columns must be nullable
ON DELETE SET NULL;
ON UPDATE SET NULL;

-- Sets the foreign key values to their default values
ON DELETE SET DEFAULT;
ON UPDATE SET DEFAULT;

-- Example
CREATE TABLE _2 (
    StatChar CHAR(1) NULL REFERENCES _1(StatChar)
            ON UPDATE SET NULL
            ON DELETE CASCADE
    );
```

## Check Constraints

- Can be defined at the table and column levels
- Expression must evaluate to a boolean
- no queries
- Can use a function

```sql
-- Define a check constraint on the Salutation column
CREATE TABLE Orders.Salutations (
    ...
    ...
    Salutation varchar(5) NOT NULL
        CONSTRAINT UQ_Salutations_Salutation UNIQUE NONCLUSTERED
        CONSTRAINT CK_TableName_ColumnName_Descriptive_name CHECK (Condition)
);

-- Add constraint restricting customer's country
CREATE TABLE Orders.Customers (
    ...
    ...
    CustCountry nvarchar(100) NOT NULL
        CONSTRAINT CK_Customers_Country_must_be_US_UK_or_CA
            CHECK (CustCountry IN ('US', 'UK', 'CA')),
    ...
    ...
    );

-- Define a table constraint
CREATE TABLE Orders.Stock (
    ...,
    ...,
    ...,
    CONSTRAINT CK_Stock_SKU_cannot_equal_Description CHECK (StockSKU <> StockName )
);

-- Add a new constraint
ALTER TABLE ADD [WITH NO CHECK]
    CONSTRAINT ...;

-- Remove constraint
ALTER TABLE DROP CONSTRAINT ...;

-- Temporarily disable constraint
ALTER TABLE NOCHECK CONSTRAINT ...;

-- Reenable a constraint or check it
ALTER TABLE [WITH CHECK] CHECK CONSTRAINT ...;

-- apply actions to all constraints at once
ALTER TABLE DROP CONSTRAINT ALL
```

# VIEWS

- Encapsulate a query
- Customize results
- Security, hide data from certain users
- Backward compatability
- Virtual tables

```sql
-- Example & Best Practices
CREATE OR ALTER VIEW Orders.CustomerList
AS
  SELECT
    -- always use two-part names for column references
    cust.CustName             AS Name, -- alias the columns
    sal.Salutation            AS Salutation,
    cust.CustStreet           AS Street,
    city.CityStateCity        AS City,
    city.CityStateProv        AS StateProv,
    city.CityStatePostalCode  AS PostalCode,
    city.CityStateCountry     AS Country
  FROM orders.Customers cust -- alias the tables being queried
    INNER JOIN Orders.CityState city -- use ANSI join syntax
      ON cust.CityStateID = city.CityStateID
    INNER JOIN Orders.Salutations sal
      ON cust.SalutationID = sal.SalutationID;
GO
```

## Problem with Example

In the above example, the view we created works just fine. But what if one of the tables used to create view is deleted or modified? If a table used to create a view was deleted, the server would throw an error if we tried to use it. If the tables were modified, it might lead to strange behavior. Now imagine if the view was being used in an application. We would brake the application!!!! This is where schemabinding comes into play

## With Schemabinding

When we use the option WITH SCHEMABINDING in a view, three rules apply:

1. Base tables cannot be changed or dropped
2. Select statements must use two-part names, schema.object, for any tables, views, or functions referenced
3. All referenced objects must be in the same database

```sql
CREATE OR ALTER VIEW Orders.CustomerList
WITH SCHEMABINDING
AS
  SELECT
    cust.CustName             AS Name,
    sal.Salutation            AS Salutation,
    cust.CustStreet           AS Street,
    city.CityStateCity        AS City,
    city.CityStateProv        AS StateProv,
    city.CityStatePostalCode  AS PostalCode,
    city.CityStateCountry     AS Country
  FROM orders.Customers cust
    INNER JOIN Orders.CityState city
      ON cust.CityStateID = city.CityStateID
    INNER JOIN Orders.Salutations sal
      ON cust.SalutationID = sal.SalutationID;
GO
```

## Updateable Views

Like tables, views can be updated, but they are subject to certain restrictions:

- Any modifications, including UPDATE, INSERT, DELETE statements, must reference columns from only one base table
  - Meaning, if your view joins two or more tables, you can only update one of those tables through the view
- The columns being modified in the view must directly reference the underlying data in the table columns. The columns cannot be derived.
- The columns being modified cannot be affected by GROUP BY, HAVING, DINSTINCT, PIVOT, or UNPIVOT clauses.
- TOP or OFFSET clause is not used anywhere in the select statement of the view together with the WITH CHECK OPTION clause

## Indexed Views

An indexed view is a persisted object stored in the database in the same way that table indexes are stored. The underlying view is still a virtual table, but the index is written to disk

- The view does not have to be referenced in the query for the optimizer to consider that view for a substitution
- Indexed views are never stored as heaps

### Indexed View Requirements

1. The first index must be a unique clustered index
2. SET Options
3. View must be deterministic

   - Meaning, all expressions and WHERE, GROUP BY, and ON must always return the same result when evaluated with the same argument

4. The View and any functions referenced by the View must have been created using WITH SCHEMABINDING
5. Restricted T-SQL statements
   - Count, ROWSETs, OUTER JOINS, derived tables, self joins, sub queries, DISTINCT, TOP, ORDER BY, UNION, EXCEPT, INTERSECT, MIN, MAX, PIVOT, UNPIVOT...and many more!
6. Some aggregates may be used, like SUM
7. Check documentation for all requirements.

### Checking Determinism

```sql
-- Create a test view using computed columns
CREATE VIEW foo
WITH SCHEMABINDING
AS
SELECT
    CONCAT(oi.OrderID, oi.OrderItemID) AS One,
    oi.Discount * cast(.90 as [float]) AS Two
FROM Orders.OrderItems oi;
GO

-- Query to show if columns are deterministic and precise
SELECT
    COLUMNPROPERTY(OBJECT_ID(N'foo'), 'One', 'IsDeterministic') AS OneIsDeterministic,
    COLUMNPROPERTY(OBJECT_ID(N'foo'), 'One', 'IsPrecise') AS OneIsPrecise,
    COLUMNPROPERTY(OBJECT_ID(N'foo'), 'Two', 'IsDeterministic') AS TwoIsDeterministic,
    COLUMNPROPERTY(OBJECT_ID(N'foo'), 'Two', 'IsPrecise') AS TwoIsPrecise;

```

### Creating Indexed Views

```sql
-- Customer List view
CREATE OR ALTER VIEW Orders.CustomerList
WITH SCHEMABINDING
AS
  SELECT
    -- we add CustID because in order to create any index on a view there must first be a UNIQUE, Clustered Index
    cust.CustID               AS CustomerID,
    cust.CustName             AS Name,
    sal.Salutation            AS Salutation,
    cust.CustStreet           AS Street,
    city.CityStateCity        AS City,
    city.CityStateProv        AS StateProv,
    city.CityStatePostalCode  AS PostalCode,
    city.CityStateCountry     AS Country
  FROM orders.Customers cust
    INNER JOIN Orders.CityState city
      ON cust.CityStateID = city.CityStateID
    INNER JOIN Orders.Salutations sal
      ON cust.SalutationID = sal.SalutationID;
GO

-- Create a Unique, clustered index on the view
DROP INDEX IF EXISTS UQ_CustomerList_CustomerID ON Orders.CustomerList;
CREATE UNIQUE CLUSTERED INDEX UQ_CustomerList_CustomerID
    ON Orders.CustomerList(CustomerID);
GO

-- Query the view
SELECT CustomerID, Name, Salutation, City
    FROM Orders.CustomerList
    WHERE CustomerID = 1
    -- this tells sql server to ignore any indexes on the table and expand the view into queries on the underlying tables. All the tables in the view are queried directly.
    OPTION (EXPAND VIEWS);
GO

-- Create a non clustered index on the view
DROP INDEX IF EXISTS IX_CustomerList_Name_PostalCode ON Orders.CustomerList;
CREATE NONCLUSTERED INDEX IX_CustomerList_Name_PostalCode
    ON Orders.CustomerList(Name, PostalCode);
GO

-- Query the view
SELECT Name, PostalCode
    FROM Orders.CustomerList
    -- OPTION (EXPAND VIEWS);
GO
```

### Dealing with Restrictions

```sql
-- Create the View
CREATE OR ALTER View Orders.OrderSummary
WITH
  SCHEMABINDING
AS
  SELECT
    o.OrderID,
    o.OrderDate,
    -- can't have inline if statements
    IIF(o.OrderIsExpedited = 1, 'YES', 'NO') AS Expedited, -- Comment
    -- o.OrderIsExpedited,   -- Add
    c.CustName,
    SUM(i.Quantity) TotalQuantity
  -- if there is a group by, there must also be a COUNT_BIG(*)
    ,COUNT_BIG(*) AS cb      -- Add

  FROM Orders.Orders o
    JOIN Orders.Customers c
    ON o.CustID = c.CustID
    JOIN Orders.OrderItems i
    ON o.OrderID = i.OrderID
  GROUP BY o.OrderID, o.OrderDate, o.OrderIsExpedited, c.CustName
GO

-- Create the first index
CREATE UNIQUE CLUSTERED INDEX UQ_OrderSummary_OrderID
  ON Orders.OrderSummary (OrderID);
GO
```

# Partitioned Views

Need this section

# Modifying Data

```sql
--INSERT
INSERT INTO table_name (column_list)
VALUES (value_list);


--INSERT MULTIPLE ROWS
INSERT INTO table_name (column_list)
VALUES
    (value_list_1),
    (value_list_2),
    ...
    (value_list_n);


--INSERT INTO SELECT
INSERT  [ TOP ( expression ) [ PERCENT ] ]
INTO target_table (column_list)
query

--example
INSERT TOP (10)
INTO sales.addresses (street, city, state, zip_code)
SELECT
    street,
    city,
    state,
    zip_code
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;



-- UPDATE
UPDATE table_name
SET c1 = v1, c2 = v2, ... cn = vn
[WHERE condition];



-- UPDATE JOIN
-- To query data from related tables, you often use the join clauses, either inner join or left join. In SQL Server, you can use these join clauses in the UPDATE statement to perform a cross-table update.
-- We are creating a table from a join to find some specific value. Then, we use that value(s) to update t1
UPDATE
    t1
SET
    t1.c1 = t2.c2,
    t2.c2 = expression,
    ...
FROM
    t1
    [INNER | LEFT] JOIN t2 ON join_predicate
WHERE
    where_predicate;

-- example
UPDATE
    sales.commissions
SET
    sales.commissions.commission =
        c.base_amount * t.percentage
FROM
    sales.commissions c
    INNER JOIN sales.targets t
        ON c.target_id = t.target_id;




-- DELETE
DELETE [ TOP ( expression ) [ PERCENT ] ]
FROM table_name
[WHERE search_condition];

-- examples
-- delete rows based on condition
DELETE
FROM
    production.product_history
WHERE
    model_year = 2017;

-- delete 5 percent of random rows
DELETE TOP (5) PERCENT
FROM
    production.product_history;

-- delete all rows
DELETE
FROM
    production.product_history;




-- TRUNCATE
-- removes ALL rows from a table faster and more efficiently than delete
TRUNCATE TABLE [database_name.][schema_name.]table_name;

--example
TRUNCATE TABLE sales.customer_groups;

```

## MERGE

Suppose, you have two table called source and target tables, and you need to update the target table based on the values matched from the source table. There are three cases:

1. The source table has some rows that do not exist in the target table. In this case, you need to insert rows that are in the source table into the target table.
2. The target table has some rows that do not exist in the source table. In this case, you need to delete rows from the target table.
3. The source table has some rows with the same keys as the rows in the target table. However, these rows have different values in the non-key columns. In this case, you need to update the rows in the target table with the values coming from the source table

If you use the INSERT, UPDATE, and DELETE statement individually, you have to construct three separate statements to update the data to the target table with the matching rows from the source table.

The MERGE statement that allows you to perform three actions at the same time.

```sql
MERGE target_table USING source_table
ON merge_condition
WHEN MATCHED
    THEN update_statement
WHEN NOT MATCHED
    THEN insert_statement
WHEN NOT MATCHED BY SOURCE
    THEN DELETE;
```

- MATCHED: these are the rows that match the merge condition. For the matching rows, you need to update the rows columns in the target table with values from the source table.
- NOT MATCHED: these are the rows from the source table that does not have any matching rows in the target table. In this case, you need to add the rows from the source table to the target table. Note that NOT MATCHED is also known as NOT MATCHED BY TARGET.
- NO MATCHED BY SOURCE: these are the rows in the target table that do not match any rows in the source table. If you want to synchronize the target table with the data from the source table, then you will need to use this match condition to delete rows from the target table

```sql
-- example
MERGE sales.category t
    USING sales.category_staging s
ON (s.category_id = t.category_id)
WHEN MATCHED
    THEN UPDATE SET
        t.category_name = s.category_name,
        t.amount = s.amount
WHEN NOT MATCHED BY TARGET
    THEN INSERT (category_id, category_name, amount)
         VALUES (s.category_id, s.category_name, s.amount)
WHEN NOT MATCHED BY SOURCE
    THEN DELETE;
```

# Sequences

A sequence is simply a list of numbers, in which their orders are important

- sequences are not associated with any table
- can be shared across multiple tables

```sql
CREATE SEQUENCE [schema_name.] sequence_name
    [ AS integer_type ]
    [ START WITH start_value ]
    [ INCREMENT BY increment_value ]
    [ { MINVALUE [ min_value ] } | { NO MINVALUE } ]
    [ { MAXVALUE [ max_value ] } | { NO MAXVALUE } ]
    [ CYCLE | { NO CYCLE } ]
    [ { CACHE [ cache_size ] } | { NO CACHE } ];

-- Example
CREATE SEQUENCE procurement.order_number
AS INT
START WITH 1
INCREMENT BY 1;

INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    --  the NEXT VALUE FOR function generates the next sequence number
    (NEXT VALUE FOR procurement.order_number, 1, '2019-04-30');
```

## When to use sequences

You use a sequence object instead of an identity column in the following cases:

- The application requires a number before inserting values into the table.
- The application requires sharing a sequence of numbers across multiple tables or multiple columns within the same table.
- The application requires to restart the number when a specified value is reached.
- The application requires multiple numbers to be assigned at the same time. Note that you can call the stored procedure sp_sequence_get_range to retrieve several numbers in a sequence at once.
- The application needs to change the specification of the sequence like maximum value.

## Getting sequences information

You use the view sys.sequences to get the detailed information of sequences.

```sql
SELECT
    *
FROM
    sys.sequences;
```

# Other Table Types

- Partitioned
- Columstore : LEARN THIS!!
- Graph
- Memory-Optimized
- Temporal
- External
