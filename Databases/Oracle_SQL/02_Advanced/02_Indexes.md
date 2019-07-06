# INDEXING

Indexes are data structures that databases use to quickly find data

Notes:

1. they increase the size of the database because they have to be permanently stored next to the tables.
2. slows down write operations. Every time we insert, update, or delete a record the database has to update the corresponding indexes.
3. IMPORTANT NOTE: because indexes can affect performance, it is important to reserve them for performance critical queries.
   - Design queries based on your queries, not your tables.

To view all indexes of a table, you query from the all_indexes view:

```sql
SELECT
    index_name,
    index_type,
    visibility,
    status
FROM
    all_indexes
WHERE
    table_name = 'MEMBERS';
```

To check if a query uses the index for lookup or not, you follow these steps:

First, add the EXPLAIN PLAN FOR clause immediately before the SQL statement:

```sql
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';
```

This explains the execution plan INTO the plan_table table.

Then, use the DBMS_XPLAN.DISPLAY() procedure to show the content of the plan_table:

```sql
SELECT
    PLAN_TABLE_OUTPUT
FROM
    TABLE(DBMS_XPLAN.DISPLAY());
```

# CREATE INDEX

To create a new index for a table, you use the CREATE INDEX statement as follows:

```sql
CREATE INDEX index_name
ON table_name(column1[,column2,...])
```

By default, the CREATE INDEX statement creates a btree index.

When you create a new table with a primary key, Oracle automatically creates a new index for the primary key columns.

Unlike other database systems, Oracle does not automatically create an index for the foreign key columns.

# UNIQUE INDEX

Oracle UNIQUE index
An index can be unique or non-unique. A unique index ensures that no two rows of a table have duplicate values in the indexed column (or columns). A non-unique index does not impose this restriction on the indexed column’s values.

To create a unique index, you use the CREATE UNIQUE INDEX statement:

```sql
CREATE UNIQUE INDEX index_name ON
table_name(column1[,column2,...]);
```

When you define a PRIMARY KEY or a UNIQUE constraint for a table, Oracle automatically creates a unique index on the primary key or unique key columns to enforce the uniqueness.

The unique index associated with the constraint always has the name of the constraint, unless specify it explicitly otherwise.

# FUNCTION BASED INDEXES

The following statement creates an index on the last_name column of the members table:

```sql
CREATE INDEX members_last_name_i
ON members(last_name);
```

If you use the last name column in the WHERE clause, the query optimizer will definitely use the index:

```sql
SELECT * FROM members
WHERE last_name = 'Sans';
```

However, if you use a function on the indexed column last_name as follows:

```sql
SELECT * FROM members
WHERE UPPER(last_name) = 'SANS';

---the query optimizer could not leverage the index.
```

A function-based index calculates the result of a function that involves one or more columns and stores that result in the index.

The following shows the syntax of creating a function-based index:

```sql
CREATE INDEX index_name
ON table_name (expression)

-- EXAMPLE
CREATE INDEX members_last_name_fi
ON members(UPPER(last_name));

```

In this syntax, the index expression can be an arithmetic expression or an expression that contains a function such as a SQL function, PL/SQL function, and package function.

# BITMAP INDEX

The following query finds all female members from the members table:

```SQL
SELECT
    *
FROM
    members
WHERE
    gender = 'F';
```

The gender column has two distinct values, F for female and M for male. When a column has a few distinct values, we say that this column has low cardinality.

Oracle has a special kind of index for these types of columns which is called a bitmap index.

A bitmap index is a special kind of database index which uses bitmaps or bit array. In a bitmap index, Oracle stores a bitmap for each index key. Each index key stores pointers to multiple rows.

For example, if you create a bitmap index on the gender column of the members table. The structure of the bitmap index looks like the following picture:

It has two separate bitmaps, one for each gender.

Oracle uses a mapping function to converts each bit in the bitmap to the corresponding rowid of the members table.

The syntax for creating a bitmap index is quite simple a follows:

```sql
CREATE BITMAP INDEX index_name
ON table_name(column1[,column2,...]);
```

For example, to create a bitmap index for the gender column, you use the following statement:

