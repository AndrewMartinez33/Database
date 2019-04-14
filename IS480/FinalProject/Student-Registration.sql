drop table enrollments;
drop table waitlist;
drop table schclasses;
drop table courses;
drop table students;
drop table majors;


----------------------------
-- Create Table Structure --
----------------------------

create table MAJORS
	(major varchar2(3) Primary key,
	mdesc varchar2(30));

create table STUDENTS 
	(snum varchar2(3) primary key,
	sname varchar2(10),
	standing number(1),
	major varchar2(3) constraint fk_students_major references majors(major),
	gpa number(2,1),
	major_gpa number(2,1));

create table COURSES
	(dept varchar2(3) constraint fk_courses_dept references majors(major),
	cnum varchar2(3),
	ctitle varchar2(30),
	crhr number(3),
	standing number(1),
	primary key (dept,cnum));

create table SCHCLASSES (
	callnum number(5) primary key,
	year number(4),
	semester varchar2(3),
	dept varchar2(3),
	cnum varchar2(3),
	section number(2),
	capacity number(3));

alter table schclasses 
	add constraint fk_schclasses_dept_cnum foreign key 
	(dept, cnum) references courses (dept,cnum);

create table ENROLLMENTS (
	snum varchar2(3) constraint fk_enrollments_snum references students(snum),
	callnum number(5) constraint fk_enrollments_callnum references schclasses(callnum),
	grade varchar2(2),
	primary key (snum, callnum));

create table WAITLIST
	(snum varchar2(3),
	callnum number(5) constraint fk_waitlist_callnum references schclasses(callnum),
	TimeStamp date,
	primary key (snum, callnum));

commit;

-----------------------
-- Insert Table Data --
-----------------------

--MAJORS
insert into majors values ('ACC','Accounting');
insert into majors values ('FIN','Finance');
insert into majors values ('IS','Information Systems');
insert into majors values ('MKT','Marketing');

--STUDENTS
insert into students values (100, 'John', 1, Null, Null, Null);
insert into students values (101, 'Rosie', 1, Null, Null, Null);
insert into students values (102, 'Yasuko', 2, 'IS', 2.0, 2.3);
insert into students values (103, 'Bianca', 3, 'IS', 2.1, 2.3);
insert into students values (104, 'Loreen', 3, 'IS', 3.6, 2.7);
insert into students values (105, 'Jennell', 4, 'IS', 3.2, 2.7);
insert into students values (106, 'Estell', 4, 'IS', 3.7, 2.9);
insert into students values (107, 'Tameika', 2, 'ACC', 1.7, 2.9);
insert into students values (108, 'Major', 3, 'ACC', 3.3, 3.0);
insert into students values (109, 'Coralie', 3, 'ACC', 3.5, 3.3);
insert into students values (110, 'Archie', 4, 'ACC', 3.4, 3.3);
insert into students values (111, 'Lindy', 4, 'ACC', 3.9, 3.3);
insert into students values (112, 'Imelda', 2, 'MKT', 2.5, 3.3);
insert into students values (113, 'Denae', 3, 'MKT', 2.8, 3.3);
insert into students values (114, 'Ernestine', 3, 'MKT', 3.1, 3.3);
insert into students values (115, 'Davida', 4, 'MKT', 3.5, 3.3);
insert into students values (116, 'Lise', 4, 'MKT', 3.4, 3.3);
insert into students values (117, 'Ingrid', 2, 'FIN', 3.5, 3.3);
insert into students values (118, 'Roseanne', 3, 'FIN', 1.6, 1.5);
insert into students values (119, 'Cordie', 3, 'FIN', 2.6, 2.5);
insert into students values (120, 'Karla', 4, 'FIN', 3.6, 2.5);
insert into students values (121, 'Sharell', 4, 'FIN', 1.6, 1.5);
insert into students values (122, 'Tari', 2, 'IS', 2.6, 2.5);
insert into students values (123, 'Broderick', 2, 'FIN', 2.6, 2.5);
insert into students values (124, 'Jamel', 2, 'ACC', 3.6, 2.5);
insert into students values (125, 'Sherie', 2, 'MKT', 3.6, 2.5);


