/*
Function: WHF_fnc_incapDrowned

Description:
    Show a chat message when a unit has drowned.

Parameters:
    Object unit:
        The unit that drowned.

Author:
    thegamecracks

*/
params ["_unit"];
systemChat format [localize "$STR_WHF_incapDrowned", name _unit];
