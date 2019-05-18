# Indexes

```sql
-- Indexes are data structures that databases use to quickly find data

-- COSTS of indexes
    -- 1. they increase the size of the database because they have to be permanently stored next to the tables.
    -- 2. slows down write operations. Every time we insert, update, or delete a record the database has to update the corresponding indexes.
    -- 3.

    -- IMPORTANT NOTE: because indexes can affect performance, it is important to reserve them for performance critical queries.
    -- Design queries based on your queries, not your tables.


```

# Creating Indexes

```sql
-- Explain gives you a record with different properties of this query.
-- under the Type column you will see 'ALL', which means that this query is going to scan every record in this table.
-- in the Rows column we see '1012', which means this query needs to scan 1012 records
-- Now, imagine if we had millions of records. That may take a while just to find customers from CA
EXPLAIN SELECT customer_id
FROM customers
WHERE state = 'CA';

-- we can put an Index on the column to speed up the query.
CREATE INDEX idx_state ON customers (state);

-- when we run the query again we will see Type is now 'Ref', which mean it will not do a full scan
-- In the Rows columns we see 112, which means we drastically cut down the amount of rows that need to be scanned


```

# Viewing Indexes

```sql
-- to view the indexes on a table
SHOW INDEXES IN table_name;

-- CLUSTERED INDEX
-- when we create a primary key, the database automatically creates an index on the primary key column. This is called the clustered index

-- SECONDARY INDEXES
-- each table can only have one clustered index.
-- All other indexes are Secondary Indexes.

```

# Prefix Indexes

```sql
-- If the column we want to create an index on is a string column (char, varchar, text, blob, etc.), the index might perform poorly because of the length of the values. We want indexes to be as small as possible so that they fit in memory and our searches are faster.

-- When we index string columns we only want to include a prefix of the first few characters. Just enough to identify the column.
CREATE INDEX index_name ON table_name (string_column_name(prefix_number));

-- to find the optimal prefix number
  -- 1. get the records count on the table
  SELECT COUNT(*) FROM table_name;
  -- 2. now we use a little trial and error to find the optimat prefix length compared to the count from step 1
  SELECT COUNT(DISTINCT LEFT(column, prefix_num))
  FROM table_name;

-- example
  SELECT COUNT(*) FROM customers;   -- Returns 1010 records

  SELECT
    COUNT(DISTINCT LEFT(last_name, 1)),   -- Returns 26 records, compared to 1010 this is not good
    COUNT(DISTINCT LEFT(last_name, 5)),   -- Returns 966 records, this is good but maybe we can do better
    COUNT(DISTINCT LEFT(last_name, 10))   -- Returns 996. We doubled the length but it was only a slight improvement. 5 is optimal.
  FROM customers;

```

# Full-Text Indexes

```sql
-- With Full-Text indexes we can implement a fast and powerful search engine in our databases.
-- Full-Text indexes work differently than normal indexes.
-- Full-Text indexes include the entire string column, but they exclude stop words like in, a, the, on, etc.
-- They basically store a list of words and the rows or documents that they appear in.

CREATE FULLTEXT INDEX idx_name ON table_name (column1, column2);

-- Now we can use some built in functions for Full-Text indexes
SELECT *
FROM table_name
WHERE MATCH(column1, column2)    -- pass the columns we want to search on. We must include all the columns we included in the FULLTEXT INDEX
AGAINST('search string');   -- the keywords we want to search for.


-- for each record returned we can get a relevancy score as a floating-point number
-- the results are sorted according to relevancy score in descending order
-- we need to include the MATCH AGAIN statement in the SELECT clause
SELECT *, MATCH(column1, column2) AGAINST('search string') AS relevancy
FROM table_name
WHERE MATCH(column1, column2)    -- pass the columns we want to search on. We must include all the columns we included in the FULLTEXT INDEX
AGAINST('search string');        -- the keywords we want to search for.

-- Full Text searches have two modes.
  -- 1. Natural Language - this is the default mode
  -- 2. Boolean Mode - we can exclude words
SELECT *, MATCH(column1, column2) AGAINST('search string') AS relevancy
FROM table_name
WHERE MATCH(column1, column2)
AGAINST('search -excluded +required' IN BOOLEAN MODE); -- words with a negative (-) prefix MUST NOT be included in every row returned.
                                                       -- words with a positive (+) prefix MUST be in every row returned.
-- the search says find rows that have the word 'required', but do not have the word 'excluded'. and the word 'search' is optional

SELECT *, MATCH(column1, column2) AGAINST('search string') AS relevancy
FROM table_name
WHERE MATCH(column1, column2)
AGAINST('"search excluded required"' IN BOOLEAN MODE);  -- we use double quotes to search for an exact phrase

```

