# LABELING & GOTO

## Label

- Labels are location markers
- They can be placed anywhere within a block
- they are enclosed with angle brackets
- used for documentation and readability
- used as a reference point for the GOTO statement
- used as a reference point for nested programs

```sql
DECLARE
...
BEGIN
<<LabelName>>
...
-- the label cannot be the last statement in a PL SQL program
END;
```

## GOTO

A GOTO statement is simply a jump within program execution

- a valid label name must be specified as the target
- angle bracket are used to define the label only
- The GOTO statement simply identifies the name.

```sql
DECLARE
...
BEGIN
<<LabelName>>
...

GOTO LabelName;
END;
```

# LOOPS

```sql
-- INDEFINITE LOOP
LOOP
  -- Runs until there is an exception of exit
  EXIT or EXIT WHEN ... ;

  CONTINUE or CONTINUE WHEN;

END LOOP;

-- FIXED ITERATION LOOP
FOR i IN 1...1000 LOOP
...
END LOOP;

-- CONDITIONAL LOOP
WHILE condition LOOP
...

END LOOP;

-- NESTED LOOPS
WHILE condition LOOP
  FOR i IN 1...1000 LOOP

  END LOOP;

END LOOP;
```

# IF-THEN-ELSE

```sql
IF condition THEN
  ...
ELSIF condition THEN
  ...
ELSE
  ...
END IF;

-- NESTED IF-THEN-ELSE
IF condition THEN
  ...
ELSIF condition THEN
    IF condition THEN
    ...
    END IF;
ELSE
  ...
END IF;

```

# CASE STATEMENT

A case statement is perfect when many conditions are required

```sql
CASE birth_month
  WHEN 'JAN' THEN message := 'start of the year!';
  ...
  WHEN 'DEC' THEN message := 'end of the year!';
  ELSE message := 'No Comment';
END CASE;

```
