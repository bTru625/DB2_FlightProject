/*
a) Create the package and package body called Pack_Pilot that defines the following objects :
- Update_Salary : allows increase/decrease the salary of pilot according to a new amount or a percentage (use a technic to define an overload object with the same function/procedure name) (the info to output : pilot id, last name, old salary, new salary, the amount or percentage)
- List_Of_Pilots : pilots who pilot a particular plane (pilot_id, last_name, pla_desc pilot city_name) (use cursor with parameter)
- Nb_Planes : Returns the total number of planes flown by a given pilot.
b) Type a plsql program that test the objects of this package
- Test Update_Salary, List_Of_Pilots and Nb_Planes
*/


CREATE or REPLACE PACKAGE BODY Pack_Pilot IS

---- PROCEDURE: UPDATE SALARY (TWO OVERLOADS)

-- 1) has pilot id & new salary
Procedure Update_Salary (
    p_pilot_id in pilot.pilot_id%type,
    p_amount in pilot.salary%type
) IS

    V_OLD_SALARY pilot.salary%Type;
    V_NEW_SALARY pilot.salary%Type;
    V_LAST_NAME pilot.LAST_NAME%TYPE;


BEGIN

    SELECT salary, last_name
    into V_OLD_SALARY, V_LAST_NAME
    FROM PILOT
    WHERE PILOT_ID = P_PILOT_ID;

    V_NEW_SALARY := V_OLD_SALARY + p_amount;

    --CHECK THAT SALARAY IS NOT NEG
    IF V_NEW_SALARY < 0 THEN
        V_NEW_SALARY := 0;
        DBMS_OUTPUT.PUT_LINE('Salary cannot be negative, salary has been set to $0');
    END IF;

    UPDATE PILOT
    SET salary = V_NEW_SALARY
    WHERE PILOT_ID = p_pilot_id;

    DBMS_OUTPUT.PUT_LINE('SALARY UPDATED (by amount');
    DBMS_OUTPUT.PUT_LINE('______________________________');
    DBMS_OUTPUT.PUT_LINE('Pilot ID:     ' || p_pilot_ID);
    DBMS_OUTPUT.PUT_LINE('Pilot Name:   ' || V_LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('Old Salary:   ' || V_OLD_SALARY);
    DBMS_OUTPUT.PUT_LINE('Salary Change: $' || p_amount);
    DBMS_OUTPUT.PUT_LINE('New Salary:   ' || V_NEW_SALARY);

END Update_Salary;




-- 2) has pilot ID and change in salary (as %)
Procedure Update_Salary (
    p_pilot_id in pilot.pilot_id%type,
    p_amount in pilot.salary%type
) IS

    V_OLD_SALARY pilot.salary%Type;
    V_NEW_SALARY pilot.salary%Type;
    V_LAST_NAME pilot.LAST_NAME%TYPE;


BEGIN

    SELECT salary, last_name
    into V_OLD_SALARY, V_LAST_NAME
    FROM PILOT
    WHERE PILOT_ID = P_PILOT_ID;

    V_NEW_SALARY := V_OLD_SALARY + p_amount;

    --CHECK THAT SALARAY IS NOT NEG
    IF V_NEW_SALARY < 0 THEN
        V_NEW_SALARY := 0;
        DBMS_OUTPUT.PUT_LINE('Salary cannot be negative, salary has been set to $0');
    END IF;

    UPDATE PILOT
    SET salary = V_NEW_SALARY
    WHERE PILOT_ID = p_pilot_id;

    DBMS_OUTPUT.PUT_LINE('SALARY UPDATED (by amount');
    DBMS_OUTPUT.PUT_LINE('______________________________');
    DBMS_OUTPUT.PUT_LINE('Pilot ID:     ' || p_pilot_ID);
    DBMS_OUTPUT.PUT_LINE('Pilot Name:   ' || V_LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('Old Salary:   ' || V_OLD_SALARY);
    DBMS_OUTPUT.PUT_LINE('Salary Change: $' || p_amount);
    DBMS_OUTPUT.PUT_LINE('New Salary:   ' || V_NEW_SALARY);

END Update_Salary;





