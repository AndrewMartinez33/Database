# USER-DEFINED EVENTS

User-Defined events are not internal errors. However, they are an effective way to create business rules for your programs.

Steps to create events as an exception:

1. Within DECLARE, assign a name to EXCEPTION
2. Within BEGIN, create a condition to RAISE the EXCEPTION
3. Within EXCEPTION, handle the exception as desired

```sql
DECLARE
  ...
  not_enough_funds EXCEPTION;
BEGIN
  ...
  IF vfunds = 0 THEN
    RAISE not_enough_funds;

  END IF;

EXCEPTION
  WHEN not_enough_funds THEN
    DBMS_OUTPUT.PUT_LINE('Not enough funds for the transaction');
END;
```
