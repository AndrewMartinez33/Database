# SEQUENCES

- Sequences are an automated method of creating a unique value within a table
- Sequences may be referenced within the program just as any other database object
- Sequences are typically created for one field as the primary key managed by the database

```sql
CREATE SEQUENCE seq_name;

CREATE SEQUENCE seq_name START WITH 1000;

SELECT seq_name.Curr_Val FROM dual;

SELECT seq_name.Next_Val FROM dual;

INSERT INTO table VALUES (seq.Next_VaL, ...);

ALTER SEQUENCE item_seq MAXVALUE 100;

DROP SEQUENCE item_seq;
```
