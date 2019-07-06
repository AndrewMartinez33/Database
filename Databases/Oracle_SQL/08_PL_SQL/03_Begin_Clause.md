# CONCATENATING STRINGS

```sql
DECLARE
  EmpFName   employee.fname%TYPE;
  EmpLName   employee.lname%TYPE;
  FullName   VARCHAR(50);
BEGIN
  -- concat with pipes
  FullName := EmpLName || ', ' || EmFName;
END;
```

# STRING LITERALS

```sql
DECLARE
  someText   VARCHAR(50);
BEGIN
  -- this would throw an error because of the three quotations
  someText := 'This isn't the end';
END;
```

We can use the q statement to get around this problem

```sql
DECLARE
  someText   VARCHAR(50);
BEGIN
  -- everything between the exclamation marks is now valid
  someText := q'!This isn't the end!';
END;

```

# BOOLEAN VARIABLES

```sql
DECLARE
  EmpSalary     employee.salary%TYPE;
  HighPaid      BOOLEAN := FALSE;
BEGIN
  EmpSalary := 50000;
  -- returns true if EmpSalary is greather than 40000
  HighPaid := (EmpSalary > 40000);

  -- if HighPaid is equal to TRUE
  IF HighPaid THEN
    DBMS_OUTPUT.PUT_LINE('This salary is high');
  END IF;
END;
```

# DML & CONTROL STATEMENTS

Any valid SQL DML update or transaction control statement may be directly executed in PL/SQL

- INSERT
- UPDATE
- DELETE
- LOCK TABLE

## Transaction Control Statements

- COMMIT - Makes changes permanent
- ROLLBACK - Rollsback changes made before a commit
- SAVEPOINT - Creates a partial rollback. Rolls back to the save point.
- SET TRANSACTION -
