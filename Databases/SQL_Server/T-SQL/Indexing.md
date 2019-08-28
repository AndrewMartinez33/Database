# When Indexing a New System

- Create indexes to suport unique requirements
- Create indexes on foreign key columns
- Create indexes to support expected common queries
- Be prepared to change indexes later

# When Indexing an Existing System

- Identify the most resource-intensive queries
- Identify the most important queries
- Index to support them
- Re-investigate regularly

# Index Architecture

- Data in SQL Server is stored in 8kb chunks, called pages
- Pages are organized in a B-tree

## B-tree Index

- The lowest level is a leaf. The data is sorted by the index key and divided into 8kb chunks. An index will always have 1 or more
- The next level up is the intermediate level. The intermediate pages contain the lowest-level index key value (the first row) from each leaf-level page. An index can have 0 or more intermediate pages and levels.
- The next level up is the Root page. The root page contains the first row of each intermediate-level page. An index will contain 0 or 1 root pages.

## Three ways SQL Server Uses Indexes

### Index Seek

- Navigation down the tree from the root to find a value

### Index Scan

- A read of some or all of the leaf pages without navigating down the index tree first

### Key Lookup

- Single row seek to the clustered index

# Clustered Indexes

- A clustered index is an index which defines the physical storage of the table
- There is only one clustered index per table
- A table without a clustered index is called a heap

## Implementing Clustered Indexes

There are two schools of thought on how the clustered index should be chosen:

- Create the clustered index to organize the table.
- Create the clustered index to support the most frequent access path, meaning the most common way to filter the table.

## Guidelines for Organizing the table

Ideally, the clustered index should be:

- Narrow - the size in bytes of the index key column. A larger index key causes more overhead, may result in a deeper index tree.
  - Remember that each page is 8kb. The larger the index key column the more intermediate levels and pages we need to get to the Root
  - The clustered index key is used as a row address in all other indexes
- Unique - The clustered index has to be unique as it is used as a row's address. If it's not created as UNIQUE, then an extra hidden column is added.
- Unchanging - The clustered index key defines where a row is found within the index
  - If the key changes, the update has to be split into a delete-insert pair
  - Fragmentation
- Ever-increasing - Every new row into the table has a column key index higher than the previous.
  - Inserts into random places within the index causes splits, which are slow

# Nonclustered Indexes for Performance

- Separate structures from the table
- Multiple allowed per table
- Don't have to contain all columns
- Always in sync with the table, changes maded to the table are made to the index

##

# Indexed Views

# Columnstore Indexes
