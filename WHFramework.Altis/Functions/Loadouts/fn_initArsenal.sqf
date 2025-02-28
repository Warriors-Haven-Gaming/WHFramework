/*
Function: WHF_fnc_initArsenal

Description:
    Initialize an object as an arsenal.

Parameters:
    Object arsenal:
        The object to set up as an arsenal.

Author:
    thegamecracks

*/
params ["_arsenal"];

["AmmoboxInit", [_arsenal, true]] spawn BIS_fnc_arsenal;

_arsenal addAction [
    localize "$STR_WHF_initArsenal_loadLastLoadout",
    {
        params ["", "_caller"];
        private _loadout = call WHF_fnc_getLastLoadout;
        if (_loadout isNotEqualTo []) then {_caller setUnitLoadout _loadout};
    },
    nil,
    1.5,
    true,
    true,
    "",
    "true",
    3
];
