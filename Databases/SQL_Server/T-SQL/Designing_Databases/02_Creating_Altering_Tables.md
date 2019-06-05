# CREATING AND ALTERING TABLES

```sql
-- create a new database
CREATE database DatabaseName;
GO

-- switch to the temporary database
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
