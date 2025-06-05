/*
Function: WHF_fnc_isBackpackDrone

Description:
    Return the flying drone that can be assembled from the given backpack type.

Parameters:
    String type:
        The type to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_type"];

private _assembleTo = getTextRaw (
    configFile >> "CfgVehicles" >> _type >> "assembleInfo" >> "assembleTo"
);
if !(_assembleTo isKindOf "Helicopter") exitWith {""};

_assembleTo
