/*
Function: WHF_fnc_localizeFaction

Description:
    Localize the given faction ID.

Parameters:
    String faction:
        The faction ID to localize.

Returns:
    String

Author:
    thegamecracks

*/
params ["_faction"];
private _key = format ["STR_WHF_factions_%1", _faction];
if (isLocalized _key) then {localize _key} else {_faction}
