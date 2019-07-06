In Oracle, the SELECT statement must have a FROM clause. However, some queries don’t require any table for example:

```sql
SELECT
  UPPER('This is a string')
FROM
  what_table
```

In this case, you might think about creating a table and use it in the FROM clause for just using the UPPER() function.

Fortunately, Oracle provides you with the DUAL table which is a special table that belongs to the schema of the user SYS but is accessible to all users. The DUAL table has one column named DUMMY whose data type is VARCHAR2() and contains one row with a value X.

```sql
SELECT
   *
FROM
   dual;
Oracle DUAL Table
```

By using the DUAL table, you can call the UPPER() function as follows:

```sql
SELECT
  UPPER('This is a string')
FROM
  dual;
```

Besides calling built-in function, you can use expressions in the SELECT clause of a query that accesses the DUAL table:

```sql
SELECT
  (10+ 5)/2
FROM
  dual;
```

The DUAL table is most simple one because it was designed for fast access.

In Oracle 10g release 1 and above, Oracle treats the use of DUAL the same as calling a function which simply evaluates the expression used in the select list. This optimization provides even a better performance than directly accessing the physical DUAL table.

-
