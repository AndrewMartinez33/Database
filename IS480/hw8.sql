
SET SERVEROUTPUT ON
DECLARE 

	vCounter number := 1;
	major varchar2(100);

BEGIN
	
	dbms_output.put_line(rpad('RANK', 6)||rpad('SID', 5)||rpad('NAME', 10)||rpad('GPA', 6)||rpad('MAJOR', 5));


	FOR eStudent IN (
		SELECT SNum, SName, GPA, Major 
		FROM Students
		ORDER BY Major, NVL(GPA, 0) DESC) 
	LOOP 

 	if major != NVL(estudent.major, 'undeclared') then
 		vCounter := 1;
 	end if; 

 	major := estudent.major;

	dbms_output.put_line(rpad(vCounter, 6)||rpad(eStudent.SNum, 5)||rpad(eStudent.SName, 10)||rpad(eStudent.GPA, 6)||rpad(eStudent.Major,5));
	vCounter := vCounter + 1;



	END LOOP; 
END;
/

SPOOL OFF