# Composite Indexes

```sql
-- A composite index is where we have more than one column in an index
-- in MySQL there is a max of 16 (that's very high) columns allowed in an index.
CREATE INDEX idx_name ON table_name (column1, column2,... column16);

-- The problem with single column indexes
CREATE INDEX idx_state ON customers (state);
-- most queries have more than one filter. If we ran this query,
-- having the single column index on state would make it faster.
-- But the second filter, points, is not indexed. Imagine if we had
-- 10 million customers in CA. This query would still be slow.
-- We could have multiple indexes for state and point, but the database
-- uses a max of 1 index when it runs the query. This is where composite
-- indexes are beneficial.
SELECT customer_id FROM customers
WHERE state = 'CA' AND points > 1000;


-- By using a composite index of state and points we can improve performance
CREATE INDEX idx_state_points ON customers (state, points);
SELECT customer_id FROM customers
WHERE state = 'CA' AND points > 1000;


```

# Order of Columns in Composite Indexes

```sql
-- In indexes, the order of columns is important:
  -- 1. put the most frequently used columns first
  -- 2. put the columns with the higher cardinality first
        -- highest cardinality, meaning the highest number of unique values in the index
-- these are not hard rules. You should always take your data and queries into account and TEST the indexes.

```

# When Indexes are Ignored

```sql
-- When we have an query that used a column in an expression, the database cannot use the index in the best possible way.
SELECT customer_id FROM customers
WHERE points + 10 > 2010;

-- we can rewrite this to make the best use of the index
-- we should always isolate our columns
SELECT customer_id FROM customers
WHERE points > 2000;

```

# Using Indexes for Sorting

```sql
-- We can also use index to sort data.
-- if we have a
CREATE INDEX idx_state ON customers (state);
-- because we have an index on state, this query will use the index for state.
SELECT customer_id FROM customers ORDER BY state;
-- if we order by another column, then the index is not used and there is a full scan on the table.
-- MySQL uses an algorithm called filesort to order by last name. This algorithm is expensive.
-- IMPORTANT: Generally speaking, try not to sort data unless you really have to. And then try to design an index for it.
-- the columns in the order by clause should be in the same order as your index
-- if we add columns to the order by clause that are not in the index, it results in a full table scan
SELECT customer_id FROM customers ORDER BY last_name;

-- if we reverse the order of the sort, the index will be used to satisfy the first part of the query,
-- but then the second part, the reverse sort, will use the filesort algorithm, making this an expensive query.
SELECT customer_id FROM customers ORDER BY last_name;

-- Rule of thumb
-- (a, b)           -- if you have an index on columns a and b...
-- a                -- you can sort by a
-- a, b             -- you can sort by b
-- a DESC, b DESC   -- you can sort by a descending and b descending. This results in a backwards scan instead of filesort
-- a, c, b          -- adding a column not in the index results in a full scan
-- b                -- sorting by the second column in an index results in using filesort. its an expensive query
                    -- this is because in the index customers are sorted by 'a' and then within each 'a' group they are sorted by 'b'
                    -- EXCEPTION. we can sort by b if we filter by a group of a.
                      -- for example:
                        -- here we have an index on state and points. Our query orders by the second column. This is not
                        -- an expensive query because we are only looking at the points in the CA group, which are already ordered by the index.
                            -- index(state, points)
                            -- SELECT customerID FROM customers
                            -- WHERE state = 'CA'
                            -- ORDER BY points;


-- SERVER VARIABLES
SHOW STATUS; -- to see the server variables

SHOW STATUS LIKE 'last_query_cost'; -- gives you the cost of the last query

```

# Convering Indexes

```sql
-- A covering index is an index that cover everything our query needs without touching the table.
-- When we create a secondary query, MySQL adds the primary key column(s) and the column(s) we specify to the index.
-- The fastest performance we can get is when we have a covering index to satisfy the query.

-- When designing indexes:
-- 1. look at your WHERE clause, look at the columns that are most frequently there and include them in your index
-- 2. look at the columns in the ORDER BY clause, see if you can include these in your index
-- 3. look at the columns in the SELECT clause and try to include them in your index.

```

# Index Maintenance

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

# Performance Best Practices

by Mosh Hamedani

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

Additional Reading

High Performance MySQL: Optimization, Backups, and Replication by Baron Schwartz

Relational Database Index Design and the Optimizers by Tapio Lahdenmaki
