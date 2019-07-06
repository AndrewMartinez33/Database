# CURSORS

PL/SQL uses implicit and explicit cursors. PL/SQL declares a cursor implicitly for all SQL data manipulation statements, including queries that return only one row. If you want precise control over query processing, you can declare an explicit cursor in the declarative part of any PL/SQL block, subprogram, or package. You must declare an explicit cursor for queries that return more than one row.

SQL Cursor Object Details:

- We can access attributes within this cursor to determine the action results
- The cursor and attributes are available regardless of a successful or failed DML operation.

# IMPLICIT CURSOR

Implicit cursors are managed automatically by PL/SQL so you are not required to write any code to handle these cursors. However, you can track information about the execution of an implicit cursor through its cursor attributes.

SQL Cursor Attributes:

- SQL%FOUND - Returns TRUE if an INSERT, UPDATE, or DELETE statement affected one or more rows or a SELECT INTO statement returned one or more rows. Otherwise, it returns FALSE.

- SQL%NOTFOUND - The logical opposite of %FOUND. It returns TRUE if an INSERT, UPDATE, or DELETE statement affected no rows, or a SELECT INTO statement returned no rows. Otherwise, it returns FALSE.

- SQL%ROWCOUNT - Returns the number of rows affected by an INSERT, UPDATE, or DELETE statement, or returned by a SELECT INTO statement.

- SQL%ISOPEN - With implicit cursors this always returns FALSE, because Oracle closes the SQL cursor automatically after executing its associated SQL statement. This function is more meaningful when using explicit cursors.

```sql
DECLARE
  ...
BEGIN
  ...
  IF SQL%FOUND THEN
    ...
  END IF;

  IF SQL%NOTFOUND THEN
    ...
  END IF;

  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' RECORDS WERE UPDATED.');
END;
```

# EXPLICIT CURSORS

- Explicit cursors are names pointers to rows and columns within the database
- They are used whenever sequential processing is required.

## CURSOR declarations must be created within the DECLARE clause

- Any valid SQL statement is permitted
- A variable containing the structure holding the data must also be created

```sql
DECLARE
  -- declare the cursor
  CURSOR Employees IS
    SELECT *
    FROM employee
    WHERE salary > 15000;

  -- variable containing the row type associated with the Cursor
  EmpRecord  employee%ROWTYPE;

BEGIN
...
END;
```

## All CURSOR processing is performed within the BEGIN clause

- The CURSOR must be opened
- The FETCH statement advances the CURSOR pointer to the next record
- After each statement, the %FOUND and %NOTFOUND attributes must be tested
- If the FETCH statement results in a new row, execute any desired processing
- When completed, the CURSOR must be closed

```sql
DECLARE
  -- declare the cursor
  CURSOR Employees IS
    SELECT *
    FROM employee
    WHERE salary > 15000;

  -- variable containing the row type associated with the Cursor
  EmpRecord  employee%ROWTYPE;

BEGIN
  -- open the cursor
  OPEN Employees;

  LOOP
    -- places the next record into the variable
    FETCH Employees INTO EmpRecords;
    -- test to see if a record was processed or not
    -- exit the loop is nothing was found
    EXIT WHEN Employees%NOTFOUND;

    -- processing is a record was found
    dbms_output.put_line('EmpRecords.Salaries')
  END LOOP;

  -- and finally close the CURSOR
  CLOSE Employees;
...
END;
```

## Explicit CURSOR attributes

Explicit cursors have the same attributes as implicit cursors, but the values returned by the attributes are slightly different.

- %FOUND and %NOTFOUND indicate whether or not the FETCH statement received data
- %ROWCOUNT indicates which row the FETCH statement received
- %ISOPEN is TRUE/FALSE depending on whether the cursor is open and data is available

```sql
-- explicit cursor attributes are accessed with the following format:
cursor_name%attribute_name

--EXAMPLES
DECLARE
  CURSOR Employees IS
    SELECT *
    FROM employee
    WHERE salary > 15000;

  EmpRecord  employee%ROWTYPE;
BEGIN
  -- open the cursor
  IF NOT (Employees%ISOPEN) THEN
    OPEN Emloyees;
  END IF;
...
END;
```

#UPDATEABLE CURSORS
As part of the row-by-row processing, updates may need to be performed. This is done by incorporating the FOR UPDATE OF clause. You are telling the DBMS that when you open the cursor it will be for the purpose of updating the specified columns.

Critical Notes:

- Once an UPDATE cursor is opened, the underlying data is locked
- These rows will remain locked until:
  - The cursor is closed
  - The transaction is terminated with either COMMIT or ROLLBACK

```sql
DECLARE

  CURSOR Employees IS
    SELECT *
    FROM employee
    WHERE salary > 15000
  FOR UPDATE OF Salary, LName;

BEGIN
...
END;
```

When working with Updateable cursors, you will need to use the SQL DML command to physically perform the update. You must include the phrase WHERE CURRENT OF cursor_name.

```sql
DECLARE

  CURSOR Employees IS
    SELECT *
    FROM employee
    WHERE salary > 15000
  FOR UPDATE OF Salary, LName;

BEGIN
...

  -- update the record
  UPDATE Employees
  SET salary = salary - Paycut, Lname = UPPER(Lname)
  WHERE CURRENT OF Employees;
...

END;
```

# CURSOR PARAMETERS

An explicit cursor may accept a list of parameters. Each time you open the cursor, you can pass different arguments to it that result in different result set. The search criteria within the cursor declaration may be altered each time the cursor is opened by the means of a parameter.

Parameter rules:

- Parameters are defined within the cursor declaration
- Parameters are used in the WHERE clause
- The parameter value is passed when the cursor is opened

```sql
DECLARE
  -- parameters are added like so: (paramName  paramType)
  CURSOR Employees (SelectDept  department.dnumber%TYPE) IS
    SELECT *
    FROM employee
    WHERE dno = SelectDept  --must be used in the WHERE
  FOR UPDATE OF Salary, LName;

  -- variable to store value for the parameter
  SelectDepartment  department.dnumber%TYPE;
BEGIN
-- Now we retrieve the value for the parameter and store it in our variable
SELECT d.number
INTO SelectDepartment
FROM department d
  INNER JOIN dept_locations dl ON d.dnumber = dl.dnumber
WHERE dl.dlocation = 'Stafford'
AND ROWNUM <= 1;

-- Next we open the cursor and pass in our parameter variable
-- this value is used in the WHERE clause in our cursor
OPEN Employees (SelectDepartment);
...

END;
```

# FOR LOOP CURSORS

The FOR...LOOP Cursor is a very effective technique that greatly improves performance

- It implifies the code
- It is more concise
- It manages cursor opening and closing
- It manages EXIT
- FETCH is automatic

```sql
DECLARE
...
BEGIN
  -- FOR...LOOP CURSOR syntax:
  FOR Employees IN -- each time the FOR is executed, record is placed in implicitly declared object
    ( SELECT * FROM employee) -- select statement declares the cursor type
    LOOP
      dbms.output.put_line('Last Name: ' || Employees.Lname);
    -- when we get to the END LOOP and implicit FETCH is performed along with a check
    -- of the %NOTFOUND attribute. If %NOTFOUND is TRUE, the implicit EXIT is fired
    -- along with an implicit CLOSE
    END LOOP;
...

END;
```

# Advantages of Cursors

- You can programmatically cycle through multiple records
- The common EXCEPTION which can occur with the SELECT INTO statement never happens
  - TOO_MANY_ROWS because of the FETCH command
  - NO_DATA_FOUND because the pointer simply stays on the last record
