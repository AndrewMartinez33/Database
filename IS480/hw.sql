-- Exercises 1.2

-- 1. Use SQL commands to see which tables you have.
SELECT table_name 
FROM user_tables;

-- 2. Use SQL commands to display table structure of the tables: Students, Enrollments, SchClasses. 
DESC Students;
DESC Enrollments;
DESC SchClasses;

-- 3. Use SQL commands to display data in the following tables: Students, Enrollments, SchClasses. 
SELECT * 
FROM Students;

SELECT * 
FROM Enrollments;

SELECT * 
FROM SchClasses;

-- 4. Insert a new student record to the STUDENTS table. The student's Snum is 107, name is George, he has not declared a major and he has no GPA (leave them null). 

-- insert into students values('107', 'George', 1, Null, Null, Null);

-- 5. Display the SName and Major 
--    columns of the Students table.
SELECT SName, Major
FROM Students; 

-- 6. Update student 102’s GPA to 4.0 and major to 'IS'. 

-- Update Students set GPA=4.0, Major='IS'
-- where SNUM = '102';


-- 7. Save the previous update.
commit;


-- 8. Delete all enrollment records of student 101. 
DELETE
FROM Enrollments
WHERE SNUM = '101';


-- 9. “Undo” the previous deletion. 
ROLLBACK;

-- 10. Display the name of students who were enrolled in 2009 ‘Sp’.
SELECT S.SName
FROM Students S, Enrollments E, SchClasses SC
WHERE SC.CallNum = E.Callnum
AND S.SNum = E.SNum
AND SC.Semester = 'Sp'
AND SC.Year = '2013';

-- 11. Display Snum, Sname, and Callnum of enrollments where no grade is assigned (grade is null).
SELECT S.SNum, SName, CallNum
FROM Students S, Enrollments E
WHERE S.SNum = E.SNum
AND NVL(Grade, 'Null') = 'Null';

-- 12. Display grade that student 101 received from taking IS 300 during Spring 2009. 
SELECT E.Grade
FROM Enrollments E, SchClasses SC
WHERE E.Callnum = SC.Callnum
AND SC.CNum = '300'
AND SC.Dept = 'IS'
AND E.SNum = '101';


-- 13. Display Callnum, Dept, and Cnum of courses that student 102 has received an "A" from. 

SELECT E.Callnum, SC.Dept, SC.Cnum
FROM Enrollments E, SchClasses SC
WHERE E.Callnum = SC.Callnum
AND E.Snum = '102'
AND E.Grade = 'A';

-- 14. Display students whose name start with 'C'.
SELECT SNum, SName
FROM Students
WHERE SUBSTR(SName,1,1) = 'C';






-- Exercises 2.1
 
-- 1. Display SName and Major of students who are enrolled in IS 300 courses during Spring 2013. 
SELECT S.SName, S.Major
FROM Students S, Enrollments E, SchClasses SC
WHERE S.SNum = E.SNum
AND E.CallNum = SC.Callnum
AND SC.Dept = 'IS'
AND SC.CNum = '300'
AND SC.Year = '2013';

-- 2. Display SName and Major of students who are enrolled in IS 300 courses during Spring 2013, who are not IS major. 
SELECT S.SName, S.Major
FROM Students S, Enrollments E, Schclasses SC
WHERE S.SNum = E.SNum
AND E.CallNum = SC.CallNum
AND SC.Semester = 'Sp'
AND SC.Year = '2013'
AND Dept = 'IS'
AND CNum = '300'
AND NVL(S.Major, 'none') != 'IS';


-- 3. Display Dept, Cnum, Title of courses student 101 took during Spring 2013.
SELECT C.Dept, C.CNum, C.CTitle
FROM Courses C, Enrollments E, SchClasses SC
WHERE E.CallNum = SC.CallNum
AND C.CNum = SC.CNum
AND E.SNum = '101'
AND SC.Semester = 'Sp'
AND SC.Year = '2013';

 
-- 4. Andy has taken IS 300 several times. Display the year, semester, and grade where he took IS 300.
SELECT SC.Year, SC.Semester, E.Grade
FROM SchClasses SC, Enrollments E
WHERE SC.CallNum = E.CallNum
AND SC.Dept = 'IS'
AND SC.CNum = '300'
AND E.SNum = '101';

 
-- 5. Display Sname of students who received an “A” in IS 300 and who is not an IS major.

