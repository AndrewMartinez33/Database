Set Echo on 
set serveroutput on
spool D:hw7.txt

-- ALREADY ENROLLED IN COURSE
EXEC enroll.AddMe(101, 10110);

-- STUDENT# DOESN'T EXIST
EXEC enroll.AddMe(303, 10110);

-- CALL# DOESN'T EXIST
EXEC enroll.AddMe(101, 70110);

-- NO CAPACITY
EXEC enroll.AddMe(103, 10110);

-- OVER CREDIT LIMIT
EXEC enroll.AddMe(104, 10115);

spool off