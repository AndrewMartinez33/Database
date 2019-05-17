# String Types

```SQL
-- CHAR(X)        fixed-length
-- VARCHAR(X)     max 65,535 characters (~64kb)
-- MEDIUMTEXT     max: 16 million characters (16MB)  -- this is enough for a medium sized book
-- LONGTEXT       max: 4GB
-- TINYTEXT       max: 255 characters (255 bytes)
-- TEXT           max: 64KB    -- use varchar instead because varchar can be indexed

```

# Integer Types

```SQL
-- TINYINT            max: 1b   [-128 to 127]
-- UNSIGNED TINYINT             [0 to 255]   -- does not store negative numbers
-- SMALLINT           max: 2b   [-32k to 32k]
-- MEDIUMINT          max: 3b   [-8M to 8M]
-- INT                max: 4b   [-2B to 2B]
-- BIGINT             max: 8b   [-9Z to 9Z]

-- Zerofill - we can pad our numbers with zeroes so that they always have the same number of digits
INT(4)  -- 0001 - will always have 4 digits

-- BEST PRACTICE
-- use the smallest data type that suits your needs

```

# Fixed-Point and Floating Point Types

```SQL
-- DECIMAL(precision, scale)    fixed number of digits. Precision is the maximum number of digits (1 to 65). Scale is the number of digits after the decimal.
-- DEC          - this is exactly the same as DECIMAL. Just stick to decimal
-- NUMERIC      - this is exactly the same as DECIMAL. Just stick to decimal
-- FIXED        - this is exactly the same as DECIMAL. Just stick to decimal

-- Float and Double are used in scientific calculations. You can use them when you need to use very large or very small numbers, but they are not exact. They use approximations.
-- FLOAT        max: 4b
-- DOUBLE       max: 8b

```

# Boolean Types

```SQL
-- Boolean types represent True and false, but Bool/ Boolean is a synonym for TINYINT.
-- Under the hood True and False are internally represented as 1 and 0

-- BOOL
-- BOOLEAN


```

# Enum and Set Types

```SQL
-- you can restrict the values for a column by using ENUM
ENUM('list', 'of', 'values')  -- these are the only values allowed to be inserted in this column.

-- ENUM types are not recommended because they can be costly. Imagine you have a list of sizes.
-- Then, you want to add another size 'x-large'.
-- This is costly because the database must rebuild the table. Now imagine you has millions of records!
-- A better option is to build a lookup table of all the sizes.
ENUM('small','medium','large')

```

# Date and Time Types

```SQL
-- DATE         - date without the time component
-- TIME         - time value
-- DATETIME     - 8b
-- TIMESTAMP    - 4b (up to the year 2038)  if you want to use a date later than 2038, use DATETIME
-- YEAR         - a 4 digit year

```

# Blob Types

```SQL
-- TINYBLOB      for storing binary data up to 255b
-- BLOB          for storing binary data up to 65KB
-- MEDIUMBLOB    for storing binary data up to 16MB
-- LONGBLOB      for storing binary data up to 4GB

-- Databases are designed to store structured relational data. It is not recommended to store you files (images) in the database.
-- There are a few problems with storing images in the database:
    -- 1. Quickly increases the database size
    -- 2. slower backups
    -- 3. performance problems
    -- 4. more code to read/write images
```

# JSON Types

```SQL
-- JSON is a lightweight format for storing and transferring data over the internet
UPDATE products
SET properties = '
{
  "dimensions": [1,2,3],
  "weight": 10,
  "manufacturer": {"name": "sony"}
}
'
WHERE product_id = 1;

-- In MySQL we can also use the JSON OBJECT function to write JSON
UPDATE products
SET properties = JSON_OBJECT(
  'weight', 10,
  'dimensions', JSON_ARRAY(1,2,3),
  'manufacturer', JSON_OBJECT('name', 'sony')
)
WHERE product_id = 1;


-- we can extract individual key value pairs from a JSON object
SELECT product_id, JSON_EXTRACT(properties, '$.weight') AS weight
FROM products
WHERE product_id = 1;

-- we can use even shorter syntax to extract
-- we use the column pass operator (->) instead of the JSON Extract function
SELECT product_id, properties -> '$.weight' AS weight
FROM products
WHERE product_id = 1;

-- we can access arrays with square brackets
SELECT product_id, properties -> '$.dimensions[index_position]' AS weight
FROM products
WHERE product_id = 1;

-- we can access properties of nested objects
SELECT product_id, properties -> '$.manufacturer.key_name' AS weight  -- this returns the value with double quotes "sony"
FROM products
WHERE product_id = 1;

-- if we want to get rid of the double quotes, we can use the colum pass operator with a secone > symbol
SELECT product_id, properties ->> '$.manufacturer.key_name' AS weight  -- this returns the value without double quotes -- sony
FROM products
WHERE product_id = 1;

```
