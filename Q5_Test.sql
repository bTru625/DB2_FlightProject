
SET SERVEROUTPUT ON
SET VERIFY OFF
CLEAR SCREEN

ACCEPT S_CityName PROMPT 'Please enter the City : '

DECLARE
V_CityName city.city_name%TYPE;

BEGIN
    V_CityName :='&S_CityName';
    V_CityName := upper(V_CityName);

    ListOfFlights (V_CityName);

EXCEPTION
   WHEN no_data_found THEN
      dbms_output.put_line(V_CityName || ' was not found in the database');
   WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);


END;
/





