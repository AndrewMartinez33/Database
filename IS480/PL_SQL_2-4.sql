SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE BOGO2 (p_buy number) AS 
	v_pay number;

BEGIN
	v_pay := p_buy - (trunc(p_buy / 5));
	dbms_output.put_line ('Items to pay for: '||v_pay);

END;
/