--COURSES
insert into courses values ('IS','300','Intro to MIS',3,1);
insert into courses values ('IS','301','Business Communicatons',3,1);
insert into courses values ('IS','310','Statistics',3,2);
insert into courses values ('IS','355','Networks',3,2);
insert into courses values ('IS','380','Database',3,2);
insert into courses values ('IS','385','Systems',3,3);
insert into courses values ('IS','480','Adv Database',3,4);

insert into courses values ('FIN','300','Intro Finance',3,1);
insert into courses values ('FIN','301','Awesome Finance',3,1);
insert into courses values ('FIN','310','Stock Market',3,2);
insert into courses values ('FIN','480','Personal Finanace',3,3);
insert into courses values ('FIN','484','Super Advanced Finance',3,4);

insert into courses values ('MKT','300','Intro Marketing',3,1);
insert into courses values ('MKT','301','Sell Anything',3,1);
insert into courses values ('MKT','310','Advanced Marketing',3,2);
insert into courses values ('MKT','484','Market Yourself',3,3);
insert into courses values ('MKT','486','Super Advanced Marketing',3,4);

insert into courses values ('ACC','300','Intro Accounting',3,1);
insert into courses values ('ACC','301','Awesome Accounting',3,1);
insert into courses values ('ACC','310','Cost Accounting',3,2);
insert into courses values ('ACC','480','Cheating on Taxes',3,3);
insert into courses values ('ACC','478','Super Advanced Accounting',3,4);

--SCHEDULE
insert into schclasses values (10110,2018,'Sp','IS','300',1,5);
insert into schclasses values (10115,2018,'Sp','IS','301',1,5);



insert into schclasses values (10120,2018,'Sp','IS','310',1,5);
insert into schclasses values (99999,2018,'Sp','IS','310',1,5);




	
insert into schclasses values (10125,2018,'Sp','IS','355',1,5);




insert into schclasses values (10130,2018,'Sp','IS','380',1,5);
insert into schclasses values (10126,2018,'Sp','IS','385',1,5);
insert into schclasses values (10131,2018,'Sp','IS','480',1,5);

insert into schclasses values (11111,2018,'Sp','IS','300',2,5);
insert into schclasses values (11112,2018,'Sp','IS','301',2,5);
insert into schclasses values (11113,2018,'Sp','IS','310',2,5);


insert into schclasses values (11118,2018,'Sp','FIN','300',1,5);
insert into schclasses values (11119,2018,'Sp','FIN','301',1,5);
insert into schclasses values (11120,2018,'Sp','FIN','310',1,5);
insert into schclasses values (11121,2018,'Sp','FIN','480',1,5);
insert into schclasses values (11122,2018,'Sp','FIN','484',1,5);

insert into schclasses values (11123,2018,'Sp','FIN','300',2,5);
insert into schclasses values (11124,2018,'Sp','FIN','301',2,5);
insert into schclasses values (11125,2018,'Sp','FIN','310',2,5);


insert into schclasses values (11128,2018,'Sp','MKT','300',1,5);
insert into schclasses values (11129,2018,'Sp','MKT','301',1,5);
insert into schclasses values (11130,2018,'Sp','MKT','310',1,5);
insert into schclasses values (11131,2018,'Sp','MKT','484',1,5);
insert into schclasses values (11132,2018,'Sp','MKT','486',1,5);

insert into schclasses values (11133,2018,'Sp','MKT','300',2,5);
insert into schclasses values (11134,2018,'Sp','MKT','301',2,5);
insert into schclasses values (11135,2018,'Sp','MKT','310',2,5);

