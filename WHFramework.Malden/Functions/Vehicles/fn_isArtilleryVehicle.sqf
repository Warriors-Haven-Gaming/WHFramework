/*
Function: WHF_fnc_isArtilleryVehicle

Description:
    Check if the given vehicle is capable of artillery.

Parameters:
    Object vehicle:
        The vehicle to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_vehicle"];
getNumber (configOf _vehicle >> "artilleryScanner") > 0
