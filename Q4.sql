/*
a) Create the stored function NbOfPlanesPerCity that accepts the parameter : city name and returns the number of planes located in that city.
b) Test the function NbOfPlanesPerCity (the city name could be entered in upper or lower case)
*/
CLEAR SCREEN

CREATE OR REPLACE FUNCTION NbOfPlanesPerCity (V_CityName CITY.CITY_NAME%type)
RETURN NUMBER
IS
    V_NumberOfPlanes NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_NumberOfPlanes
    FROM PLANE p
    JOIN CITY  c ON p.CITY_ID = c.CITY_ID
    WHERE UPPER(c.CITY_NAME) = UPPER(V_CityName);

    RETURN V_NumberOfPlanes;
END;
/