# PL/SQL

PL/SQL is a block-structured language whose code is organized into blocks. A PL/SQL block consists of 5 sections:

- DECLARE - Declares internal program objects, such as variables
- BEGIN - (required) Marks the beginning of the program logic
- Program Logic - (required) This is the actual PL/SQL and SQL statements
- EXCEPTION - Marks the beginning of exception logic
- END - (required) Marks the end of the program logic

A PL/SQL block has a name. A Function or a Procedure is an example of a named block. A named block is saved into the Oracle Database server first and then can be reused.

# Anonymous Block

A block without a name is an anonymous block. An anonymous block is not saved in the Oracle Database server, so it is just for one-time use. PL/SQL anonymous blocks are useful for testing purposes.

```sql
DECLARE
  v_message VARCHAR2( 255 ) := 'Hello World!';
BEGIN
  DBMS_OUTPUT.PUT_LINE( v_message );
EXCEPTION
...
END;
```

# SYNTAX RULES

## Comments

```sql
-- This is a single line comment.

/*
  This is a multiline comment.
  You can write as much as you want here.
*/
```

## PL/SQL

- You can only write one PL/SQL statement per line
- ALL execution statements must be terminated with a ;
