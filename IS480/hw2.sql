set echo on
spool D:hw2.txt
-- Andrew Martinez
-- IS 480
-- HW # 2


--4.6
-- Semester is coded as Sp for spring, Fa for fall, Su1 for summer 1, 
-- Su3 for summer 3. However, when you sort by year, semester, you
-- will get Fa first, then Sp, then Su1, then Su1 and Su2. The users
-- would like to see it displayed in the order of Sp, Su1, Su3, Fa,
-- for a given year. Write a SQL command to display Schedule of 
-- Classes records where the semester is sorted by the order specified
-- by the users.

SELECT *
FROM SchClasses
ORDER BY DECODE(Semester, 'Sp', 1, 'Su1', 2, 'Su2', 3, 'Su3', 4, 'Fa', 6, 'Wi', 7, 8);



--4.7 #2
SELECT TransNum, TransDate, AcctNum, DECODE(TransType, 'Credit', Amount, 0) Credit, 
DECODE(TransType, 'Debit', Amount, 0) Debit
FROM Trans;




--4.10 #5
-- Write a SQL statement to display the portion of text after '@' and
-- and before the '.'
SELECT substr(Emails, instr(Emails, '@') + 1, instr(Emails, '.') - instr(Emails, '@') -1) "HostName"
FROM StudentEmails;


--4.11 #1
-- Write a SQL command to display the remainder of 7 divided by 2 (ie.1)
SELECT MOD(7,2) "Remainder"
FROM DUAL;


--4.11 #2
-- Write a SQL command to display the integer portion of 7 divided by 2 (ie.3)
SELECT TRUNC(7/2) "Integer Portion"
FROM DUAL;


--4.11 #3
-- Write a SQL command to display the rounded result of 7 divided by 2 (ie.4)
SELECT ROUND(7/2) "Rounded"
FROM DUAL;

spool off