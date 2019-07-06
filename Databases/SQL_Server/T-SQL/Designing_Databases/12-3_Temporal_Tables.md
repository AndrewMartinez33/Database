# Temporal Tables

- New in 2016
- Maintain a history of all the changes that occur in a table
- You can easily query that history and see what the data looked liked at a specific point in time

Example

```sql
CREATE TABLE Inventory
(
  [InventoryID] int NOT NULL PRIMARY KEY CLUSTERED
  , [ItemName] nvarchar(100) NOT NULL
  -- Required for temporal tables: these exact three columns with these exact names and these exact datatypes.
  , [ValidFrom] datetime2 (2) GENERATED ALWAYS AS ROW START
  , [ValidTo] datetime2 (2) GENERATED ALWAYS AS ROW END
  , PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
 )
 WITH (SYSTEM_VERSIONING = ON); -- tells the machine to keep a history of this and use those special three columns to designate when each record was changed and what it contained before it was changed.



-- Time Traveling Query
-- Normal query BUT notice the FOR clause
SELECT [StockItemName]
FROM [WideWorldImporters].[Warehouse].[StockItems]
FOR SYSTEM_TIME AS OF '2015-01-01' -- what the data looked like as of this date.
WHERE StockItemName like '%shark%'
```
