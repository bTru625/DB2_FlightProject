/*
a) Create the stored procedure ListOfFlights that accepts the parameter : city name (departure city) and displays the list of flights ordered in ascending order of departure time (the columns to display are : flight id, pilot name, plane description, departure time, arrival time, arrival city name)
b) Test the procedure ListOfFlights (the city name could be entered in upper or lower case)
*/

-- I take city name
-- build a table of records
-- I print list of flights from that table in order (asc depart time)
-- list includes Flight ID, Pilot Name, Place Desc, Depart Time, Arrival Time, Arrival city Name 

CLEAR SCREEN

CREATE or REPLACE PROCEDURE ListOfFlights (p_dep_city_Name in city.city_name%type) IS

    TYPE t_flight_rec is RECORD (
        flight_id   flight.FLIGHT_ID%TYPE,
        pilot_name  Pilot.LAST_NAME%type,
        plane_desc  plane.PLA_DESC%TYPE,
        dep_time    flight.dep_time%type,
        arr_time    flight.ARR_TIME%TYPE, 
        arr_city    city.CITY_NAME%TYPE
    );

    --define and declare the collection
    TYPE T_FLIGHT_TABLE is TABLE of t_flight_rec;
    l_Flights T_FLIGHT_TABLE;

BEGIN

    SELECT  FLIGHT.flight_id, 
            PILOT.LAST_NAME AS pilot_name, 
            PLANE.PLA_DESC, 
            FLIGHT.dep_time, 
            FLIGHT.arr_time,
            ArrivalCity.city_name
    BULK COLLECT INTO l_flights
            
    FROM FLIGHT
        JOIN CITY DepartCity    ON FLIGHT.city_dep = DepartCity.CITY_ID
        JOIN CITY ArrivalCity    ON FLIGHT.city_arr = ArrivalCity.CITY_ID
        JOIN PILOT              ON FLIGHT.Pilot_ID = pilot.Pilot_ID
        JOIN PLANE              ON FLIGHT.pla_id = PLANE.pla_id
            
    WHERE DepartCity.CITY_NAME = p_dep_city_Name --related to the parameter as variable
    ORDER BY FLIGHT.DEP_TIME ;


    IF l_flights.COUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('There are no flights departing from ' || p_dep_city_name );

    ELSE
        --display heading
        DBMS_OUTPUT.PUT_LINE('All flights departing from: ' || p_dep_city_Name);
        DBMS_OUTPUT.PUT_LINE('_____________________________________________________________________________');
        DBMS_OUTPUT.PUT_LINE('FLIGHT ID  || PILOT   || PLANE || DEPART TIME || ARRIVAL TIME || ARRIVAL CITY'); 

        --loop and display each row of table

        FOR i IN 1 .. l_flights.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(l_Flights(i).flight_id || '        || ' ||
                             l_Flights(i).pilot_name || ' || ' ||
                             l_Flights(i).plane_desc || ' || ' ||
                             l_Flights(i).dep_time || '      || ' ||
                             l_Flights(i).arr_time || '            || ' ||
                             l_Flights(i).arr_city
        
        );
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('_____________________________________________________________________________');
    END IF;

END;
/