SELECT SNAME
FROM Students S, SchClasses SC, Enrollments E
WHERE GRADE = 'A' AND NVL(MAJOR, 'None') != 'IS'
AND DEPT = 'IS'
AND SC.CNUM = 300
AND S.SNUM = E.SNUM
AND SC.Callnum = E.Callnum;
 
-- 6. A student is interested in taking IS 380, and he’d like to know what are the prerequisites of IS 380. Write a query to display Dept, CNum, and Title of those prerequisite courses. 
SELECT C.CNum, C.CTitle
FROM Courses C,  Prereq P
WHERE P.PCNum = C.CNum
AND P.CNum = '380';







-- Exercises 2.2

-- 1. Display the number of times each supplier supplies parts, sorted by the highest number to the lowest.
SELECT S#, COUNT(S#) Supplied
FROM SP
GROUP BY S#
ORDER BY Supplied DESC;

-- 2. Display the number of times each supplier supplies parts, sorted by the supplier's number.
SELECT S#, COUNT(S#) Supplied
FROM SP
GROUP BY S#
ORDER BY S#;


-- 3. Display the average quantity each supplier supplies parts.
SELECT S#, ROUND(AVG(QTY),2) "AvgQTY"
FROM SP
GROUP BY S#
ORDER BY S#; 


-- 4. Display the total quantity each supplier supplies parts. 
SELECT S#, SUM(QTY) "TotalQTY"
FROM SP
GROUP BY S#
ORDER BY S#;


-- 5. Display the number of times each part has been supplied.
SELECT P#, COUNT(P#) "Supplied"
FROM SP
GROUP BY P#
ORDER BY P#;

-- 6. Display the number of times each part has been supplied, sorted by the highest number to the lowest. 
SELECT P#, COUNT(P#) "Supplied"
FROM SP
GROUP BY P#
ORDER BY Supplied DESC;

-- 7. Display the average quantity that each part has been supplied. 
SELECT P#, AVG(QTY) "AvgSupplied"
FROM SP
GROUP BY P#
ORDER BY P#;

-- 8. Display the total quantity each part has been supplied, sorted by part number. 
SELECT P#, SUM(QTY) "TotalSupplied"
FROM SP
GROUP BY P#
ORDER BY P#;

-- 9. Display the total quantity supplied by S1. 
SELECT S#, SUM(QTY) "TotalSupplied"
FROM SP
GROUP BY S#
HAVING S# = 'S1';

-- 10. Display the highest and lowest quantity supplied by each supplier. 
SELECT S#, MAX(QTY) "GreatestQTY", MIN(QTY) "LowestQTY"
FROM SP
GROUP BY S#
ORDER BY S#;

-- 11. Display suppliers whose average quantity is less or equal to 250.
SELECT SNAME
FROM S
WHERE S# in (SELECT S#
			FROM SP
			GROUP BY S#
			HAVING AVG(QTY) <= 250);
				







-- Exercise 3.1

-- 1. Display courses (dept, cnum) that has no prerequisites.
SELECT Dept, CNum
FROM Courses
MINUS
SELECT Dept, CNum
FROM Prereq; 

-- 2. Display students who have taken both IS 380 and IS 385.  
SELECT S.SName
FROM Students S, Enrollments E, SchClasses SC
WHERE S.SNum = E.SNum
AND E.CallNum = SC.CallNum
AND SC.Dept = 'IS'
AND SC.CNum = '380'
INTERSECT
SELECT S.SName
FROM Students S, Enrollments E, SchClasses SC
WHERE S.SNum = E.SNum
AND E.CallNum = SC.CallNum
AND SC.Dept = 'IS'
AND SC.CNum = '385';



-- 3. Display students who have taken IS 380 but never took IS 300.
SELECT SNAME
FROM Students
WHERE SNUM IN (
	(SELECT SNUM
		FROM Enrollments E, SchClasses SC
		WHERE E.Callnum = SC.Callnum
		AND DEPT = 'IS'
		AND CNUM = '380')
	MINUS
	(SELECT SNUM
		FROM Enrollments E, SchClasses SC
		WHERE E.Callnum = SC.Callnum 
		AND DEPT = 'IS'
		AND CNUM = '300'));

