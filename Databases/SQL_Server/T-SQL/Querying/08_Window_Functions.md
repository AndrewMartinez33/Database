What is a window function?

In order to use window functions the over clause is required

There are three possible components in the over clause

- Order By - May be one or more columns or expressions -- even a subquery. Required when the order is important to the function
- Partition By - May be one or more columns or expressions -- even a subquery. Supported by every window function and is always optional
- Framing

# Ranking Functions

- ROW_NUMBER
- RANK
- DENSE_RANK
- NTILE

## Syntax

```sql
ROW_NUMBER|RANK|DENSE_RANK ()
OVER([PARTITION BY <expression>] ORDER BY <expression>);

NTILE(<num of buckets>)
OVER([PARTITION BY <expression>] ORDER BY <expression>);

```
