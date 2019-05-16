# Transactions

```sql
-- A transaction is a group of SQL statements that represent a single unit of work.
-- All the statements in a transaction must be completed successfully or the transaction fails.
-- Example: Think about a bank transaction where you are transferring money from one account to another.
--  First we withdraw the money from one account - this statement completes successfully
--  Then, we insert the money into the other account -- this statement completes successfully
--  The transaction successful, But if the second statement were to fail, then we would roll back the changes made in the first statement.

-- Transaction have a few properties: ACID
-- A - Atomicity: all the statements in the transaction are a single unit of work. Either they are all successful or they all fail.
-- C - Consistency: with these transaction, our database will always be in a consistent state.
-- I - Isolation: Transactions are isolated from each other or protected from each other if they try to modify the same data. If multiple transaction are affecting the same data, the rows that are being affected get locked. Only one transaction at a time can update those rows.
-- D - Durability: Once a transaction makes changes they are permanent.
```

# Creating Transactions

```sql
START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-01', 1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 1);

COMMIT;
```

# Concurrency and Locking

```sql
-- In the real world you will have multiple users accessing the same data. This is called concurrency.
-- When a transaction UPDATES a row it puts a lock on that row. No other transaction can use that row until the first transaction is complete.

```

# Concurrency Problems

```sql
-- Lost Updates - Two transactions update the same row and the one that commits last overwrites the changes made earlier.
    -- To solve this problem use: REPEATABLE READ, SERIALIZABLE

-- Dirty Reads - Happens when you read uncommited data
    -- To solve this problem use: READ COMMITTED, REPEATABLE READ, SERIALIZABLE

-- Non-repeating Reads -  You read the same data twice in a transaction, but get different results
    -- To solve this problem use: REPEATABLE READ, SERIALIZABLE

-- Phantom Reads -  we miss one or more rows in a query because there is another transaction making changes to those rows.
    -- To solve this problem use: SERIALIZABLE

```

# Transaction Isolation Levels

```sql
-- READ UNCOMMITTED - lowest isolation level
-- READ COMMITTED
-- REPEATABLE READ
-- SERIALIZABLE -  highest isolation level

-- the lower the isolation level we use, the better the performance, but the bigger our concurrency problems.
-- the higher the isolation level we use, the lower our concurrency problems, but the bigger our scaleability and performance problems because we need more locks and resources.

-- In MySQL the default isolation level is REPEATABLE READ. This prevents most concurrency problems except for Phantom Reads. If we need to prevent Phantom Reads then we can change the isolation level.

-- to see the current isolation level
SHOW VARIABLES LIKE 'transaction_isolation';

-- set the isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- we can set it for a session only
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- we can set it globally
SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;

```

# Deadlocks

```sql
-- Deadlock is when two transaction are stuck waiting for each other to complete.
-- there is no way to completely get rid of deadlocks, but you can do things to minimize them:
    -- 1. look at your code. If you have two transactions that do the same thing in a reverse order they will deadlock.
    -- 2. Keep transaction small and short in duration so they are less likely to collide with other transactions.
    -- 3. If you have large transaction that act on large tables they make take a while to run, increasing the likelyhood of a deadlock. In this case, try running these transaction in off peak times when there are less users online.

```
