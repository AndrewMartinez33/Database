SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE Mathhh (x1 number, x2 number) AS 
	y1 number := mod(x1, x2);
	y2 number := trunc((x1 / x2));
	y3 number := round((x1 / x2));

BEGIN
	dbms_output.put_line(y1);
	dbms_output.put_line(y2);
	dbms_output.put_line(y3);

END;
/
