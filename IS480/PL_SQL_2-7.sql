SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE Split ( p_text varchar2 , p_char varchar2) AS
	v_before varchar2(25);
	v_after varchar2(25);

BEGIN
	v_before := substr(p_text, 1 , (instr(p_text, p_char) - 1));
	v_after := substr(p_text, (instr(p_text, p_char) + 1));
	dbms_output.put_line(v_before);
	dbms_output.put_line(v_after);

END;
/
