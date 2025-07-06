/*
Function: WHF_fnc_onArsenalOpened

Description:
    Handle the arsenal being opened for a given unit.

Parameters:
    Object center:
        The unit whose arsenal was opened.

Author:
    thegamecracks

*/
params ["_center"];

WHF_loadout_center = _center;
private _role = WHF_loadout_center getVariable "WHF_role";
if (!isNil "_role" && {WHF_loadout_center isNotEqualTo player}) then {
    50 cutText [
        format [
            localize "$STR_WHF_initArsenalLoadoutHandlers_role",
            _role call WHF_fnc_localizeRole
        ],
        "PLAIN DOWN",
        0.5
    ];
};

if (!isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
    WHF_loadout_center call WHF_fnc_lowerWeapon;
};
