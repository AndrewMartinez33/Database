SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE xyz (p_buy number, p_x number, p_y number) AS 
	v_pay number;

BEGIN
	v_pay := p_buy - (trunc((p_buy / p_x) * p_y));
	dbms_output.put_line('Items to pay for: '||v_pay);

END;
/
