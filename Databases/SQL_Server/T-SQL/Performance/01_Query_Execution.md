# What Happens When You Execute a Query?

1. SQL Server is going to parse the syntax of your query. This is a basic check just to make sure all of the objects that are referenced in your query exist and you have valid syntax.

2. SQL Server is going to check its query plan cache. A query plan cache is where SQL Server stores execution plans that have been generated already. It's a very expensive process from a performance perspective to generate an execution plan. So if SQL Server has already generated a plan, it's going to try to re-use that plan. If not, it's going to generate a plan.

## What Are Execution Plans?

An execution plan is a road map that will show how the data is retrieved and what various operations it needs to perform to retrieve the data to service your query.

- Every time you execute a query, the optimizer uses a path of operations to retrieve your data
- The optimizer also collects statistics about the operation and execution of this plan
- Plans are generated once and then cached
- The database engine stores these plans as XML

## How are Query Plans Generated?

- The first time you run a given query, the optimizer generates several plans and chooses the one with the lowest overall cost.
- The cost is a blended measure of how much resource consumption the optimizer thinks will be needed ti complete the query. The cost is a measure of how much cpu, IO, and memory required to service that given query.
- The optimizer uses settings and columns and table statistics to generate the best plans for a query
- Generating plans are very performance intensive, so plans are cached after initial generation.

# Reading Execution Plans

There are two types of execution plans: Estimated and Actual.

## Estimated vs. Actual plans

- You can generate an estimated plan without actually running the query. So you don't have to wait for the results to take place. The optimizer will simply compile the query and generate an execution plan.
- The actual plan has more data included with it in terms of statistics about actual versus estimated rows returned by the plan, and this is a key understanding because sometimes you need to look at the actual plan to understand if you have a problem with your statistics or some assumptions the optimizer is making.
- The plans themselves will nearly always be the same
- The Actual plan will have the statistics
- Rarely, the storage engine may choose a different actual plan

## How to Read an Execution Plan

- Plans should be read from right to left and top to bottom
- The size of the arrows connecting the objects is representative of the amount of data flowing to the next operator
- Each operator contains a lot of metadata in its properties and tool tip (this is where you can learn how the decisions were made)
- All operators are assigned a cost
- Even operators that have a 0% cost have some degree of cost - nothing is free in SQL Server execution
