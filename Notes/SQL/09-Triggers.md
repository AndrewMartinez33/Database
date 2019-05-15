# Triggers

```sql
-- A trigger is a block of SQL code that gets executed before or after an insert, update, or delete statement.

-- IMPORTANT: triggers can be used on any table except the table that fires the trigger. Otherwise, it would create an infinite loop.

DELIMETER $$
-- the naming convention for triggers is as follows:
    -- tableName_beforeOrAfter_InsertOrUpdateOrDelete
    -- example: payments_after_insert

CREATE TRIGGER trigger_name
-- AFTER or BEFORE
-- INSERT or UPDATE or DELETE
  AFTER INSERT ON table_name
  FOR EACH ROW  -- fires for each row that is affected. Currently, MySQL does not support table level triggers where the trigger fires only once.
BEGIN
  -- we can write any sql code here
  UPDATE invoices
  -- the NEW keyword gives you the value in the new row
  -- we could also use the OLD keyword to get the previous values
  SET payment_total = payment_total + NEW.amount
  WHERE invoice_id = NEW.invoice_id;
END$$
DELIMETER ;
```

# Viewing Triggers

```sql
-- shows you all triggers in the database
SHOW TRIGGERS;

-- if you want to see all triggers for a particular table...
-- you can use the like keyword if you have used the naming covention shown above.
-- this will search for all triggers whose name starts with payments (which is the table name)
SHOW TRIGGERS LIKE 'payments%';

```

# Dropping Triggers

```sql
DROP TRIGGER IF EXISTS trigger_name;

DELIMETER $$
CREATE TRIGGER trigger_name
  AFTER INSERT ON table_name
  FOR EACH ROW
BEGIN
  UPDATE invoices
  SET payment_total = payment_total + NEW.amount
  WHERE invoice_id = NEW.invoice_id;
END$$
DELIMETER ;
```

# Viewing Triggers

```sql
-- shows you all triggers in the database
SHOW TRIGGERS;

-- if you want to see all triggers for a particular table...
-- you can use the like keyword if you have used the naming covention shown above.
-- this will search for all triggers whose name starts with payments (which is the table name)
SHOW TRIGGERS LIKE 'payments%';

```

# Using Triggers for Auditing

```sql
DROP TRIGGER IF EXISTS trigger_name;

DELIMETER $$
CREATE TRIGGER trigger_name
  AFTER INSERT ON table_name
  FOR EACH ROW
BEGIN
  UPDATE invoices
  SET payment_total = payment_total + NEW.amount
  WHERE invoice_id = NEW.invoice_id;

-- we can use triggers to log changes to the database by creating a general auditing table and logging the type of action
-- that occured, a timestamp NOW(), and the values that were affected.
  INSERT INTO payments_audit
  VALUES (NEW.client_id, NEW.date, NEW.amount, 'INSERT', NOW());
END$$
DELIMETER ;

```

# Events

```sql
-- An event is a task, or block of SQL code, that gets executed according to a schedule


-- before we can schedule an event we need to make sure that the MySQL event scheduler is turned on.
-- we can first check to see if the event_scheduler is on
SHOW VARIABLES LIKE 'event%';

-- if event_scheduler is off, we can set it to on
-- in some organizations the event_scheduler might be turned off to save system resources.
SET GLOBAL event_scheduler = ON;


-- create an event
DELIMETER $$
-- naming convention is to start with the interval: yearly, daily, monthly
CREATE EVENT interval_event_name
ON SCHEDULE
  -- use AT if you only want to run once
  AT '2019-05-01'
  -- otherwise use EVERY and the interval: YEAR, MONTH, DAY, HOUR...
  EVERY 1 YEAR
  -- You can optionally set a start date and end date
  EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN
  -- whatever it is that you want to do

END$$
DELIMETER;
```

# Viewing, Dropping, Altering Events

```sql
SHOW EVENTS;
SHOW EVENT LIKE 'yearly%';

DROP EVENT IF EXISTS event_name;

-- to alter event
DELIMETER $$
ALTER EVENT interval_event_name
ON SCHEDULE
  EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN
  -- ALTER whatever you want
END$$
DELIMETER;

-- we can also use ALTER to disable or enable an event.
ALTER EVENT event_name DISABLE;
ALTER EVENT event_name ENABLE;
```
