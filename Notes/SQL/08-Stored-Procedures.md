# What is a Stored Procedure?

```sql
-- When we build applications we don't want to store our SQL code in the application code for a few reasons:
    -- 1. Writing SQL code in our application code can get very messy
    -- 2. If you write an application in a language like C# where you need to compile your code, if you need to make changed to your sql code you will need to recompile your application.
    -- 3. Data Security. We can remove direct access to tables and use stored procedures for INSERT UPDATE and DELETE operations
    -- 4. Faster Execution

-- Instead, we should store our SQL code in our database with Stored Procedures and Functions.
-- A Stored Procedure is a database object that containes a block of SQL code.
-- Stored Procedures store and organize our SQL code.

```

# Creating a Stored Procedure

```sql
-- in MySQL we need to change the default delimeter (;) to run the entire procedure as a single unit
-- Here we change the delimeter to $$
DELIMETER $$
CREATE PROCEDURE proc_name()
BEGIN
  -- body of stored procedure
  -- every statement in a stored procedure should end with a semi-colon. This is why we change the DELIMETER.
  SELECT * FROM clients;


-- here we use the new delimeter $$ to signify the end of the unit
END$$

-- don't forget to chnage the delimeter back to a semi-colon
DELIMETER ;


-- to call a procedure
CALL proc_name();
```

# Dropping Stored Procedures

```sql
DROP PROCEDURE IF EXISTS proc_name;

DELIMETER $$
CREATE PROCEDURE proc_name()
BEGIN
  SELECT * FROM clients;
END$$
DELIMETER ;

```

# Parameters

```sql
DELIMETER $$
CREATE PROCEDURE proc_name
(
  -- parameter name and type
  state CHAR(2)
)
BEGIN
  SELECT * FROM clients c
  -- now we can use out state parameter in our code
  WHERE c.state = state;
END$$
DELIMETER ;

-- in MySQL all parameters are required. You will get an error if you don't pass in a parameter.
CALL proc_name('CA');

```

# Parameters with Default Value

```sql
DELIMETER $$
CREATE PROCEDURE proc_name
(
  state CHAR(2)
)
BEGIN
  IF state IS NULL THEN
  -- we use SET to assign a default value to state
    SET state = 'CA';
  END IF;
  SELECT * FROM clients c
  WHERE c.state = state;
END$$
DELIMETER ;

-- call the procedure with NULL
CALL proc_name(NULL)

-- let's re-write the procedure above in a less verbose way
DELIMETER $$
CREATE PROCEDURE proc_name
(
  state CHAR(2)
)
BEGIN
  SELECT * FROM clients c
  WHERE c.state = IFNULL(state, 'CA');
END$$
DELIMETER ;
```

# Parameter Validation

```sql
-- We can use procedures to INSERT UPDATE and DELETE data. Because of this it is important to validate the data
-- that is passsed into the procedure. We can do this with IF statements.
-- NOTE: you want to keep validation to a bare minimum and most of your validation should be done on the application side.

DELIMETER $$
CREATE PROCEDURE proc_name
(
  invoice_id INT,
  payment_amount DECIMAL(9,2),
  payment_date DATE
)
BEGIN
  IF payment_amount <= 0 THEN
    -- SIGNAL is like throwing an error in programming languages
    -- you can google the error codes 'SQLSTATE errors'
    SIGNAL SQLSTATE '2203'
      SET MESSAGE_TEXT = 'Invalid Payment Amount';
  END IF;

  -- then the rest of your SQL code

END$$
DELIMETER ;


```

# Output Parameters

```sql


```

# Variables

```sql
-- we can use variables in our stored procedures as follows
DELIMETER $$
CREATE PROCEDURE proc_name()
BEGIN
  -- variables go directly after the begin statement
  -- we can choose to assign a default value
  DECLARE var_name_1 DECIMAL(9,2) DEFAULT 0;
  DECLARE var_name_2 DECIMAL(9,2);
  DECLARE var_name_3 INT;

  -- we can assign values to our variables using a SELECT statement
  -- the values will be assigned in order
  SELECT COUNT(*), SUM(invoice_total)
  INTO var_name_2, var_name_3
  FROM invoices;

  -- we can also SET the value of a variable
  SET var_name_1 = var_name_3 / var_name_2 * 5;

  SELECT var_name_1;

END$$
DELIMETER ;
```

# Functions

```sql
-- Functions return a single value. They DO NOT return tables or rows.
CREATE FUNCTION function_name
(
  func_param INT
)
RETURNS return_type
-- every function should have at least one attribute
-- Deterministic - if you pass in the same values, it will return the same value every time.
-- READS SQL DATA
-- MODIFIES SQL DATA -- insert update delete
DETERMINISTIC
BEGIN

  -- we must always return a value
  RETURN return_value;
END


-- lets look at an example
DELIMETER $$
CREATE FUNCTION get_risk_factor
(
  client_id INT
)
RETURNS INTEGER
READS SQL DATA
BEGIN
  DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
  DECLARE invoices_total DECIMAL(9,2);
  DECLARE invoices_count INT;

  SELECT COUNT(*), SUM(invoice_total)
  INTO invoices_count, invoices_total
  FROM invoices i
  WHERE i.client_id = client_id;

  SET risk_factor = invoices_total / invoices_count * 5;

  RETURN IFNULL(risk_factor, 0);

END$$

DELIMETER ;
```
