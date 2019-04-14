set serveroutput on
create or replace procedure BOGO (p_buy number) as 
	v_pay number;

begin
	v_pay := p_buy - (trunc(p_buy / 4));
	dbms_output.put_line ('Items to pay for: '||v_pay);

end;
/
