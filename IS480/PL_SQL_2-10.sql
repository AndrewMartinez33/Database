SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE MyReplaceOne (p_text varchar2, p_char1 varchar2, p_char2 varchar2) AS 

	v_before varchar2(200);
	v_after varchar2(200);

BEGIN
	v_before := substr(p_text, 1, instr(p_text, p_char1) - 1);
	v_after := substr(p_text, instr(p_text, p_char1) + 1);
	dbms_output.put_line(v_before||p_char2||v_after);

END;
/


exec MyReplaceOne('1234-5678', '-', '#');