/*
Function: WHF_fnc_localizeRole

Description:
    Localize the given role ID.

Parameters:
    String role:
        The role ID to localize.

Returns:
    String

Author:
    thegamecracks

*/
params ["_role"];
private _key = format ["STR_WHF_roles_%1", _role];
if (isLocalized _key) then {localize _key} else {_role}
