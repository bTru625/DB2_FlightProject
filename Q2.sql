/*
a) By using SELECT .. BULK COLLECT .., type a plsql program that asks to enter a city id and display all planes based in this city (pla_id, desc, max_passenger and city name)
b) Execute this code for the cities : 102, 101
*/


SET SERVEROUTPUT ON
SET VERIFY OFF
CLEAR SCREEN

ACCEPT S_City_ID PROMPT 'Please enter the City ID: '

DECLARE 
-- Need CityID (City, Plane-FK), PlaneID (Plane), PlaneDescription (Plane), MaxPassengers (Plane), CityName (City)

V_CITY_ID CITY.CITY_ID%TYPE; 
V_cityName city.CITY_NAME%TYPE;

-- define the collection types
TYPE t_planeId is TABLE of plane.PLA_ID%TYPE;
TYPE t_planeDesc is TABLE of plane.PLA_DESC%TYPE;
TYPE t_MaxPassengers is TABLE of plane.MAX_PASSENGER%TYPE;

-- the actual collections
l_planeID t_planeId;
l_planeDesc t_planeDesc;
l_MaxPassengers t_MaxPassengers;


BEGIN
V_CITY_ID := '&S_City_ID';

-- take the city name (will be the same for all planes in that oen city)
Select City_Name
INTO V_cityName
FROM CITY
Where CITY_ID = V_CITY_ID;

--Collect all the plane info into the lists
SELECT PLA_ID, PLA_DESC, max_passenger
Bulk COLLECT INTO l_planeID, l_planeDesc, l_MaxPassengers
FROM PLANE
WHERE CITY_ID = V_CITY_ID;


-- DISPLAY all planes in city x

DBMS_OUTPUT.PUT_LINE('SHOWING ALL PLANES IN: ' || V_cityName);
DBMS_OUTPUT.PUT_LINE('________________________________________________________');

IF l_planeID.COUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('There are no planes in this city.');

ELSE
   FOR i IN 1 .. l_planeID.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('Plane ID: ' || l_planeId(i) ||
                           '        Plane Desc.: '|| l_planeDesc(i) ||
                           '        Max Passengers: '|| l_MaxPassengers(i));
   END LOOP;
END IF;


EXCEPTION
   WHEN no_data_found THEN
      dbms_output.put_line(V_CITY_ID || ' is not a valid CITY_ID');
   WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);



END;
/