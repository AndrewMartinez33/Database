# UNION

- combines two tables that have identical attributes
- The number and the order of columns must be the same in the two queries.
- The data type of the corresponding columns must be in the same data type group such as numeric or character.

```sql
SELECT
    column_list
FROM
    T1
UNION
SELECT
    column_list
FROM
    T2;

```

By default, the UNION operator returns the unique rows from both result sets. If you want to retain the duplicate rows, you explicitly use UNION ALL as follows:

```sql
SELECT
    column_list
FROM
    T1
UNION ALL
SELECT
    column_list
FROM
    T2;
```

# INTERSECT

- produces a list that contains rows that appear in both tables
- The number and the order of columns must be the same in the two queries.
- The data type of the corresponding columns must be in the same data type group such as numeric or character.

```sql
SELECT
    column_list_1
FROM
    T1
INTERSECT
SELECT
    column_list_2
FROM
    T2;
```

# DIFFERENCE (oracle calls this MINUS)

- yields all rows found in table 1 but not in table two
- The number and the order of columns must be the same in the two queries.
- The data type of the corresponding columns must be in the same data type group such as numeric or character.

```sql
SELECT
    column_list_1
FROM
    T1
MINUS
SELECT
    column_list_2
FROM
    T2;
```

-
