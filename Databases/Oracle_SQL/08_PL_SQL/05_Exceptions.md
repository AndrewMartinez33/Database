# TRAPPING EXCEPTIONS

```sql
DECLARE
...
BEGIN
...

EXCEPTION
  -- test for a single condition
  WHEN zero_divide THEN
    ...
  -- test for a set of conditions
  WHEN no_data_found OR too_many_rows THEN
    ...
  -- test for all other condition
  WHEN OTHERS THEN
    ...
END;
```

# COMMON ERRORS

- NOT_DATA_FOUND : select... into
- TOO_MANY_ROWS : select... into
- CURSOR_ALREADY_OPEN : explicit cursors
- INVALID_CURSOR : explicit cursors
- CASE_NOT_FOUND : missing match or ELSE clause in CASE structure
- INVALID_NUMBER : value error when assigning values to variables
- VALUE_ERROR : value error when assigning values to variables
- ZERO_DIVIDE : value error when assigning values to variables
- LOGIN_DENIED : database connect errors
- NOT_LOGGED_ON : database connect errors
- PROGRAM_ERROR : internal fatal errors
- STORAGE_ERROR : internal fatal errors
- TIMEOUT_ON_RESOURCE : internal fatal errors

# USER-DEFINED EXCEPTIONS

Creating a new exception is a 2-step process

1. Declare a user-assigned name as Exception
2. Associate the name with an Oracle error number
   - Google 'Oracle error codes'

```sql
DECLARE
  -- step 1
  exception_name EXCEPTION;
  --step 2
  PRAGMA EXCEPTION_INIT (exception_name, error_code)
BEGIN
...
EXCEPTION
END;

-- EXAMPLE
DECLARE
  -- step 1
  not_null_contstraint EXCEPTION;
  --step 2
  PRAGMA EXCEPTION_INIT (not_null_constraint, -1407)
BEGIN
...
EXCEPTION
  WHEN not_null_constraint THEN
    ...
  WHEN others THEN
    ...
END;
```

# SQLCODE & SQLERRM

If your EXCEPTION block uses the WHEN OTHERS handler, you can use the following objects to ascertain the problem:

- SQLCODE : gives you the error code
- SQLERRM : gives you the error message

This is good to use when you are debugging your program

```sql
DECLARE
  ...
BEGIN
  ...
EXCEPTION
  WHEN others THEN
    dbms_output.put_line('Error Code: ' || SQLCODE);
    dbms_output.put_line('Error Message: ' || SQLERRM);
END;
```
