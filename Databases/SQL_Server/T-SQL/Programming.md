# Stored Procedures

You can do virtually anything with stored procedured, but that doesn't mean that you should.

- Do not return lots of result sets
- Do not use cursors

# CREATE PROCEDURE

```sql
CREATE PROCEDURE proc_name
([parameters_list])
AS
BEGIN;
  statements here...
END;
GO

-- ALTER
-- not really used. most people drop the procedure and recreate it.
ALTER PROCEDURE schema.proc_name
([parameters_list])
AS
BEGIN;
  statements here...
END;
GO

-- DROP
-- SQL Server 2017 and above
DROP PROCEDURE [IF EXISTS] proc_name;

-- DROP Before 2017
IF EXISTS(SELECT 1 FROM sys.procedures WHERE [name] = 'proc_name')
 BEGIN;
	DROP PROCEDURE schema.proc_name;
 END;

GO
```

# Anatomy of a Stored Procedure

```sql
USE Contacts; -- always make sure you are in the right database
GO -- create and alter must be the first statement in a query batch

DROP PROCEDURE IF EXISTS dbo.InsertContact;
GO

CREATE PROCEDURE dbo.InsertContact
(
  -- parameters
  @FirstName            VARCHAR(40),
  @LastName             VARCHAR(40),
  @DateOfBirth          DATE = NULL, -- adding a default creates an optional parameter
  @AllowContactByPhone  BIT,
  @ContactId            INT OUTPUT --
)
AS
BEGIN; -- begin and end define the statement block, which is a series of SQL statements that run together.

-- variables
DECLARE @model_year SMALLINT,
        @product_name VARCHAR(MAX);

  SET NOCOUNT ON; -- do not show the count of rows affected
                  -- look at documentation for other SET options

  IF NOT EXISTS (SELECT 1 FROM dbo.Contacts
                WHERE FirstName = @FirstName AND @LastName = LastName
                AND DateOfBirth = @DateOfBirth)

    BEGIN; -- statement blocks can be nested
      INSERT INTO dbo.Contacts
        (FirstName, LastName, DateOfBirth, AllowContactByPhone)
      VALUES
        (@FirstName, @LastName, @DateOfBirth, @AllowContactByPhone);

      SELECT @ContactId = SCOPE_IDENTITY();
    END;

  EXEC dbo.SelectContact @ContactId = @ContactId;

  SET NOCOUNT OFF; -- show count of rows affected

END;
GO
```

# Executing a Stored Procedure

```sql
EXECUTE sp_name;
--or
EXEC sp_name;

-- using named parameters
EXECUTE uspFindProducts
    @min_list_price = 900,
    @max_list_price = 1000;

-- Calling a SP with output parameters
-- First, declare variables to hold the value returned by the output parameters
-- Second, use these variables in the stored procedure call.
DECLARE @count INT;

EXEC uspFindProductByModel
    @model_year = 2018,
    @product_count = @count OUTPUT;

SELECT @count AS 'Number of products found';

```

# IF...ELSE

```sql
IF Boolean_expression
BEGIN
    -- Executes when the Boolean expression is TRUE
    -- BEGIN and END create a statement block or batch. This allows us to run multiple SQL statement
END
ELSE -- else is optional
BEGIN
    -- Statement block executes when the Boolean expression is FALSE
END;


IF Boolean_expression
    -- Executes when the Boolean expression is TRUE
    -- When we don't use a statement block, we can only execute a single statement
ELSE
    -- executes when the Boolean expression is FALSE
END
```

# WHILE LOOP

```sql
WHILE Boolean_expression
     { sql_statement | statement_block}

--example
DECLARE @counter INT = 1;

WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
    -- remember that you need a way to break out of the loop
    -- In this case we change the counter with each iteration
END
```

# Break and Continue

```sql

-- BREAK
WHILE Boolean_expression1
BEGIN
    -- statement
    WHILE Boolean_expression2
    BEGIN
        IF condition
            BREAK; -- breaks out of the current loop

        -- code will be skipped if the condition is met
    END
END

-- CONTINUE
WHILE Boolean_expression
BEGIN
    -- code to be executed
    IF condition
        CONTINUE; -- Skips to the next iteration of the current loop

    -- code will be skipped if the condition is met
END
```

# CURSORS

Steps for using a Cursor:

1. Declare the cursor
2. Open the cursor
3. Fetch next from cursor
4. Close the cursor
5. Deallocate the cursor

