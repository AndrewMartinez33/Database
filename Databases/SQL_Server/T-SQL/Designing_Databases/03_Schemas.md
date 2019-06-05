# SCHEMA

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
USE WideWorldImporters;
GO

SELECT sys.schemas.name AS SchemaName, sys.tables.name AS TableName
  FROM sys.tables
  INNER JOIN sys.schemas
  ON sys.tables.[schema_id] = sys.schemas.[schema_id]
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
