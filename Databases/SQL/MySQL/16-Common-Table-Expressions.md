# What is a Common Table Expression?

A common table expression is a named temporary result set that exists only within the execution scope of a single SQL statement e.g.,SELECT, INSERT, UPDATE, or DELETE.

Similar to a derived table, a CTE is not stored as an object and last only during the execution of a query. Different from a derived table, a CTE can be self-referencing (a recursive CTE) or can be referenced multiple times in the same query. In addition, a CTE provides better readability and performance in comparison with a derived table.

The structure of a CTE includes the name, an optional column list, and a query that defines the CTE. After the CTE is defined, you can use it like a view in a SELECT, INSERT, UPDATE, DELETE, or CREATE VIEW statement.

```sql
-- the column list is optional, but if used the number of columns in the query must be the same as the number of columns in the column_list. If you omit the column_list, the CTE will use the column list of the query that defines the CTE
WITH cte_name (column_list) AS (
    your_query
)
SELECT * FROM cte_name;

-- Example
WITH salesrep AS (
    SELECT
        employeeNumber,
        CONCAT(firstName, ' ', lastName) AS salesrepName
    FROM
        employees
    WHERE
        jobTitle = 'Sales Rep'
),
customer_salesrep AS (
    SELECT
        customerName, salesrepName
    FROM
        customers
            INNER JOIN
        salesrep ON employeeNumber = salesrepEmployeeNumber
)
SELECT
    *
FROM
    customer_salesrep
ORDER BY customerName;

```

# Recursive CTE
