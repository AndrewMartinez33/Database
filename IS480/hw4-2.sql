set echo on

spool D:hw4.txt

--Problem 2.17

set serveroutput on
create or replace procedure GetChange (p_AmountDue number, p_Pay number) as 
	p_Change number;
	p_Twenty number;
	p_Ten number;
	p_Five number;
	p_One number;


begin

	p_Change :=  p_Pay - p_AmountDue;

	IF p_Change > 0 THEN

		p_Twenty := trunc(p_Change/20);
		p_Change := p_Change - trunc(p_Change/ 20) * 20;
		p_Ten := trunc(p_Change/10);
		p_Change := p_Change - trunc(p_Change/ 10) * 10;
		p_Five := trunc(p_Change/5);
		p_Change := p_Change - trunc(p_Change/ 5) * 5;
		p_One := trunc(p_Change/1);
		p_Change := p_Change - trunc(p_Change/ 1) * 1;
	
	ELSIF (p_Change) < 0 THEN

		dbms_output.put_line ('You owe me money!');
		
	ELSE 

		dbms_output.put_line ('No change for you!');

	END IF;

	

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