/*
a)By using a cursor, type a PL/SQL program that displays the (id, description, capacity and city name) for all planes located in particular city (enter city name regardless of the case: ex:MonTreal) and their max passenger is greater or equal to a particular number.
b) Execute this this code
 */

SET SERVEROUTPUT ON
SET VERIFY OFF
CLEAR SCREEN

ACCEPT S_CityName PROMPT 'Please enter a city name: '
ACCEPT S_MinCapacity PROMPT 'Please enter minimum capacity: '

DECLARE
   V_CityName  CITY.CITY_NAME%TYPE := '&S_CityName';
   V_MinCapacity PLANE.MAX_PASSENGER%TYPE := TO_NUMBER('&S_MinCapacity');
   V_Found BOOLEAN := FALSE;

   CURSOR Plane_Capacity_Cursor IS
     SELECT p.PLA_ID,
        p.PLA_DESC,
        p.MAX_PASSENGER,
        c.CITY_NAME
     FROM PLANE p
     JOIN CITY  c
       ON p.CITY_ID = c.CITY_ID
    WHERE LOWER(c.CITY_NAME) = LOWER(V_CityName)
      AND p.MAX_PASSENGER >= V_MinCapacity;

BEGIN
   -- Header
   DBMS_OUTPUT.PUT_LINE(RPAD('=', 70, '='));
   DBMS_OUTPUT.PUT_LINE(
     RPAD('Plane ID', 15, ' ') ||
     RPAD('Description', 25, ' ') ||
     RPAD('Capacity', 15, ' ') ||
     'City Name'
   );

   -- Rows
   FOR Plane_Capacity_rec IN Plane_Capacity_Cursor LOOP
     DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));
     DBMS_OUTPUT.PUT_LINE(
       RPAD(Plane_Capacity_rec.PLA_ID, 15, ' ') ||
       RPAD(Plane_Capacity_rec.PLA_DESC, 25, ' ') ||
       RPAD(Plane_Capacity_rec.MAX_PASSENGER, 15, ' ') ||
       Plane_Capacity_rec.CITY_NAME
     );
     V_Found := TRUE;
   END LOOP;
   -- Footer / not-found message
   IF NOT V_Found THEN
     DBMS_OUTPUT.PUT_LINE('No planes found matching the criteria.');
   END IF;

   DBMS_OUTPUT.PUT_LINE(RPAD('=', 70, '='));
EXCEPTION
   WHEN VALUE_ERROR THEN
     DBMS_OUTPUT.PUT_LINE('Invalid minimum capacity entered: ' || '&S_MinCapacity');
   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/