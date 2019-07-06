# PIVOTING

The Oracle PIVOT clause allows you to write a cross-tabulation query starting in Oracle 11g. This means that you can aggregate your results and rotate rows into columns.

Syntax
The syntax for the PIVOT clause in Oracle/PLSQL is:

```sql
SELECT * FROM
(
  SELECT column1, column2
  FROM tables
  WHERE conditions
)
PIVOT
(
  aggregate_function(column2)
  FOR column2
  IN ( expr1, expr2, ... expr_n) | subquery
)
ORDER BY expression [ ASC | DESC ];
```
