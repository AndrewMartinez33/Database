# String Functions

```sql
LENGTH(string) -- returns number of characters in a string
UPPER(string) -- returns string in upper case
LOWER(string) -- returns string in lower case
LTRIM(string) -- removes white space on the left of the string
RTRIM(string) -- removes white space on the right of the string
TRIM(string)  -- removes white space on either side of the string
LEFT(string, number_of_chars) -- returns specified number of characters from the left side of the string
RIGHT(string, number_of_chars) -- returns specified number of characters from the right side of the string
SUBSTR(string, start, length) -- returns substring from the start posiition to the length specifies. The length begins at the start position. if length is not specified, the substring from the start position to the end is returned
REPLACE(string, string_to_replace, replacement_string)
CONCAT(string1, string2,...stringN) -- concatenates string that are passed in

```
