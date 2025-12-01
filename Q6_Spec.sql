

CREATE or REPLACE PACKAGE Pack_Pilot IS

Procedure Update_Salary (
    p_pilot_id in pilot.pilot_id%type,
    p_amount in pilot.salary%type
) ;

Procedure Update_Salary (
    p_pilot_id in pilot.pilot_id%type,
    p_percent in number
) ;

Procedure List_of_pilots (p_pla_id plane.pla_id%TYPE);

FUNCTION Nb_Planes (p_pilot_id in pilot.pilot_id%type)
    RETURN NUMBER;


END Pack_Pilot;
/

