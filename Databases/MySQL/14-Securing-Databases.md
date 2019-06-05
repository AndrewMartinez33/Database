# Creating a User

```sql
-- new user
CREATE USER john -- john can connect from anywhere
-- we can restrict where a user can connect from
CREATE USER john@127.0.0.1  -- in this case user can only log on from the computer where MySQL is installed
CREATE USER john@drewskidev.com  -- can connect from this domain
CREATE USER john@'%.drewskidev.com'  -- can connect from any subdomain

-- we need to supply a password
CREATE USER john INDENTIFIED BY 'strong_password';

```

# Viewing Users

```sql
-- this will show you the users and their privileges
SELECT * FROM mysql.user;

```

# Dropping Users

```sql
DROP USER user_name@host_name;
DROP USER bob@drewskidev.com;

```

# Changing Passwords

```sql
SET PASSWORD FOR user_name = 'new_strong_password';

-- change for current user
SET PASSWORD = 'new_strong_password';

```

# Granting Privileges

Search for MySQL privileges to see all the privileges provided in MySQL

```sql
-- Scenario 1: web/desktop application
-- read, write privileges
CREATE USER my_app IDENTIFIED BY 'strong_password';

GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON database_name.*   -- or database_name.table_name
TO my_app;

-- Scenario 2: admin
-- all privileges
GRANT ALL
ON *.*  -- all tables in all databases
TO john;

```

# Viewing Privileges

```sql
SHOW GRANTS FOR john;

-- for current user
SHOW GRANTS;

```

# Revoking Privileges

```sql
REVOKE privilege_name
ON database_name.*   -- or database_name.table_name
FROM user_name;

-- IMPORTANT: Always grant the minimum required privileges

```