```sql
-- 1. Declare the cursor
DECLARE cursor_name CURSOR
    FOR select_statement;

-- 2. Open the cursor
OPEN cursor_name;

-- 3. Fetch next from cursor
FETCH NEXT FROM cursor INTO variable_list;

-- 4. Close the cursor
CLOSE cursor_name;

-- 5. Deallocate the cursor
DEALLOCATE cursor_name;


--EXAMPLE
DECLARE
    @product_name VARCHAR(MAX),
    @list_price   DECIMAL;

DECLARE cursor_product CURSOR
FOR SELECT
        product_name,
        list_price
    FROM
        production.products;

OPEN cursor_product;

FETCH NEXT FROM cursor_product INTO
    @product_name,
    @list_price;

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @product_name + CAST(@list_price AS varchar);
        FETCH NEXT FROM cursor_product INTO
            @product_name,
            @list_price;
    END;

CLOSE cursor_product;

DEALLOCATE cursor_product;

```

# Anonymous Blocks

A block without a name is an anonymous block. An anonymous block is not saved in SQL Server, so it is just for one-time use. Anonymous blocks are useful for testing purposes.

```sql
BEGIN
    DECLARE @name VARCHAR(MAX);

    SELECT TOP 1
        @name = product_name
    FROM
        production.products
    ORDER BY
        list_price DESC;

    IF @@ROWCOUNT <> 0
    BEGIN
        PRINT 'The most expensive product is ' + @name
    END
    ELSE
    BEGIN
        PRINT 'No product found';
    END;
END
```

# Why Cursors are Bad and What to do about them

## Cursor Logic vs. Set Operations

- Cursor logic oerates row by row, uses more memory, and creates more blocking.
- Set operations perform much better in general, scales way better, and easier to read and troubleshoot.

## While Loops

You may think that you can use a while loop instead of a cursor, that it is faster. Under the hood, a while loop performs much like a cursor.

## What to do instead?

- Try to do whatever operations you can in a set-based operation, this is what relational databases are good at
- If you absolutely need a row by row operations use a cursor
- Cursors give you more options and control
- Understand temp tables, Table valued functions, and parameters
- Consider doing things at application tier

# ERRORS

Three ways to plan for failure

1. Error Handling: Try/Catch blocks and Throw
2. Transactions: Begin/Commit Transaction
3. Handling Nulls: Try_Convert and Coalesce

## Handling Conversion Errors and Nulls

TRY_CAST
TRY_CONVERT
TRY_PARSE

## Transactions

### What is the ACID principle

- Guarantees a stable database
- Atomic: all pieces of a transaction must be completed successfully, otherwise all changes are rolled back. All or nothing.
- Consistency: Keeping integrity in place
- Isolation: refers to having multiple users, with concurrent transactions, performing inserts, updates, and deletes without colliding with eachother.
- Durable: Failure recovery

### Three Modes

- Autocommit transactions:
  - Automatically commits after each statement, default of SQL Server
- Implicit transactions:
  - The moment you begin to modify your database, it will automatically start a transaction for you
  - But you must explicitly commit the transaction at the end
- Explicit transactions:
  - We manually manage our transactions
  - BEGIN, END, ROLLBACK
  - this is the preferred method.

```sql
-- Explicit transaction
BEGIN TRANSACTION;

	INSERT INTO Sales.SalesPersonLevel (LevelName)
		VALUES	('Sr Staff');

	INSERT INTO Sales.SalesPersonLevel (LevelName)
		VALUES	('Sr Director');

COMMIT TRANSACTION;
GO

-- Can we rollback DDL statements, YES!
BEGIN TRANSACTION;

	ALTER TABLE Sales.SalesPersonLevel ADD isActive bit NOT NULL DEFAULT 1;

	TRUNCATE TABLE Sales.SalesOrder;

ROLLBACK TRANSACTION;
GO
```

### Concurrency

In the real world you will have multiple users accessing the same data. This is called concurrency. Concurrency is controlled through locks.

### Concurrency issues

1. Lost Updates:

   - Somebody changes data another user is accessing
   - Solve using: Read Uncomitted, Read Committed, Repeatable Read, Serializable, Snapshot

2. Dirty Reads:

   - Someone reads data another user is actively modifying
   - Solve using: Read Committed, Repeatable Read, Serializable, Snapshot

3. Non-repeatable Reads:

   - Queries with the same predicate return different results
   - Solve using: Repeatable Read, Serializable, Snapshot

4. Phantom Reads:

   - Successive queries produce new rows
   - Solve using: Serializable, Snapshot

### Isolation Levels

```sql

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- Does not lock data except for modifications
-- Does not honor any locks
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Default setting
-- Locks modified data until end of transaction
-- Locks read data until end of Select statement
GO

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- Locks modified data until end of transaction
-- Locks read data until end of transaction
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Locks modified data until end of transaction
-- Locks read data unitl end of select statement
-- No other transaction can insert data into the range specified by any WHERE clause
GO

SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
-- Uses versioning, you get your own version of the data
-- versions are maintained in tempdb
-- versions ensure data is consistent with time the transaction started
-- people can modify their versions without impacting other users
-- must be enabled on the database
-- additional database options can set read committed to use snapshot
-- Update may cause errors - if current verysion has changed, update will fail.
GO
```