-- 4. Display students who have taken IS 380 but who is not a IS major.

SELECT S.SName
FROM Students S, Enrollments E, SchClasses SC 
WHERE S.SNum = E.SNum
AND E.CallNum = SC.CallNum
AND NVL(S.Major, 'none') != 'IS'
AND SC.Dept = 'IS'
AND SC.CNum = '380'; 






-- Exercise 4.1

-- (Note that there are NULL values in the table) 

-- 1. Write a SQL statement to display SNum, SName, and Major. If major is NULL, display ‘Undeclared’. 
SELECT SNum, SName, NVL(Major, 'Undeclared') "Major"
FROM Students;

-- 2. Write a SQL statement to display students and their major GPA. If major GPA is null, display 0.
SELECT SName "Name", NVL(MAJOR_GPA, 0) "MajorGPA"
FROM Students;


-- 3. Write a SQL statement to display students who are not IS major (note: some students have NULL major, and they are “not” IS major).
SELECT SName
FROM Students
WHERE NVL(Major, 'Undeclared') != 'IS';


-- 4. Write a SQL statement to display students whose MajorGPA is lower than 3 (note: some students have NULL MajorGPA, and we consider their MajorGPA “lower” than 3)
SELECT SNAME
FROM Students
WHERE NVL(Major_GPA, 0) < 3;






-- Exercise 4.2

-- 1. For each student, display SNum, SName, and the higher of his GPA and MajorGPA. 
SELECT SNum, SName, NVL(GREATEST(GPA, MAJOR_GPA), 0) "HigherGPA"
FROM Students;

-- 2. For each student, display SNum, SName, and the lower of his GPA and MajorGPA. 
SELECT SNum, SName, NVL(LEAST(GPA, MAJOR_GPA), 0) "LowerGPA"
FROM Students;

-- Note: How about “Of all students, display the highest GPA?”
SELECT SNum, SName, GPA
FROM Students
WHERE GPA IN (Select MAX(GPA) FROM Students);

 


-- Exercise 4.3

-- CPE stands for “Computer Proficiency Exam.” There are 4 modules of the CPE exam: Word, Excel, Access, and PowerPoint. A student needs to receive at least 70 (out of 100) on every module in order to pass CPE. In other words, if a student receives 100 on 3 modules but 60 on the 4th module, he did not pass CPE. 
 
-- 1. Write one SQL statement to display students (snum, sname) who have passed CPE.
SELECT SNum, SName 
FROM Student_CPEs
WHERE LEAST(Word, Excel, Access, PowerPoint) >= 70; 

-- 2. Write one SQL statement to display students (snum, sname) who did not pass CPE.
SELECT SNum, SName
FROM Student_CPEs
WHERE LEAST(Word, Excel, Access, PowerPoint) < 70;





-- Exercise 4.4

-- 1. Each customer has an AccountBalance. Usually we sent them a BillDue for the account balance; however, if the account balance is less than 0 (meaning, they have a credit with us), then we send them a BillDue of 0 (in other words, BillDue cannot be lower than 0). Write one SQL statement to display the BillDue for each customer.
SELECT CName, GREATEST(Account_Balance, 0) "BillDue"
FROM Customers;



-- 2. Each customer has an total mileage with us. However, they can use at most 1,000 miles each time. Write a SQL statement to display customer number, name, and their usable mileage at this time (ie, usable mileage cannot go over 1,000).
SELECT CNUM, CNAME, LEAST(TOTALMILEAGE, 1000) "Usable_Mileage"
FROM CUSTOMERS;






-- Exercise 4.5

-- Write a SQL statement to display student and their standing; if standing is 4, then display “Senior”; if it is 3 then display “Junior”; 2 then “Sophomore”, and 1 then “Freshman”.  If it is not 1-4, then print “Others”.
SELECT SNum, SName, DECODE(Standing, 1, 'Freshman', 2, 'Sophomore', 3, 'Junior', 4, 'Senior', 'Others') "Standing"
FROM Students;






-- Exercise 4.6

-- Semester is coded as Sp for spring, Fa for Fall, Su1 for Summer I, Su3 for Summer III. However, when you sort by year, semester, you will get Fa first, then Sp, then Su1 and Su2. The users would like to see it displayed in the order of Sp, Su1, Su3, Fa, for a given year. 

