/*
Function: WHF_fnc_incapLoop

Description:
    Handle a unit becoming incapacitated.
    Function must be ran in scheduled environment.

Parameters:
    Object unit:
        The unit to be incapacitated.

Author:
    thegamecracks

*/
params ["_unit"];

while {alive _unit && {lifeState _unit isEqualTo "INCAPACITATED"}} do {
    private _vehicle = objectParent _unit;
    if (!isNull _vehicle && {!alive _vehicle}) then {_unit moveOut _vehicle};
    sleep (1 + random 1);
};
