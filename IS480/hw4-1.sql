set echo on
spool D:hw4-1.txt

--Problem 2.21

set serveroutput on
create or replace procedure LoveWizard (m_Number number) as 
	m_Love number := 0;
	m_Message varchar2(25);

begin

	dbms_output.put_line ('Welcome to the Love Wizard!');
	dbms_output.put_line ('Your magic number is '||m_Number||' .....');
	dbms_output.put_line (chr(10));

	FOR i IN 1..m_Number LOOP

		IF m_Love = 0 THEN
			m_Message := 'He loves you';
			m_Love := 1;
			dbms_output.put_line (m_Message||'...');
		ELSE
			m_Message := 'He loves you not';
			m_Love := 0;
			dbms_output.put_line (m_Message||'...');
		END IF;

	END LOOP;

	dbms_output.put_line (chr(10));

	IF m_Love = 1 THEN
		dbms_output.put_line ('===> '||m_Message||'!!!');
	ELSE
		dbms_output.put_line ('===> '||m_Message||' :-(');
	END IF;
	

end;
/


Exec LoveWizard(7);
Exec LoveWizard(10);

spool off
