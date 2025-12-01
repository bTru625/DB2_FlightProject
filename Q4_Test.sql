SET SERVEROUTPUT ON
SET VERIFY OFF
CLEAR SCREEN

ACCEPT S_CityName PROMPT 'Please enter a city name: '

DECLARE
    V_CityName CITY.CITY_NAME%TYPE := '&S_CityName';
    V_Result NUMBER;

BEGIN
    V_Result := NbOfPlanesPerCity(V_CityName);
    DBMS_OUTPUT.PUT_LINE('The number of planes in that city is '|| V_Result);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(V_CityName || 'was not in the database. ');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/