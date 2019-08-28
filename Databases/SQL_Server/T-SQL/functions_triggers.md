# Functions

- There are Built-In functions and User-Defined Functions
- User-Defined Functions can be scalar or table-valued

Functions CAN...

- Only take input parameters
- Be used in SELECT statements
- Be used in a JOIN if returns a table
- Use table variables
- Use Schemabinding

Functions CANNOT...

- Alter the state of the database
- Alter the transaction
- Use temporary tables
- Execute stored procedures
- Use Try/Catch blocks

Functions can be used in...

- Select statements and WHERE clauses
- Constraints on a table
- Computed Columns
- Joins
- Stored Procedures
- Other functions

Functions can be Deterministic or Non-Deterministic

- Deterministic: Given the same input, always return the same output
- Non-deterministic: Given the same input, do not guarantee the same result each time.
- When creating user-defined functions, aim to create Deterministic functions.

All functions...

- Must return a value
- Can have input parameters only
- Can have default values
- Can query and modify data locally (within the function itself), but no DDL or DML modifications are allowed
- Are part of two broad categories, Multi-Statement Functions and Single Statement Functions.
  - Until recent versions of SQL Server, Multi Statement functions cannot be "in-lined"

# Multi-Statement Scalar and Table Valued Functions

Multi-Statement Scalar and Multi-Statement Table-Valued suffer from known performance problems. Although, this is starting to change in SQL Server 2017 and 2019

Multi-Statement Scalar Function

```sql
-- Basic Syntax
CREATE OR ALTER FUNCTION schema.function_name(@param1 INT, @param2 INT)
-- return type
RETURNS INT
-- underlying schemas and tables cannot be changed
WITH SCHEMABINDING
AS
-- must have a begin and end
BEGIN
	-- some code.
  -- must return a value of the specified type
	RETURN @param1 + @param2;
END;
GO
```

Multi-Statement Table-Valued Functions

- returns a table

```sql
CREATE OR ALTER FUNCTION schema.tvfunction_name(@a INT, @b INT)
RETURNS @TableName TABLE -- return type: table
( SumValue INT ) -- column names and types
WITH SCHEMABINDING
AS
BEGIN
	INSERT INTO @SumValueTable (SumValue)
		SELECT @a + @b;

	RETURN;
END;
GO
```

# Inline Table-Valued Functions

- A.K.A Single-Statement Table-Valued Functions
- No BEGIN and END
- Only contains one SQL statement that returns a table of data
- Can be used anywhere a table input can be used.
- Better performance: The query optimizer can take the single-statement T-SQL and include it in the calling query!

```sql
CREATE OR ALTER FUNCTION dbo.SuperAdd_itvf(@a INT, @b INT)
--return type
RETURNS TABLE
WITH SCHEMABINDING
AS

-- no begin and end
-- single return statement inside parenthesis
RETURN(SELECT @a + @b AS SumValue);
GO


-- We can use CTE's to craft more complex functions
CREATE OR ALTER FUNCTION dbo.SuperAdd_itvf(@a INT, @b INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN(
  -- CTE
  -- this does the same as the above
	WITH SumValues AS (
		SELECT @a + @b AS SumValue
	)
	SELECT SumValue FROM SumValues
	)
GO

-- Another Example
CREATE OR ALTER FUNCTION dbo.FiscalYearEndingDB_ITVF(@SaleDate DATETIME)
RETURNS TABLE
WITH SCHEMABINDING
AS
	RETURN(
    -- CTE
		WITH EndMonth AS (
			SELECT CAST(SettingValue AS INT) AS FiscalEndMonth FROM Application.Settings WHERE SettingName='FiscalEndMonth'
		)
		SELECT CASE WHEN (MONTH(@SaleDate) > EM.FiscalEndMonth AND EM.FiscalEndMonth != 1) THEN
			YEAR(@SaleDate) + 1 ELSE YEAR(@SaleDate) END FiscalYear
		FROM EndMonth EM
	);
GO
```

# Converting Multi-Statement Functions to In-lined Table-Valued Functions

- For complex multi-statement functions, creativity is often necessary
- CTE's are a common go to tool.
- Worth the effort for better performance

# Parameter Sniffing in Inline Table Valued Functions

- SQL Server saves the plans it generates in a cache to reuse later
- The "Key" of that plan is the actual SQL text
- Sometimes the plan it chooses is not the most efficient for all cases, this happens with parameterized queries.

```sql
-- SQL Server creates an execution plan
-- SQL Server reads through 1000 pages to get the data
SELECT * FROM dbo.SaleTransactionAmount(401);

-- SQL Server creates a new execution plan because the text is different (976)
-- SQL Server only reads through 250 pages to get the data
SELECT * FROM dbo.SaleTransactionAmount(976);

-- PARAMETER SNIFFING
DECLARE @Id INT = 401;
-- SQL Server Creates a new plan because the text is different
-- SQL Server reads through 1000 pages to get the data
SELECT * FROM dbo.SaleTransactionAmount(@Id) STC;
GO

DECLARE @Id INT = 976
-- SQL Server does NOT create a new plan because the text is the same
-- The same execution plan is used as with 401
-- SQL Server reads through 1000 pages to get the data
SELECT * FROM dbo.SaleTransactionAmount(@Id) STC;
GO


-- How do we fix it?
-- The most common method is to force the plan to recompile.
-- This creates a new execution plan every time the query runs
-- RESEARCH: there are many options to deal with parameter sniffing
DECLARE @Id INT = 401;
SELECT * FROM dbo.SaleTransactionAmount(@Id) STC
OPTION (RECOMPILE);
GO

DECLARE @Id INT = 976
SELECT * FROM dbo.SaleTransactionAmount(@Id) STC
OPTION (RECOMPILE);
GO
```

#Triggers
