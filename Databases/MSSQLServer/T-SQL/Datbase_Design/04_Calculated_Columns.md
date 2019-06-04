```sql
-- CREATING A TABLE WITH CALCULATED COLUMNS
CREATE TABLE dbo.Products (
    ProductID int IDENTITY(1,1) PRIMARY KEY,
    ProductName nvarchar(100) NOT NULL,
    ProductPrice smallmoney NOT NULL,
    ProductDiscount decimal(2,2) NOT NULL,
    -- computed column
    ProductExtendedPrice AS ProductPrice - (ProductPrice * ProductDiscount)
);
GO

-- The computed column is not listed here because it is automatically generated
INSERT dbo.Products
    VALUES  ('Mixed Nuts',3.99,.15),
            ('Shelled Peanuts',5.49,.10),
            ('Roasted Almonds',7.29,0);
GO


-- Computed columns CANNOT be used in other computed column definitions. This would throw an error because ProductExtendedPrice is a computed columns.
ALTER TABLE dbo.Products
    ADD TaxRate decimal(4,4) NOT NULL DEFAULT(.0875),
        TotalPrice AS (ProductExtendedPrice + (ProductExtendedPrice * TaxRate));
GO

-- Instead, we calculate TotalPrice from scratch
ALTER TABLE dbo.Products
    ADD TaxRate decimal(4,4) NOT NULL DEFAULT(.0875),
        TotalPrice AS (ProductPrice - (ProductPrice * ProductDiscount) + ((ProductPrice - (ProductPrice * ProductDiscount)) * TaxRate));
GO

-- CALCULATED COLUMN AS A PRIMARY KEY
-- we must use the PERSISTED keyword
-- This is because only unique or primary key constraints can be used on a computed column.
-- to use NOT NULL, CHECK, or FOREIGN KEY constraints, the computed column must be persisted.
-- PERSISTED specifies that the values will be physically stored in the table rather than creating them as virtual values.
CREATE TABLE dbo.Departments (
    DepartmentLocation char(2) NOT NULL,
    DepartmentCode char(3) NOT NULL,
    DepartmentID AS DepartmentLocation + '-' + DepartmentCode PERSISTED PRIMARY KEY NOT NULL
);
GO


```
