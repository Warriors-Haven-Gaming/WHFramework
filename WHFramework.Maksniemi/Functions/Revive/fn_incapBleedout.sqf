/*
Function: WHF_fnc_incapBleedout

Description:
    Show a chat message when a unit has bled out.

Parameters:
    Object unit:
        The unit that bled out.

Author:
    thegamecracks

*/
params ["_unit"];
systemChat format [localize "$STR_WHF_incapBleedout", name _unit];
