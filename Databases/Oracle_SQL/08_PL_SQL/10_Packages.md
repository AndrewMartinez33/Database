# Packages

A package is a collection of stored procedures, functions, and supporting objects. This of it as an application.

A package is composed of two distinct sections:

1. A public specification or header which defines the interfaces to all public package program units
   - Modules to be called by larger applications included in the public specification
   - Only the program unit name and all the paramaters and data types are included in the header
2. A private body which contains the PL/SQL source code for each program unit
   - the body is also known as the implementation
   - each individual program within the implementation is the same as when it was standalone
   - Modules in the body that are not included in the public specification are private

## Advantages of using Packages

Almost all stored programs should be packaged. They offer:

- More sohisticated programming - there are many programming features only available in packages
- Performance - memory management. The moment one thing in the package is called, the entire package is put into the memory of the machine. All subsequent calls to programs in the package load faster because they are already in memory.
- Ease of Maintenance - database administration is easier

## Referencing Packaged Programs

Packaged programs are referenced with the format:

PackageName.ProgramName()

```sql
EXECUTE Personnel.hire_employee('123456', 'Mary', 'Jones', 'Manager', 50000);
```

Note: try to avoid standalone procedures with the same name.

# CREATING A PACKAGE

- We do not use the CREATE OR REPLACE keywords inside of packages
- In the package implementation section you MUST list any PRIVATE programs first

```sql
-- first we create the package specification
CREATE OR REPLACE PACKAGE PackageName1 AS

  PROCEDURE ProcName1 (parameters);

  FUNCTION  FuncName1 (parameters)
    RETURN DataType;

END PackageName1;

-- second, we create the package implementation
CREATE OR REPLACE PACKAGE BODY PackageName1 AS
  -- list private programs/functions first
  FUNCTION  PrivateFuncName (parameters)
    RETURN DataType
    IS
      ...
    BEGIN
      ...
    END PrivateFuncName;

  PROCEDURE ProcName1 (parameters) AS
    -- declare variables
    ...
    BEGIN
    END ProcName1;

  FUNCTION  FuncName1 (parameters)
    RETURN DataType;
    BEGIN
      ...
      RETURN;
    END FuncName1;

END PackageName1;
```

# ADVANCED PROGRAMMING TECHNIQUES

Features available to packages

- Execution with invoker rights rather than definer rights
- Declaring and using persistent objects
- Defining package initialzation logic
- object oriented principles

Invoker Rights

```sql
CREATE OR REPLACE PACKAGE PackageName1
AUTHID CURRENT_USER
AS
...
```

# PERSISTENT GLOBAL OBJECTS

```sql
CREATE OR REPLACE PACKAGE PackageName1
AS
-- define global objects
-- this variable is now available to all the programs/functions below
CurrentEmployeeSSN DataType;

-- define procedures/functions
...
```

# INITIALIZATION LOGIC

At times, you may need to include code that prepares the package for processing

The package body can include an anonymous program block at the very end to do this.

- The initialization block only runs at the beginning of a session
- place the block at the very bottom of the body

```sql
CREATE OR REPLACE PACKAGE BODY PackageName1 AS
  /*
  FUNCTION  PrivateFuncName (parameters)
    RETURN DataType
    IS
      ...
    BEGIN
      ...
    END PrivateFuncName;

  PROCEDURE ProcName1 (parameters) AS
    -- declare variables
    ...
    BEGIN
    END ProcName1;

  FUNCTION  FuncName1 (parameters)
    RETURN DataType;
    BEGIN
      ...
      RETURN;
    END FuncName1;                 */

  BEGIN
    ... initialization logic
  -- we dont need an END statement

END PackageName1;
```
