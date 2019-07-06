# Procedures vs Functions

- Procedures are used to perform tasks
- Functions are generally used to fetch or return some desired value

PROCEDURE Syntax:

```sql
-- the OR REPLACE statement allows an existing rogram unit to be overwritten with a new declaration
CREATE OR REPLACE PROCEDURE procedure_name
(
  param_name1  IN type,  -- IN means it will only be an input parameter
  param_name2  IN type,
  param_nameN  OUT type  -- OUT means it will be returned
)
AS -- we use the AS keyword for procedures

-- PROGRAM DECLARATIONS

BEGIN
-- MAIN PROGRAM LOGIC

EXCEPTION
-- EXCEPTION LOGIC

END procedure_name;
```

FUNCTION Syntax:

```sql
CREATE OR REPLACE FUNCTION function_name
(
  param_name1  IN type,
  param_name2  IN type
)
RETURN type  -- this is required
IS -- we use the IS keyword for functions

-- PROGRAM DECLARATIONS

BEGIN
-- MAIN PROGRAM LOGIC

RETURN someValue; -- function always need to return something.

EXCEPTION
-- EXCEPTION LOGIC

END function_name;
```

# PARAMETERS

Parameter Name

- No longer than 30 character
- illegal characters are not permitted
- first character must be a letter

Parameter Mode

- IN - Indicates the parameter will accept a value into the program when it's called
- OUT - Indicates the parameter will be assigned a value within the program and passed back
- IN OUT - Indicates the parameter both accepts a value and may modify the value for output
- Good programming practice states that FUNCTIONS should not have any OUT or IN OUT parameters

Data Types

- must be unconstrained, meaning use NUMBER instead of NUMBER(x), use VARCHAR instead of VARCHAR(10)
- preferred practice is to use %TYPE or %ROWTYPE

DEFAULT

- The optional DEFAULT clause allows you to preset a parameter in the event the calling program does not supply one.
- If DEFAULT is not supplied and the calling program does not supply a value, the parameter will be set to NULL

```sql
CREATE OR REPLACE PROCEDURE procedure_name
(
  param_name1 IN | OUT | IN OUT
              DataType
              DEFAULT x
)
...
```

# Executing Procedures and Functions

```sql
-- calling a procedure from within a procedure
DECLARE
 -- if the procedure you call has an OUT parameter then you need a variable to store the value
 output_text  CHAR(100);

BEGIN
  -- call the procedure and store the output
  raise_salary ('1234567', 51, :output_text);
  dbms_output.put_line(output_text);

END;
```

## To Test Procedures with OUT parameter

In SQL\*PLUS

```sql
-- 1. Define a SQL Plus variable for the output parameter
-- 2. Execute the rocedure
-- 3. Issue the SQL Plus print command to output the parameter results
VARIABLE output_text CHAR(100);

EXECUTE raise_salary ('1234567', 51, :output_text);

PRINT output_text;
```

In a production environment, stored program units are called from an application. In this case you need to write a script to test the procedure

SQL Developer is such an environment.

```sql
-- calling a procedure from within a procedure
DECLARE
 -- if the procedure you call has an OUT parameter then you need a variable to store the value
 output_text  CHAR(100);

BEGIN
  -- call the procedure and store the output
  raise_salary ('1234567', 51, :output_text);
  dbms_output.put_line(output_text);

END;
```

## Functions

Function calls have to be embedded in a command

```sql
BEGIN
  IF salary_valid('1234567', 80000) THEN
    dbms_output.put_line('success');
  END IF;
END;
```

Stored functions created by developers may be referenced directly within SQL statements.

- This is no different than calling built-in functions
- Gives you flexibility to create functions for your own business rules and tests
- user-defined functions may be referenced anywhere that a built-in function may be referenced:
  - within the SELECT statement
  - within conditional expressions: WHERE, GROUP BY, or HAVING
  - within the value list of INSERT or UPDATE commands

Restrictions

- Only IN formal parameters are permitted within the stored function
  - OUT and IN OUT parameters are NOT permitted
  - These should not be used in functions anyway
  - UPDATE operations cannot be performed

```sql
SELECT UPPER(Lname) AS 'Last Name',
       ROUND(Salary * 1.25) AS 'Proposed Salary',
       DEVELOPER_FUNCTION(ssn, Salary * 1.25) AS 'Valid'
FROM employee;
```

# COMPILATION ERRORS

When a stored program is submitted for creation, it is submitted to a compilation process

- If successful, the program unit is ready for execution
- if compilation fails due to errors, the source code is still stored within the data dictionary but an error message is displayed
- All compilation errors are stored in the dictionary view USER_ERRORS. While you can directly query this view, you can also use the SHOW ERRORS command.

```sql
SHOW ERRORS PROCEDURE procedure_name;
```

## Recompiling

- There are dependencies among objects, including procedures, function, and tables.
- A change of a procedure/function/table will cause objects that call it to become INVALID
- An invalid object will be re-comiled at runtime. Make sure all your objects are VALID when your system goes live.
- CREATE OR REPLACE will automatically recompile the procedure/function. Or you can use the following commands to explicitly recompile a preocedure/function

```sql
ALTER PROCEDURE MyProcedure COMPILE;

ALTER FUNCTION MyFunction COMPILE;
```

# DATA DICTIONARY

Information about database program units can be obtained from the Data Dictionary.

The Data Dictionary presents database object information for a schema with Views using one of the following prefixes:

- USER\_ : views owned by the current user
- ALL\_ : All objects accessible to a user regardless of SCHEMA
- DBA\_ : Administrator - all objects within the database

## Data Dictionary Views

- USER_OBJECTS - This lists all database objects, including program units.
- USER_SOURCE - The actual source code is accessible using this view
- USER_ERRORS - Compilation errors that exist for the current version of the program
- USER_OBJECT_SIZE - The size of the program
- USER_DEPENDENCIES - All dependent objects for each database program unit

```sql
DESCRIBE view_name;

--EXAMPLE
DESCRIBE USER_OBJECTS;

-- lIMIT THE SELECTION PROCEDURES AND FUNCTIONS
SELECT object_name, status
FROM user_objects
WHERE object_type IN ('PROCEDURE', 'FUNCTION');
```

## USER_OBJECT_SIZE

The USER_OBJECT_SIZE is instrumental in planning for the storage and execution of PL/SQL applications within the database.

Each column in the view describes a different size parameter for the objects:

- SOURCE_SIZE - indicates the size of the source code
- PARSED_SIZE - This is the arsed form of the program which is loaded into memory during compilation. The maximum size is 64k.
- CODE_SIZE - This is the compiled version of the program. There is a maximum size of 128k.
- ERROR_SIZE - This is the size of the error message information, if any

## USER_DEPENDENCIES

This view exposes limited dependency information pertaining to program objects. Only shows you first-level dependencies.

```sql
SELECT referenced_name, referenced_type
FROM user_dependencies
WHERE name = 'RAISE_SALARY_VALID'; --this is case sensitive
```

# MANAGING DEPENDENCIES

- coming soon

# TRACKING DEPENDENCIES

- coming soon