insert into schclasses values (11138,2018,'Sp','ACC','300',1,5);
insert into schclasses values (11139,2018,'Sp','ACC','301',1,5);
insert into schclasses values (11140,2018,'Sp','ACC','310',1,5);
insert into schclasses values (11141,2018,'Sp','ACC','480',1,5);
insert into schclasses values (11142,2018,'Sp','ACC','478',1,5);

insert into schclasses values (11143,2018,'Sp','ACC','300',2,5);
insert into schclasses values (11144,2018,'Sp','ACC','301',2,5);
insert into schclasses values (11145,2018,'Sp','ACC','310',2,5);


-- --ENROLLMENTS
insert into Enrollments values (101, 10110, Null);
insert into Enrollments values (101, 10115, Null);
insert into Enrollments values (101, 11118, Null);
insert into Enrollments values (101, 11128, Null);
insert into Enrollments values (101, 11138, Null);
insert into Enrollments values (101, 11119, 'W');
insert into Enrollments values (101, 11129, 'W');

insert into Enrollments values (103, 10110, Null);
insert into Enrollments values (103, 10115, Null);
insert into Enrollments values (103, 11118, Null);
insert into Enrollments values (103, 10125, Null);
insert into Enrollments values (103, 10130, Null);
insert into Enrollments values (103, 11129, 'W');

insert into Enrollments values (104, 10110, Null);
insert into Enrollments values (104, 10115, Null);
insert into Enrollments values (104, 11118, Null);
insert into Enrollments values (104, 11128, Null);
insert into Enrollments values (104, 11138, Null);
insert into Enrollments values (104, 11129, 'W');

insert into Enrollments values (102, 10110, Null);
insert into Enrollments values (102, 10115, Null);
insert into Enrollments values (102, 11118, Null);
insert into Enrollments values (102, 10125, Null);
insert into Enrollments values (102, 11113, Null);
insert into Enrollments values (102, 11119, 'W');

insert into Enrollments values (106, 10110, Null);
insert into Enrollments values (106, 10115, Null);
insert into Enrollments values (106, 11118, Null);
insert into Enrollments values (106, 10126, Null);
insert into Enrollments values (106, 10131, Null);

insert into Enrollments values (113, 11131, Null);
insert into Enrollments values (113, 11132, Null);
insert into Enrollments values (113, 11138, Null);
insert into Enrollments values (115, 11134, Null);
insert into Enrollments values (115, 11135, Null);

insert into Enrollments values (116, 11134, Null);
insert into Enrollments values (116, 11135, Null);
insert into Enrollments values (117, 11123, Null);
insert into Enrollments values (117, 11124, Null);
insert into Enrollments values (117, 11125, Null);

insert into Enrollments values (118, 11121, Null);
insert into Enrollments values (118, 11124, Null);
insert into Enrollments values (118, 11125, Null);
insert into Enrollments values (109, 11140, Null);
insert into Enrollments values (109, 11141, Null);
insert into Enrollments values (105, 11111, Null);
insert into Enrollments values (105, 99999, Null);



-- --WAITLIST
insert into waitlist values (105, 10110, '01-DEC-17');
insert into waitlist values (124, 10115, '02-DEC-17');
insert into waitlist values (115, 11118, '03-DEC-17');
insert into waitlist values (123, 10110, '04-DEC-17');
insert into waitlist values (122, 10115, '05-DEC-17');
insert into waitlist values (109, 11118, '06-DEC-17');
insert into waitlist values (122, 10110, '07-DEC-17');
insert into waitlist values (123, 10115, '08-DEC-17');
insert into waitlist values (110, 11118, '09-DEC-17');

commit;

CREATE OR REPLACE PACKAGE Enroll IS

FUNCTION StudentValidation (
	p_SNum varchar2)
	Return varchar2;

FUNCTION CallnumValidation (
	p_CallNum varchar2)
    Return varchar2;

