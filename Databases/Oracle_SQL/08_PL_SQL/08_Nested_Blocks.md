# NESTED BLOCKS

As the size and complexity of your programs increase, a more advanced way of organizing the code becomes essential.

A Nested Block is a complete PL/SQL program block enclosed within the BEGIN section of another block

- Nested Blocks are helpful in enclosing SELECT or other statements that may generate an exception. The exception is handled by the inner block and then control reverts back to the outer block and the program continues.

```sql
<<MainBlock>>
DECLARE
  -- variables declared here are available to the inner block
...
BEGIN

  <<InnerBlock>>
  BEGIN
    ...
  EXCEPTION
    WHEN OTHERS THEN
      RAISE NoIdea;   -- this goes to the EXCEPTION in the outer block
    ...
  END InnerBlock;
EXCEPTION
  WHEN NoIdea THEN
    do something;
...
END MainBlock;
```

## Rules for Nested Block

- The boundaries of inner and outer blocks are identified using LABELS and the END statement.
- A maximum of 200 Nested Blocks may be created
- The Nested Blocks may NOT begin within the DECLARE clause of the enclosing block
- A Nested Block may only begin within the BEGIN or EXCEPTION clause of the enclosing block
- Nested block can use variables declared in the outer block

# GLOBAL vs LOCAL OBJECTS

When using Nested Blocks, the declared objects within the different block become either global or local

- Global - Any objects declared in the Outer Block are global
- Local - Any declarations made within the Inner Block are local and only visible to the Inner Block.
- Object name may be reused as local objects within inner blocks

## Global vs Local Exceptions

- All exceptions are considered local
- The system looks for the exception clause within that block
- If no exception clause is found, the system branches out to the Outer Block
- If no exception clause is found in the outermost block, the program terminates
- When the Exception is handled in an Inner Block, you may consider it partially handled
- You can use the RAISE statement to branch the exception in the manner you wish. When you RAISE the event, it goes to the EXCEPTION in the Outer Block
