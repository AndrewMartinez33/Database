set echo on
spool D:hw5.txt
--Andrew Martinez
--IS480

--Exercise 3.6

SET SERVEROUTPUT ON 
CREATE OR REPLACE PROCEDURE AddMe (p_SNum number, p_CallNum number) AS
    p_enrolled number;
    p_capacity number;
    p_idCheck number;
    p_callnumCheck number;
    p_enrollCheck number;

BEGIN
    SELECT count(SNum) 
    INTO p_idCheck
    FROM Students
    WHERE SNum = p_SNum;
    
    IF p_idCheck > 0 THEN
        
        SELECT count(CallNum) 
        INTO p_CallNumCheck
        FROM schClasses
        WHERE CallNum = p_CallNum;
        
        IF p_CallNumCheck > 0 THEN

            SELECT count(SNum)
            INTO p_enrollCheck
            FROM Enrollments
            WHERE SNUM = p_SNum
            AND CallNum = p_CallNum;

            IF p_enrollCheck = 0 THEN

                SELECT COUNT(CallNum) 
                INTO p_enrolled
                FROM ENROLLMENTS E
                GROUP BY E.CallNum
                HAVING E.CallNum = p_CallNum;
                
                SELECT capacity 
                INTO p_capacity
                FROM schClasses SC
                WHERE SC.CallNum = p_CallNum;

                IF (p_capacity - p_enrolled) > 0 THEN

                    INSERT INTO enrollments VALUES (p_SNum, p_CallNum, null);
                    commit;
                    dbms_output.put_line('Congrats, you are now enrolled!');

                ELSE
                    dbms_output.put_line('Sorry, not enough room. Please try again.');
                END IF;

            ELSE
                dbms_output.put_line('You are already enrolled. Please try again.');
            END IF;

        ELSE
            dbms_output.put_line('The class number is not in the system. Please try again.');
        END IF;

    ELSE
        dbms_output.put_line('Your student number is not in the system. Please try again.');
    END IF;

END;
/

--If student number is non-existent
exec AddMe(222, 10115);

--If course number is non-existent
exec AddMe(103, 10981);

--If both are non-existent
exec AddMe(202, 10711);

--student number and course number exist,
--but student is already enrolled.
exec AddMe(101, 10110);

--student is enrolled successfully
exec AddMe(103, 10125);

spool off