# NTILE FUNCTION

The NTILE analytic function allows you to break a result set into a specified number of approximately equal groups.

```sql
NTILE(expr) OVER ([ query_partition_clause ] order_by_clause)

-- EXAMPLE
-- suppose the table has 12 students
-- Here we split the rows into 4 groups, based on the name.
SELECT student_id, name,
  NTILE(4) OVER(ORDER BY name ) group
FROM class_list;
```

RESULT: since there are 12 students, they are split into four groups of 3. Each group is numbered 1-4.

```txt
id   name     group
--   ------   -----
2    Alexis    1
4    Ali       1
1    David     1
5    Ford      2
3    Khaled    2
9    Leen      2
6    Max       3
11   Mazen     3
7    Noor      3
12   Randi     4
10   Sajed     4
8    Sara      4
```

```sql
-- Adding two more students, we no
insert into class_list values (13,'Fatima');
insert into class_list values (14,'Aya');

SELECT student_id, name,
  NTILE(4) OVER(ORDER BY name ) group
FROM class_list;
```

RESULT: We now have 14 rows. 12 rows are split equally amongst the 4 groups, but the extra rows are then added to each group one by one until there are none left.

```txt
id   name     group
--   ------   -----
2    Alexis    1
4    Ali       1
14   Aya       1  -- first extra row is added to group 1
1    David     1
13   Fatima    2  -- second extra row is added to group 2
5    Ford      2
3    Khaled    2
9    Leen      2
6    Max       3
11   Mazen     3
7    Noor      3
12   Randi     4
10   Sajed     4
8    Sara      4
```
