SET SERVEROUTPUT ON
SET VERIFY OFF
CLEAR SCREEN

ACCEPT S_PlaId PROMPT 'Please enter a plane ID: '

DECLARE
    V_PlaId PLANE.PLA_ID%TYPE;
BEGIN
    V_PlaId := '&S_PlaId';
    Pack_Pilot.List_Of_Pilots(V_PlaId);
END;
/
