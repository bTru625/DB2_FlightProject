
SET SERVEROUTPUT ON
SET VERIFY OFF
CLEAR SCREEN


ACCEPT S_Pilot_ID PROMPT "Enter Pilot ID: "

DECLARE
v_pilot_id pilot.pilot_id%TYPE;
V_Nb_Planes number;

BEGIN

v_pilot_id := &S_Pilot_ID;
V_Nb_Planes := pack_pilot.Nb_Planes(v_pilot_id);

DBMS_OUTPUT.PUT_LINE('Pilot ID: '|| v_pilot_id ||' has flown ' || V_Nb_Planes || ' different planes.');

EXCEPTION
when no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('No pilot with that ID.');
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;
/

