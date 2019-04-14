set echo on
spool D:hw5-2.txt

--Exercise 3.10

SET SERVEROUTPUT ON 
CREATE OR REPLACE PROCEDURE DropMe (p_SNum number, p_CallNum number) AS
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

            IF p_enrollCheck > 0 THEN

                UPDATE enrollments SET grade='W' WHERE SNUM = p_SNum AND CallNum = p_CallNum;
                commit;
                dbms_output.put_line('You have been dropped from the course.');

            ELSE
                dbms_output.put_line('You are not enrolled in this course.');
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
exec DropMe(222, 10115);

--If course number is non-existent
exec DropMe(103, 10981);

--If both are non-existent
exec DropMe(202, 10711);

--student number and course number exist,
--but student is not enrolled.
exec DropMe(101, 10130);

--student is dropped successfully
exec DropMe(101, 10125);

spool off
