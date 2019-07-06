# DECLARE CLAUSE OBJECTS

The DECLARE clause is used to define (declare) internal program objects, such as variables.

## Internal Objects

- Variable - An element internal to the program that can hold and modify values
- Boolean - A simple type containing TRUE/FALSE/NULL
- Constant - Similar to a variable, but cannot be changed
- Record - Complex object that matches the structure of a table within the database yet holds a single record.
- Table - Complex object that matches the structure of a table within the database
- User-defined type - A type that uses a combination of the predefined objects to create a new type unique to the program

# Object Naming Rules

- Max length is 30 characters
- First character must be a letter
- The following are legal and illegal characters:
  - Legal: \$ # \_
  - Illegal: & - / (space)

```sql
-- Set the server to output the results
SET SERVEROUTPUT ON;

DECLARE
  --var_name [CONSTANT] datatype [NOT NULL] [:= default_value];
  vConst  CONSTANT  number(2)   NOT NULL := 44;
  vNumber NUMBER(4);
  vChar   CHAR(10);
BEGIN
  DBMS_OUTPUT.PUT_LINE('COMPILED SUCCESSFULY');
END;
```

# AVAILABLE DATA TYPES

-- need

# %TYPE

Variable data types may be dynamically and automatically matched to any column within the Oracle table.

```sql
DECLARE
-- this goes to the employee table and grabs the datatype from the salary column
-- var_name [CONSTANT] datatype [NOT NULL] [:= default_value];
  vSalary emloyee.salary%TYPE;

BEGIN
...
END;
```

We can also tie data types to another variable in the DECLARE

```sql
DECLARE
  x_MinSalary   employee.salary%TYPE;
  x_AvgSalary   x_MinSalary%TYPE
  x_MaxSalary   x_MinSalary%TYPE

BEGIN
...
END;
```

# %ROWTYPE

A complex type that defines a record, matching the names and data types of an entire table or view

```sql
DECLARE
  -- this variable contains the names and types of all the columns in the employee_table
  empRecord   employee_table%ROWTYPE;
BEGIN
  -- now we can set the fields in the empRecord variable
  empRecord.first_name := 'Andrew';
  empRecord.last_name := 'Martinez';
END;

```
