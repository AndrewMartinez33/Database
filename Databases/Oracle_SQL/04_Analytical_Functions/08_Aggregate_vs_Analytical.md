# AGGREGATE FUNCTIONS vs ANALYTICAL FUNCTIONS

Aggregate Function: Aggregates data from several rows into a single result row. Returns one result per group (reduces the number of rows returned by the query).

```sql
--for example, i have 107 records in employees table
select * from employees

--if we do this

select avg(salary) sal_avg
from
employees

select department_id , avg(salary) sal_avg
from
employees
group by department_id
```

```txt
Analytic functions also operate on subsets of rows, similar to aggregate functions in GROUP BY queries, but they do not reduce the number of rows returned by the query.
Analytic Function Syntax:

  ANALYTIC_FUNCTION([ arguments ]) OVER (analytic_clause)

Example: RANK(sal) OVER (ORDER BY sal DESC)

The analytic_clause breaks down into the following optional elements:

  [ query_partition_clause ] [ order_by_clause [ windowing_clause ] ]

The windowing_clause is an extension of the order_by_clause and as such, it can only be used if an order_by_clause is present.
note: some Analytic functions require the order_by_clause, for example RANK or DENSE RANK

Functions followed by an asterisk (*) allow the full syntax, including the windowing_clause.
  *AVG*
  *CORR*
  *COUNT*
  *COVAR_POP*
  *COVAR_SAMP*
  CUME_DIST
  DENSE_RANK
  FIRST
  *FIRST_VALUE*
  LAG
  LAST
  *LAST_VALUE*
  LEAD
  LISTAGG
  *MAX*
  MEDIAN
  *MIN*
  *NTH_VALUE*
  NTILE
  PERCENT_RANK
  PERCENTILE_CONT
  PERCENTILE_DISC
  RANK
  RATIO_TO_REPORT
  *REGR_ (Linear Regression) Functions*
  ROW_NUMBER
  *STDDEV*
  *STDDEV_POP*
  *STDDEV_SAMP*
  *SUM*
  *VAR_POP*
  *VAR_SAMP*
  *VARIANCE*
```

```sql
-- EXAMPLES
-- this will throw an error because anytime we have columns along with an aggregate function, we need to put all those columns in a group by clause
select employee_id, first_name, salary, avg (salary)
from employees;

-- We can use the avg analytic function
-- if we omit the partition and order by clause then it operates on the entire table
select employee_id, first_name, salary, avg (salary) over () avg_sal
from employees

-- We can use subqueries to do the same as the analytic function
select employee_id, first_name, salary, (select avg (salary) from employees ) avg_sal
from employees

--the where will be exectued first, then Analytic function , then finaly the order by
select employee_id, first_name, salary, avg (salary) over () avg_sal
from employees
where first_name like 'A%'
order by employee_id

```

# THE WINDOWING CLAUSE

The windowing_clause gives some analytic functions further degree of control over the window within the current partition, or whole result set if no partitioning clause is used.

The windowing_clause is an extension of the order_by_clause, it can only be used if an order_by_clause is present.

The windowing_clause has two basic forms.

- RANGE BETWEEN start_point AND end_point
- ROWS BETWEEN start_point AND end_point

Possible values for "start_point" and "end_point" are:

- UNBOUNDED PRECEDING - The window starts at the first row of the partition, or the whole result set if no partitioning clause is used
  - (Only available for start points )
- UNBOUNDED FOLLOWING - The window end at the last row of the partition, or the whole result set if no partitioning clause is used
  - (Only available for end points )
- CURRENT ROW (Can be used as start or end point.)
- value_expr PRECEDING : A physical or logical offset before the current row using a constant or expression
- value_expr FOLLOWING : As above, but an offset after the current row

When using ROWS BETWEEN, you are indicating a specific number of rows relative to the current row,
either directly, or via an expression (number of rows is fixed in calculation)

When you use RANGE BETWEEN you are referring to a range of values in a specific column relative
to the value in the current row.

```txt
RANGE BETWEEN                    ROWS BETWEEN

salary     moving_avg            salary     moving_avg
------     ----------            ------     ----------
5000       5000                  5000       5000
6000       5500                  6000       5500
10000      8200                  10000      7000
10000      8200                  10000      7750
10000      8200                  10000      8200

RANGE calculates the average for the whole range plus the previous ranges. In the above example there are three ranges, 5000, 6000, and 10000.

ROWS calculates calculates the average for each row plus the previous rows.
```

As a result,Oracle doesn't know how many rows are included in the range until the ordered set is created.

```sql
-- We can use the window clause to calculate a moving avg, count, sum, etc.
--UNBOUNDED PRECEDING : The window starts at the first row of the partition, or the whole result set if no partitioning clause is used
select employee_id, first_name||' '||last_name, salary,
  avg(salary) over (order by EMPLOYEE_ID RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) moving_avg
from employees

-- RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW is the default.
-- This query is the same as the query above
select employee_id, first_name||' '||last_name, salary,
avg(salary) over (order by EMPLOYEE_ID ) moving_avg
from employees

-- MORE EXAMPLES

-- here the moving avg will be the same for every row because we use the entire table for each calculation
select val,
  sum(val) over(order by val RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING )
from test_windowing_clause

-- here the current range and the revious range are used for the calculation
select val,
  sum(val) over(order by val RANGE BETWEEN 1 PRECEDING AND CURRENT ROW )
from test_windowing_clause

-- here we use the current row and the preceding row for the calculation
select val,
  sum(val) over(order by val rows BETWEEN 1 PRECEDING AND CURRENT ROW )
from test_windowing_clause

-- here we use the current row, the preceding row, and the following row for the calculation
select val,
  sum(val) over(order by val rows BETWEEN 1 PRECEDING AND 1 FOLLOWING )
from test_windowing_clause
```
