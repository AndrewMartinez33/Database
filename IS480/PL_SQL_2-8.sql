SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE MyRemoveOne (p_text varchar2, p_char_1 varchar2) AS 
	newText varchar2(100);

BEGINF
	newText := substr(p_text, 1, instr(p_text, p_char_1) - 1 );
	newText := newText||substr(p_text, instr(p_text, p_char_1) + 1);
	dbms_output.put_line(newText);

END;
/

