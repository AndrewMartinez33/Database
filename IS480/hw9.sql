-- Andrew Martinez
-- HW.9
-- 11/29/17

SET SERVEROUTPUT ON
CREATE or REPLACE FUNCTION validatedStudent (p_SNum varchar2)

    Return varchar2 is 

    v_student number;

BEGIN
	SELECT SNum
	INTO v_student
	FROM students
	WHERE SNum = p_SNum;

	return null;

EXCEPTION
WHEN NO_DATA_FOUND THEN
	dbms_output.put_line('Student number does not exist');
	return 'student number does not exist';

END;
/

---------------------------------------------------------------------------
SET SERVEROUTPUT ON
CREATE or REPLACE FUNCTION validatedCallnum (p_CallNum varchar2)

    Return varchar2 is 
   
    v_CallNum number; 

BEGIN
	SELECT CallNum
	INTO v_CallNum
	FROM SchClasses
	WHERE CallNum = p_CallNum;

	return null;

EXCEPTION
WHEN NO_DATA_FOUND THEN
	dbms_output.put_line('Course number does not exist');
	return 'Course number does not exist';
END;
/







--------------------------------------------------------------------------
SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE EnrolledStudent (p_SNum varchar2, p_CallNum varchar2) AS 

	p_ErrorMsg varchar2(200);

BEGIN
	IF validatedStudent(p_SNum) IS Null AND validatedCallnum(p_CallNum) IS Null THEN
		INSERT INTO Enrollments VALUES (p_SNum, p_CallNum, Null);
		commit;
		dbms_output.put_line('You are enrolled. Thank you');
	ELSE
		dbms_output.put_line('Please try again.');
	END IF;

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
	dbms_output.put_line('Error, you are not enrolled.');

END;
/