-- Write a SQL command to display Schedule of Classes records where the semester is sorted by the order specified by the users

SELECT *
FROM SchClasses
ORDER BY DECODE(Semester, 'Sp', 1, 'Su1', 2, 'Su2', 3, 'Fa', 4);






-- Exercise 4.7

-- Look at Notes

-- 1.
SELECT TransNum, TransDate, AcctNum, DECODE(TransType, 'Credit', Amount, 'Debit', (Amount * -1)) "Amount"
FROM Trans;

-- 2.
SELECT TransNum, TransDate, AcctNum, DECODE(TransType, 'Credit', Amount, 'Debit', 0) Credit, 
DECODE(TransType, 'Credit', 0, 'Debit', Amount) Debit
FROM Trans;






-- Exercise 4.8

-- The STUDENTS table has three columns: SSN, LASTNAME, and USERNAME. 

 
-- 1. Write one SQL statement to display the last character of every student's last name.
SELECT SUBSTR(LastName, -1)
FROM Students; 

 
-- 2. A student's username starts with the letter 'Z', followed by the first 2 letters of his last name, and the last 4 digits of his SSN. Currently the USERNAME column is null. Write an SQL statement to populate the USERNAME column.

UPDATE Students SET Username = 'Z'||(SELECT SUBSTR(LASTNAME, 1, 2) FROM Students)||(SELECT SUBSTR(SSN, -4) FROM Students));
commit;




-- Exercise 4.9

-- Each account has an AcctNum. There is always a '-' in the account number, but the position differs by account.  

 
-- 1. Write one SQL statement to display the position of '-' in AcctNum.
SELECT INSTR(AcctNum, '-') "Position"
FROM Trans;



-- 2. What does the following code return? select substr(AcctNum, 1, instr(AcctNum,'-')-1) from Accounts; 

--######## The first part of the ACCT# from the first digit up to (included) the digit before the dash.


-- 3. Write one SQL statement to display the portion of text after '-' . 
SELECT SUBSTR(AcctNum, INSTR(ACCTNUM, '-') + 1)
FROM Accounts;

 
-- 4. Prefix is the portion of the account number before the '-' and suffix is the portion after the '-'. Write one SQL command to populate the prefix and suffix columns.   
UPDATE Accounts SET Prefix = (SELECT SUBSTR(AcctNum, 1, INSTR(ACCTNUM, '-') -1) FROM Accounts),
					Suffix = (SELECT SUBSTR(AcctNum, INSTR(ACCTNUM, '-') + 1) FROM Accounts);


-- 5. Write one SQL command to display account_number without '-'. (In other words, if the account_number is 123456, then display 123456; if it is 72-8597, then display 728597).
SELECT SUBSTR(AcctNum, 1, INSTR(ACCTNUM, '-') -1)|| SUBSTR(AcctNum, INSTR(AcctNum, '-') + 1) "NewNumber"
FROM Accounts;





-- Exercise 4.10

-- Each student has a name. There is a ‘ ’ (space) separating the first name and last name. (Note that there is a space after comma).

-- 1. Write a SQL statement to populate the last name of each student. 
UPDATE StudentEmails SET LastName = (SELECT SUBSTR(SNAME, INSTR(SName, ' ') + 1) FROM StudentEmails);
commit;

-- 2. Write a SQL statement to populate the first name of each student. 
UPDATE StudentEmails SET FirstName = (SELECT SUBSTR(SNAME, 1, INSTR(SName, ' ') - 1) FROM StudentEmails); 
commit;


-- Each student has an email address.  
-- 3. Write a SQL statement to display the portion of text before the ‘@’ sign (ie, the username). 
SELECT SUBSTR(Emails, 1, INSTR(Emails, '@') - 1) 
FROM StudentEmails;


-- 4. Write a SQL statement to populate/update the portion of text before the ‘@’ sign to the Username column. 
UPDATE StudentEmails SET UserName = (SELECT SUBSTR(Emails, 1, INSTR(Emails, '@') - 1) 
FROM StudentEmails); 