FUNCTION EnrollmentValidation (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION SectionValidation (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION CreditValidation (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION StandingValidation (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION GPA_Qualification (
	p_SNum varchar2)
    Return varchar2;

FUNCTION CapacityValidation (
	p_CallNum varchar2)
    Return varchar2;

FUNCTION AddToWaitlist (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION EnrollStudent (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

PROCEDURE AddMe (
	p_Snum IN varchar2, 
	p_CallNum IN varchar2, 
	p_ErrorMsg OUT varchar2);

FUNCTION CheckIfEnrolled (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION GradeValidation (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION UpdateEnrollment (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION RemoveFromWait (
	p_SNum varchar2, 
	p_CallNum varchar2)
    Return varchar2;

FUNCTION CheckWaitList (
	p_CallNum varchar2)
    Return varchar2;

PROCEDURE DropMe (
	p_SNum varchar2, 
	p_CallNum varchar2);

END Enroll;
/

----------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY Enroll IS

FUNCTION StudentValidation (p_SNum varchar2)

    Return varchar2 is 

    v_student number;

BEGIN
	SELECT count(SNum)
	INTO v_student
	FROM students
	WHERE SNum = p_SNum;

	IF v_student = 0 THEN
		dbms_output.put_line('Student Number Not Valid');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;
END;


--------------------------------------------------------------------------

FUNCTION CallnumValidation (p_CallNum varchar2)

    Return varchar2 is

    v_CallNum number; 

BEGIN
	SELECT count(CallNum)
	INTO v_CallNum
	FROM SchClasses
	WHERE CallNum = p_CallNum;

	IF v_CallNum = 0 THEN
		dbms_output.put_line('Course Number Not Valid');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;
END;


-------------------------------------------------------------------------

FUNCTION EnrollmentValidation (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

    v_enrolled number;

BEGIN
	SELECT count(SNum)
	INTO v_enrolled
	FROM enrollments
	WHERE SNum = p_SNum
	AND CallNum = p_CallNum;

	IF v_enrolled = 1 THEN
		dbms_output.put_line('You Are Already Enrolled In This Course');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;
END;

-------------------------------------------------------------------------

FUNCTION SectionValidation (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is

    v_sectionCheck number;

BEGIN
	SELECT count(SNum)
	INTO v_sectionCheck
	FROM enrollments e, SchClasses sc, SchClasses sc2
	WHERE SNum = p_SNum
	AND e.CallNum = sc.CallNum
	AND sc2.callnum = p_CallNum
	AND Sc.dept = sc2.DEPT
	AND sc.Cnum = sc2.cnum
	AND sc.section != sc2.section;

	IF v_sectionCheck > 0 THEN
		dbms_output.put_line('You Are Already Enrolled In A Different Section of This Course');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;
END;

-------------------------------------------------------------------------------------------

FUNCTION CreditValidation (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

    v_EnrolledCrHr number;
    v_CourseCrHr number;

BEGIN
	SELECT sum(crhr)
	INTO v_EnrolledCrHr
	FROM enrollments e, schclasses sc, courses c
	WHERE e.SNum = p_SNum
	AND e.CallNum = sc.CallNum
	AND sc.Dept = c.Dept
	AND sc.CNum = c.CNum;

	SELECT crhr
	INTO v_CourseCrHr
	FROM SchClasses sc, Courses c
	WHERE sc.CallNum = p_CallNum
	AND sc.Dept = c.Dept
	AND sc.CNum = c.CNum;

	IF (v_EnrolledCrHr + v_CourseCrHr) > 15 THEN
		dbms_output.put_line('You Are Over The 15-Credit Limit');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;
END;

-----------------------------------------------------------------------------------------

FUNCTION StandingValidation (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is

    v_Standing number;

BEGIN
	SELECT count(SNum)
	INTO v_Standing
	FROM students s, SchClasses sc, Courses c
	WHERE s.SNum = p_SNum
	AND sc.CallNum = p_CallNum
	AND sc.Dept = c.Dept
	AND sc.CNum = c.CNum
	AND s.Standing >= c.Standing;

	IF v_Standing = 0 THEN
		dbms_output.put_line('You Do Not Meet The Student Standing Requirement');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;

END;

-------------------------------------------------------------------------------------

FUNCTION GPA_Qualification (p_SNum varchar2)

    Return varchar2 is

    v_Status number;

BEGIN
	SELECT count(SNum)
	INTO v_Status
	FROM Students
	WHERE SNum = p_SNum
	AND GPA < 2.0
	AND Standing > 1;

	IF v_Status = 1 THEN
		dbms_output.put_line('Your GPA Is Below The Required 2.0');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;
END;

------------------------------------------------------------------------------------

FUNCTION CapacityValidation (p_CallNum varchar2)

    Return varchar2 is

    v_CourseCapacity number;
    v_CurrentCapacity number;

BEGIN
	SELECT capacity
	INTO v_CourseCapacity
	FROM SchClasses
	WHERE CallNum = p_CallNum;

	SELECT count(SNum)
	INTO v_CurrentCapacity
	FROM Enrollments
	WHERE CallNum = p_CallNum
	AND Grade IS Null OR GRADE != 'W';
	
	IF (v_CourseCapacity - v_CurrentCapacity) <= 0 THEN
		dbms_output.put_line('This Course Is At Full Capacity');
		return 'Unsuccessful';
	ELSE
		return null;
	END IF;

END;

-----------------------------------------------------------------------------------

FUNCTION AddToWaitlist (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

BEGIN
	INSERT INTO WaitList VALUES (p_SNum, p_CallNum, Sysdate);
	dbms_output.put_line('Student number '||p_SNum||' '||'is now on the waiting list for class number '||p_CallNum||'.');
	Return Null;

EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		dbms_output.put_line('You are already on the waitlist.');
		return 'Unsuccessful';
END;
-----------------------------------------------------------------------------------

FUNCTION EnrollStudent (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

BEGIN
	INSERT INTO Enrollments VALUES (p_SNum, p_CallNum, null);
	commit;
	dbms_output.put_line('Student Number '||p_SNum||' '||'has been successfully enrolled in class number '||p_CallNum||'.');
	return Null;
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
		dbms_output.put_line('Sorry, there was a problem enrolling you in the class.');
		Return 'Unsuccessful';
END;

----------------------------------------------------------------------------------

PROCEDURE AddMe (
	p_Snum IN varchar2, 
	p_CallNum IN varchar2, 
	p_ErrorMsg OUT varchar2) AS 

BEGIN
	p_ErrorMsg := StudentValidation(p_SNum);
	p_ErrorMsg := p_ErrorMsg||CallnumValidation(p_CallNum);
	
	IF p_ErrorMsg IS Null THEN
		
		p_ErrorMsg := p_ErrorMsg||EnrollmentValidation(p_SNum, p_CallNum);
		p_ErrorMsg := p_ErrorMsg||SectionValidation(p_SNum, p_CallNum);			
		p_ErrorMsg := p_ErrorMsg||CreditValidation(p_SNum, p_CallNum);
		p_ErrorMsg := p_ErrorMsg||StandingValidation(p_SNum, p_CallNum);
		p_ErrorMsg := p_ErrorMsg||GPA_Qualification(p_SNum);

		IF p_ErrorMsg IS Null THEN

			p_ErrorMsg := p_ErrorMsg||CapacityValidation(p_CallNum);

			IF p_ErrorMsg IS Null THEN

				p_ErrorMsg := EnrollStudent(p_SNum, p_CallNum);
		
			ELSE
				
				p_ErrorMsg := AddToWaitlist(p_SNum, p_CallNum);
					
			END IF;	
		END IF;
	END IF;
END;

----------------------------------------------------------------------------------

FUNCTION CheckIfEnrolled (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

    v_enrolled number;

BEGIN
	SELECT count(SNum)
	INTO v_enrolled
	FROM enrollments
	WHERE SNum = p_SNum
	AND CallNum = p_CallNum;

	IF v_enrolled = 1 THEN
		return null;
	ELSE
		dbms_output.put_line('You Are Not Enrolled In This Course');
		return 'Unsuccessful';
	END IF;
END;


-------------------------------------------------------------------------------

FUNCTION GradeValidation (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

    v_Grade varchar2(1);

BEGIN
	SELECT Grade
	INTO v_Grade
	FROM Enrollments
	WHERE SNum = p_SNum
	AND CallNum = p_CallNum;

	IF v_Grade IS NOT Null THEN
		dbms_output.put_line('You Cannot Drop This Course, Already Received Grade.');
		return 'Unsuccessful';
	ELSE
		return Null;
	END IF;

END;


----------------------------------------------------------------------------------

FUNCTION UpdateEnrollment (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

BEGIN
	UPDATE Enrollments 
	SET Grade = 'W'
	WHERE SNum = p_SNum
	AND CallNum = p_CallNum;

	IF SQL%FOUND THEN
		dbms_output.put_line('Student Number '||p_SNum||' was successfully dropped from class number '||p_CallNum||'.');
		return null;
	ELSE
		dbms_output.put_line('Student Number '||p_SNum||' was NOT successfully dropped from class number '||p_CallNum||'.');
		return 'Unsuccessful';
	END IF;
END;

----------------------------------------------------------------------------------

FUNCTION RemoveFromWait (p_SNum varchar2, p_CallNum varchar2)

    Return varchar2 is 

BEGIN
	DELETE FROM WaitList
	WHERE SNum = p_SNum
	AND CallNum = p_CallNum;

	IF SQL%FOUND THEN
		return 'Student Number '||p_SNum||' has been removed from the wait list for course '||p_CallNum||'.';
	ELSE
		return 'Student Number '||p_SNum||' was enrolled in '||p_CallNum||', but was not removed from wait list.';
	END IF;
END;

----------------------------------------------------------------------------------

FUNCTION CheckWaitList (p_CallNum varchar2)

    Return varchar2 is

    v_ErrorMsg varchar2(200);

-- NOTE: How are you exiting the loop if someone from the waitlist gets added before the end of the loop
BEGIN
	FOR waitRecord IN (
		SELECT SNum, CallNum
		FROM WaitList
		WHERE CallNum = p_CallNum
		ORDER BY TimeStamp)
	LOOP

		AddMe(waitRecord.SNum, waitRecord.CallNum, v_ErrorMsg);

		IF v_ErrorMsg IS Null THEN	
			v_ErrorMsg := RemoveFromWait(waitRecord.SNum, waitRecord.CallNum);
			EXIT;
		END IF;
	END LOOP;

	return v_ErrorMsg;
END;


---------------------------------------------------------------------------------------------------------------

PROCEDURE DropMe (
	p_SNum varchar2, 
	p_CallNum varchar2) AS

	v_ErrorMsg varchar2(200);

BEGIN
	v_ErrorMsg := StudentValidation(p_SNum);
	v_ErrorMsg := v_ErrorMsg||CallNumValidation(p_CallNum);

	IF v_ErrorMsg IS Null THEN

		v_ErrorMsg := v_ErrorMsg||CheckIfEnrolled(p_SNum, p_CallNum);
		v_ErrorMsg := v_ErrorMsg||GradeValidation(p_SNum, p_CallNum);
			
		IF v_ErrorMsg IS Null THEN
				
			v_ErrorMsg := UpdateEnrollment(p_SNum, p_CallNum);
				
			IF v_ErrorMsg IS Null THEN
					
					v_ErrorMsg := CheckWaitList(p_CallNum);
					dbms_output.put_line(v_ErrorMsg);

			END IF;
		END IF;
	END IF;
END;



END Enroll;
/