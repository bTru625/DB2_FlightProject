SET SERVEROUTPUT ON
SET VERIFY OFF
CLEAR SCREEN


Accept S_Pilot_ID PROMPT 'Enter the ID of the Pilot you want to update: '
ACCEPT S_Amount_OR_Percent PROMPT 'Would you like to update salary by amount (A) or percentage (P): '
ACCEPT S_Change Prompt 'How much would you like to change the salary by (+/-): '

DECLARE

    V_Pilot_ID pilot.pilot_id%type;
    V_Amount_or_Percent CHAR(1);
    V_Amount_Change pilot.salary%type;
    V_Percent_Change number;

BEGIN

    V_Amount_or_Percent := UPPER(SUBSTR('&S_Amount_OR_Percent', 1, 1));
    V_Pilot_ID := To_Number('&S_Pilot_ID');

    IF V_Amount_or_Percent = 'A' THEN
        V_Amount_Change := '&S_Change';
        Pack_Pilot.Update_Salary(p_pilot_ID => V_Pilot_ID, p_amount => V_Amount_Change);

    ELSIF V_Amount_or_Percent = 'P' THEN
        V_Percent_Change := '&S_Change';
        Pack_Pilot.Update_Salary(p_pilot_ID => V_Pilot_ID, p_percent => V_Percent_Change);
    
    ELSE
        DBMS_OUTPUT.PUT_LINE('You have entered an invalid option: Amount (A) or Percent (P)');
    END IF;

/*
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    */
END;
/