-- 5. Write a SQL statement to display the portion of text after ‘@’ and before ‘.’. 
SELECT substr(Emails, instr(Emails, '@') + 1, instr(Emails, '.') - instr(Emails, '@') - 1) HOST
FROM StudentEmails;


-- 6. Write a SQL statement to populate/update the portion of text between ‘@’ and ‘.’ to the EmailHost column.
UPDATE StudentEmails SET Host = (SELECT substr(Emails, instr(Emails, '@') + 1, instr(Emails, '.') - instr(Emails, '@') - 1);
commit;





-- Exercise 4.11

-- Use select ... from dual;  for the following three questions. 
 
-- 1. Write a SQL command to display the remainder of 7 divided by 2 (ie, 1).
SELECT MOD(7,2) Remainder
FROM DUAL;  
 
-- 2. Write a SQL command to display the integer portion of 7 divided by 2 (ie, 3). 
SELECT TRUNC(7/2) IntegerPortion
FROM DUAL; 

-- 3. Write a SQL command to display the rounded result of 7 divided by 2 (ie, 4).
SELECT ROUND(7/2) Rounded
FROM DUAL;






-- Exercise 5.1
--1. Display employee number, employee name, and his/her manager’s number and name
SELECT E1.ENum, E1.EName, E1.MNum, E2.EName
FROM Employees E1, Employees E2
WHERE E1.Mnum = E2.Enum (+)
ORDER BY E1.Enum;


-- Exercise 5.2
--1. Display human number, human name, and his/her spouses’ number and name. 
SELECT H1.HNum, H1.HName, H1.SNum, H2.HName
FROM Humans H1, Humans H2
WHERE H1.SNum = H2.HNum;


--2. Display humans whose spouse is married to somebody else. For instance, if 101’s spouse is 102, then 102’s spouse should be 101. However, in this table, 103’s spouse is 104, but 104’s spouse is 105. Write a query to find all records of such mis-match.
SELECT H1.HName
FROM Humans H1, Humans H2
WHERE H1.SNum = H2.HNum;
AND H1.HNum != NVL(H2.SNum, 'NotMarried');





-- Exercise 5.3
--Based on the table of Exercise 5.1, display employee number, employee name, and his/her manager’s number and name. For employees who do not have a manager, display blank under manager’s number and name. 
SELECT E1.Enum, E1.Ename, E1.Mnum, E2.Ename
FROM Employees E1, Employees E2
WHERE E1.Mnum = E2.ENum (+);







-- Exercise 6.1
--Based on the S, P, and SP tables of Topic 5, write the following queries. 
 
--1. Upgrade supplier status to 30 for suppliers who have supplied more than 500 units of parts. 
UPDATE S SET STATUS = 30
WHERE S# IN (SELECT S#
				FROM SP 
				GROUP BY S#
				HAVING SUM(QTY) > 500);
commit;


--2.Upgrade supplier status by 5 (i.e., if it was 10 before, than upgrade it to 15; if it was 15 before than upgrade it to 20, etc.) for suppliers who have supplied more than 500 units of parts. 
UPDATE S SET STATUS = STATUS + 5
WHERE S# IN (SELECT S#
				FROM SP 
				GROUP BY S#
				HAVING SUM(QTY) > 500);
commit;

--3. Upgrade supplier status to 50 for suppliers who have supplied parts to 2 or more cities. 
UPDATE S SET Status = 50
WHERE S# IN (SELECT SP.s# 
			FROM p, sp
			WHERE sp.p# = p.p#
			HAVING COUNT(DISTINCT(p.CITY)) >= 2
			GROUP BY sp.s#);

