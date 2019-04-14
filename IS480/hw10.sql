Set Echo On
SPOOl D:hw10.txt

SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER AfterUpdateGPA
	AFTER UPDATE ON Students
	FOR EACH ROW

BEGIN
	IF :old.gpa - :new.gpa >= 1 THEN
		dbms_output.put_line('Warning: You GPA has dropped significantly.');
	END IF;
END;
/


update students set GPA = 1.9 where Snum = 198;

Spool off