set echo on

spool D:hw4.txt

--Problem 2.17

set serveroutput on
create or replace procedure GetChange (p_AmountDue number, p_Pay number) as 
	p_Change number;
	p_Twenty number := 0;
	p_Ten number := 0;
	p_Five number := 0;
	p_One number := 0;


begin

	p_Change :=  p_Pay - p_AmountDue;

	WHILE p_Change > 0 LOOP

		IF p_Change >= 20 THEN
			p_Twenty := p_Twenty + trunc(p_Change/20);
			p_Change := mod(p_Change, 20);
		ELSIF p_Change >= 10 THEN
			p_Ten := p_Ten + trunc(p_Change/10);
			p_Change := mod(p_Change, 10);
		ELSIF p_Change >= 5 THEN
			p_Five := p_Five + trunc(p_Change/5);
			p_Change := mod(p_Change, 5);
		ELSE
			p_One := p_One + trunc(p_Change/1);
			p_Change := mod(p_Change, 1);
		END IF;

	END LOOP;
	
	dbms_output.put_line (p_Twenty||' Twenty Dollar Bill');
	dbms_output.put_line (p_Ten||' Ten Dollar Bill');
	dbms_output.put_line (p_Five||' Five Dollar Bill');
	dbms_output.put_line (p_One||' One Dollar Bill');

end;
/

Exec GetChange(34, 40);
Exec GetChange(7, 15);
Exec GetChange(26, 31);
Exec GetChange(19, 27);
Exec GetChange(9, 40);
Exec GetChange(11, 100);
Exec GetChange(34, 40);
Exec GetChange(93, 500);

spool off