--4. For suppliers who have placed 3 or more times of orders (ie, our more important suppliers), display the total quantity of each supplier.
SELECT S#, COUNT(S#) ORDERS, SUM(QTY) TOTAL
FROM SP
GROUP BY S#
HAVING COUNT(S#) >= 3;





-- Exercise 6.2
--1. In the SchClasses table, the NumStu shows the number of students currently enrolled in the class. Write an SQL statement to display courses where the NumStu figure is not consistent with data from the Enrollments table. 




--2. In the Students table, the GPA shows the student’s average grade (assuming all courses are 3-credit hour). Write an SQL statement to display students where the GPA is not consistent with data from the Enrollment table. 






-- Exercise 6.3
1. Write an SQL statement to display items where buying the combo is cheaper than buying individual items. 

--look at the question. Where (Select Unit price for combo) < (select total for single items)???

SELECT ID.IncludeI#, I.Iname
FROM ItemDetails ID, Items I
WHERE ID.IncludeI# = I.I#
AND ID.I# IN (SELECT SI.I#
				FROM (SELECT I#, Sum(UnitPrice) UnitPrice
						FROM (SELECT ID.I#, ID.IncludeI#, I.UnitPrice 
								FROM Items I, ItemDetails ID
								WHERE ID.IncludeI# = I.I#)
						GROUP BY I#) SI,
						(SELECT I#, UnitPrice
						FROM ITEMS
						WHERE I# = '106'
						OR I# = '107') CI
				WHERE SI.I# = CI.I#
				AND SI.UnitPrice > CI.UnitPrice);



SELECT A.I#, A.INAME, A.UnitPrice, SUM(C.UnitPrice) AS TOTAL
FROM ITEMS A, ITEMDETAILS B, ITEMS C
WHERE A.I# = B.I# AND B.IncludeI# = C.I#
GROUP BY A.I#, A.INAME, A.UnitPrice
HAVING (SUM(C.UnitPrice)) < A.UnitPrice;





--2. Write an SQL statement to display items where the combo and the sum of individual items are the same price. 




--3. Write an SQL statement to find items where the combo price is more expensive than buying individual items.





-- Exercise 6.4
--1. In one command, display the number of students (ie, how many students) who received A, B, C, D, and F's in course 10110. 
--(Think point: if nobody received a ‘D’ in this course, then D will not be displayed. Can you think of a way to display those grades with a student count of 0? Hm.....) 
 

--2. For students in 10110, display the student count by standing, ie, how many students have the standing of 4, 3, 2, or 1. 
 

--3. Display number of enrollments by callnum (ie, how many students are there in each Callnum). 
 

--4. Display number of enrollment by year/semester (ie, how many students are there in each Year/Semester). 
 

--5. Display number of enrollment by year, semester, course, like... (look at notes pg.34)
 
 
 
--6. Display how many courses student 101 has enrolled in Fall 2013. 
 


--7. Display how many sections each class has offered in Fall 2013. 
 


--8. Display how many times Andy has enrolled in IS 300. 
 


--9. Display the highest grade that Andy has ever received on IS 300. 


 
--10. Display courses that Andy has taken for 2 or more times. 


 
--11. Display courses where there is any NULL grade. 
 


--12. Displays students who are in both IS 300 and IS 301 in Fall 2013. 


 
--13. Display courses that have 2 or more students enrolled. 


 
--14. Display courses where no student has enrolled. 


 
--15. Display student who are currently enrolled in multiple sections of the same course. (You may use grade is null to indicate that the students is “currently enrolled” in this course). 


 
--16. Find classes (callnum) where all grades are assigned; in other words, every student in that class has received a letter grade. 


 
--17. Find classes (callnum) where no grades is assigned; in other words, in this particular class, all grades are null. 
 


--18. Find classes (callnum) where partial grades are assigned; in other words, some students have received letter grade while others have null grades. 






create table ItemDetails (
	I# varchar2(3),
	IncludeI# varchar2(3),
	Primary Key (I#, IncludeI#));

insert into ItemDetails values ('106','101');
insert into ItemDetails values ('106','103');
insert into ItemDetails values ('106','104');
insert into ItemDetails values ('107','102');
insert into ItemDetails values ('107','103'); 
insert into ItemDetails values ('107','105');

create table Items (
	I# varchar2(3) primary key,
	Iname varchar2(25),
	UnitPrice number);

insert into Items values ('101','Cheese Burger', 3.99);
insert into Items values ('102','Double Cheese Burger', 4.99);
insert into Items values ('103','French Fries', 1.19);
insert into Items values ('104','Medium Coke', 1.39);
insert into Items values ('105','Large Coke', 1.89);
insert into Items values ('106','Combo Meal 1', 6.99);
insert into Items values ('107','Combo Meal 2', 8.99);

commit;


Select A.I#, B.I#
from ITEMS A, Items B;

Select *
from ITEMS A, Items B
WHERE A.I# = B.I#;

Select *
from Items;