## Check open transactions

```sql
@@TRANCOUNT -- returns the number of open transactions in the current connection in an integer format
```

## Transaction Savepoints

```sql
-- Savepoints provide the ability to rollback to a particular point in a transaction.

-- Using save points
BEGIN TRANSACTION;

	SAVE TRANSACTION Level_1;

		INSERT INTO Sales.SalesPersonLevel (LevelName)
			VALUES	('Vice President');

	SAVE TRANSACTION Level_2;

		INSERT INTO Sales.SalesPersonLevel (LevelName)
			VALUES ('CIO');

	SAVE TRANSACTION Level_3;

		INSERT INTO sales.SalesPersonLevel (LevelName)
			VALUES ('Intern');

	SAVE TRANSACTION Level_4;
GO


-- now we can remove the intern
ROLLBACK TRANSACTION Level_3;
GO


-- Only commit up to save point 3
COMMIT TRANSACTION Level_3;
GO
```

## Error Handling

### An error message has 6 parts

1. Number - error id
2. Level - higher the number, higher the severity
3. State
4. Line - line number where the error occured
5. Procedure - the name of the procedure or function if one was used.
6. Message - description of the error

### Levels of Severity

- 0-9 informational
- 11-16 user can fix
- 17-19 resource issue
- 20-25 fatal errors

### RAISERROR

- Only command used to raise exceptions before SQL 2012
- Must pass in required parameters
  - Message, Severity and State
  - Default id of 50,000
  - If you do supply a message id, it must exist in sys.messages
- You can raise informational messages
  - limit to length of message
- with Log Option

```sql
-- Raise a message without the Id
RAISERROR('The row count does not match',16,1);
GO
-- Raise where message Id does not exist
RAISERROR(65000,16,1);
GO
-- Raise with a low severity
RAISERROR('This is a lower severity message',1,1);
GO
-- Will be logged to the error log
RAISERROR('This is a custom logged message',16,1) WITH LOG;
GO
-- Using a variable as the message text
DECLARE @MessageText nvarchar(500);
SET @MessageText = 'This is a custom error message';

RAISERROR(@MessageText,16,1);
GO
```

### TRY/CATCH Block

```sql
BEGIN TRY
-- Do something amazing
END TRY
BEGIN CATCH
-- An error message occured
END CATCH


--Example
BEGIN TRY

-- Some code here

END TRY
BEGIN CATCH
	DECLARE @ErrorMessage nvarchar(250);
	DECLARE @ErrorSeverity int;
	DECLARE @ErrorState int;
	DECLARE @ErrorLine int;

	SELECT	@ErrorMessage = ERROR_MESSAGE()
			,@ErrorSeverity = ERROR_SEVERITY()
			,@ErrorState = ERROR_STATE()
			,@ErrorLine = ERROR_LINE();

	RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState,@ErrorLine);

END CATCH
GO
```

### XACT_ABORT & XACT_STATE with Transactions

```sql
-- Using XACT_ABORT ON without an explicit transaction will terminate the remaining statements only.
-- Using XACT_ABORT ON with an explicit transaction the entire transaction is terminated and rolled back.
SET XACT_ABORT ON;
BEGIN TRANSACTION;

-- some code here

COMMIT TRANSACTION;
GO




-- XACT_STATE is a scalar function that returns the committability of our transaction. Most of the time you will see it in a try catch with an explicit transaction.
BEGIN TRANSACTION;

-- some code here
COMMIT TRANSACTION;

END TRY
BEGIN CATCH

	IF (XACT_STATE() = -1)
		BEGIN
			PRINT 'Not committable';
			ROLLBACK TRANSACTION;
		END

	IF (XACT_STATE() = 1)
		BEGIN
			PRINT 'Committable';
			COMMIT TRANSACTION;
		END

END CATCH
GO
```

### THROW

- Released in SQL Server 2012
- Microsoft recommends using it
- Raise the actual error
- No need for parameters, just Throw
- Only severity level 16
- No log option
- You need the semicolon
- You get the actual line number where exception happened

```sql

THROW [ error_number,  message,  state ];

-- This will throw an error.
-- THROW must be used inside of a catch block
-- Or must be used with the message options
THROW;
GO


-- This will NOT throw an error
-- Because we added the options
THROW 50010, 'This is a great message', 1;
GO


-- The syntax for throw is simple
BEGIN TRY
	-- some code
END TRY
BEGIN CATCH

	THROW;
  -- anything after THROW will not run
	PRINT 'Does this print?';

END CATCH
GO



-- Using a variable as the message text and number
DECLARE @MessageText nvarchar(500);
DECLARE @ErrorNumber int;

SET @MessageText = 'This is a custom error message';
SET @ErrorNumber = 65000;

THROW @ErrorNumber, @MessageText, 1;
GO
```