```sql
CREATE BITMAP INDEX members_gender_i
ON members(gender);
```

# COVERING INDEXES

```sql
-- A covering index is an index that cover everything our query needs without touching the table.
-- When we create a secondary query, MySQL adds the primary key column(s) and the column(s) we specify to the index.
-- The fastest performance we can get is when we have a covering index to satisfy the query.

-- When designing indexes:
-- 1. look at your WHERE clause, look at the columns that are most frequently there and include them in your index
-- 2. look at the columns in the ORDER BY clause, see if you can include these in your index
-- 3. look at the columns in the SELECT clause and try to include them in your index.

```

# INDEX MAINTENANCE

```sql
-- Watch our for unused indexes.
-- Watch out for duplicate indexes.
-- Watch out for redundant indexes. A redundant index is if you have an index on (A,B) and then another index on (A)
  -- if you have a index on (A, B)
        -- another index on (A)     -- REDUNDANT
        -- another index on (B, A)  -- NOT REDUNDANT
        -- another index on (B)     -- NOT REDUNDANT

-- It is good practice to look at the existing indexes before creating new indexes

```

# PERFORMANCE BEST PRACTICES

1. Smaller tables perform better. Don’t store the data you don’t need. Solve today’s problems, not tomorrow’s future problems that may never happen.

2. Use the smallest data types possible. If you need to store people’s age, a TINYINT is sufficient. No need to use an INT. Saving a few bytes is not a big deal in a small table, but has a significant impact in a table with millions of records.

3. Every table must have a primary key.

4. Primary keys should be short. Prefer TINYINT to INT if you only need to store a hundred records.

5. Prefer numeric types to strings for primary keys. This makes looking up records by the primary key faster.

6. Avoid BLOBs. They increase the size of your database and have a negative impact on the performance. Store your files on disk if you can.

7. If a table has too many columns, consider splitting it into two related tables using a one-to-one relationship. This is called vertical partitioning. For example, you may have a customers table with columns for storing their address. If these columns don’t get read often, split the table into two tables (users and user_addresses).

8. In contrast, if you have several joins in your queries due to data fragmentation, you may want to consider denormalizing data. Denormalizing is the opposite of normalization. It involves duplicating a column from one table in another table (to reduce the number of joins) required.

9. Consider creating summary/cache tables for expensive queries. For example, if the query to fetch the list of forums and the number of posts in each forum is expensive, create a table called forums_summary that contains the list of forums and the number of posts in them. You can use events to regularly refresh the data in this table. You may also use triggers to update the counts every time there is a new post.

10. Full table scans are a major cause of slow queries. Use the EXPLAIN statement and look for queries with type = ALL. These are full table scans. Use indexes to optimize these queries.

11. When designing indexes, look at the columns in your WHERE clauses first. Those are the first candidates because they help narrow down the searches. Next, look at the columns used in the ORDER BY clauses. If they exist in the index, MySQL can scan your index to return ordered data without having to perform a sort operation (filesort). Finally, consider adding the columns in the SELECT clause to your indexes. This gives you a covering index that covers everything your query needs. MySQL doesn’t need to retrieve anything from your tables.

12. Prefer composite indexes to several single-column index.

13. The order of columns in indexes matter. Put the most frequently used columns and the columns with a higher cardinality first, but always take your queries into account.

14. Remove duplicate, redundant and unused indexes. Duplicate indexes are the indexes on the same set of columns with the same order. Redundant indexes are unnecessary indexes that can be replaced with the existing indexes. For example, if you have an index on columns (A, B) and create another index on column (A), the latter is redundant because the former index can help.

15. Don’t create a new index before analyzing the existing ones.

16. Isolate your columns in your queries so MySQL can use your indexes.

17. Avoid SELECT \*. Most of the time, selecting all columns ignores your indexes and returns unnecessary columns you may not need. This puts an extra load on your database server.

18. Return only the rows you need. Use the LIMIT clause to limit the number of rows returned.

19. Avoid LIKE expressions with a leading wildcard (eg LIKE ‘%name’).

20. If you have a slow query that uses the OR operator, consider chopping up the query into two queries that utilize separate indexes and combine them using the UNION operator.
