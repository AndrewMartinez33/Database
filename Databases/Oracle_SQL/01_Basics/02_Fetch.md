# Oracle FETCH clause syntax

The following illustrates the syntax of the row limiting clause:

```sql
[ OFFSET offset ROWS]
 FETCH  NEXT [  row_count | percent PERCENT  ] ROWS  [ ONLY | WITH TIES ]
```

## OFFSET clause

The OFFSET clause specifies the number of rows to skip before the row limiting starts. The OFFSET clause is optional. If you skip it, then offset is 0 and row limiting starts with the first row.

The offset must be a number or an expression that evaluates to a number. The offset is subjected to the following rules:

- If the offset is negative, then it is treated as 0.
- If the offset is NULL or greater than the number of rows returned by the query, then no row is returned.
- If the offset includes a fraction, then the fractional portion is truncated.

## FETCH clause

The FETCH clause specifies the number of rows or percentage of rows to return.

For the semantic clarity purpose, you can use the keyword ROW instead of ROWS, FIRST instead of NEXT. For example, the following clauses behavior the same:

```sql
FETCH NEXT 1 ROWS
FETCH FIRST 1 ROW
```

## ONLY | WITH TIES

The ONLY returns exactly the number of rows or percentage of rows after FETCH NEXT (or FIRST).

The WITH TIES returns additional rows with the same sort key as the last row fetched. Note that if you use WITH TIES, you must specify an ORDER BY clause in the query. If you don’t, the query will not return the additional rows.

# Oracle FETCH clause examples

A) Top N rows example

The following statement returns the top 10 products with the highest inventory level:

```sql
SELECT
    product_name,
    quantity
FROM
    inventories
INNER JOIN products
        USING(product_id)
ORDER BY
    quantity DESC
FETCH NEXT 10 ROWS ONLY;
```

B) WITH TIES example

The following query uses the row limiting clause with the WITH TIES option:

```sql
SELECT
 product_name,
 quantity
FROM
 inventories
INNER JOIN products
 USING(product_id)
ORDER BY
 quantity DESC
FETCH NEXT 10 ROWS WITH TIES;
```

C) Limit by percentage of rows example

The following query returns top 5% products with the highest inventory level:

```sql
SELECT
product_name,
quantity
FROM
inventories
INNER JOIN products
USING(product_id)
ORDER BY
quantity DESC
FETCH FIRST 5 PERCENT ROWS ONLY;

--The inventories table has 1112 rows, therefore, 5% of 1112 is 55.6 which is rounded up to 56 (rows).
```

D) OFFSET example

The following query skips the first 10 products with the highest level of inventory and returns the next 10 ones:

```sql
SELECT
product_name,
quantity
FROM
inventories
INNER JOIN products
USING(product_id)
ORDER BY
quantity DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;
```
