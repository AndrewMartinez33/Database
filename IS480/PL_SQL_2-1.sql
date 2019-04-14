SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE Math (x1 number, x2 number) AS 
	y1 number := x1 + x2;
	y2 number := x1 - x2;
	y3 number := x1 * x2;
	y4 number := x1 / x2;


BEGIN

	dbms_output.put_line(y1);
	dbms_output.put_line(y2);
	dbms_output.put_line(y3);
	dbms_output.put_line(y4);

END;
/
