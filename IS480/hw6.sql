SET ECHO ON

spool D:hw6.txt

SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE AddMe (
	p_SNUM varchar2, 
	p_CALLNUM varchar2) AS 
	
	v_ErrorMessage varchar2(200);
	v_ErrorText varchar2(200);
	v_Capacity varchar2(200);
	v_CreditHours varchar2(200);

BEGIN

	Validate_Student(p_SNUM, v_ErrorText);
	v_errorMessage := v_ErrorText;
	
	Validate_CallNum(p_CALLNUM, v_ErrorText);

	IF v_ErrorMessage is null AND v_ErrorText is null THEN
		v_Capacity := checkCapacity(p_CALLNUM);
		v_CreditHours := checkCreditHours(p_SNUM, p_CALLNUM);

		IF checkEnrollment(p_SNUM, p_CALLNUM) = true THEN

			IF v_Capacity is null AND v_CreditHours is null THEN
				dbms_output.put_line('You have been enrolled into course: '||p_SNUM);
				INSERT INTO ENROLLMENTS VALUES (p_SNUM, p_CALLNUM, NULL);
				commit;
			ELSE
				dbms_output.put_line(v_Capacity);
				dbms_output.put_line(v_CreditHours);
			END IF;
		
		ELSE
			dbms_output.put_line('You are already enrolled in the course.');
		END IF;

	ELSE
		dbms_output.put_line(v_ErrorMessage);
		dbms_output.put_line(v_ErrorText);
	END IF;
END;
/

select * from enrollments;

-- SUCCESSFUL ENROLLMENT
EXEC AddMe(101, 10120);

-- ALREADY ENROLLED IN COURSE
EXEC enroll.AddMe(101, 10110);

-- STUDENT# DOESN'T EXIST
EXEC AddMe(303, 10110);

-- CALL# DOESN'T EXIST
EXEC AddMe(101, 70110);

-- NO CAPACITY
EXEC AddMe(103, 10110);

-- OVER CREDIT LIMIT
EXEC AddMe(104, 10115);

spool off