SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE BOGO3 (p_buy number, p_x number) AS 
	v_pay number;

BEGIN
	v_pay := p_buy - (trunc(p_buy / p_x));
	dbms_output.put_line ('Items to pay for: '||v_pay);

END;
/