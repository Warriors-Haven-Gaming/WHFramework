/*
Function: WHF_fnc_msnMainAnnexRegionCommsTower

Description:
    Add an action to disable the communications tower.

Parameters:
    Object tower:
        The tower object to disable.

Author:
    thegamecracks

*/
params ["_tower"];

[
    _tower,
    localize "STR_WHF_mainAnnexRegionComms_title",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",
    toString {
        !(_target getVariable ["WHF_comms_disabled", false])
        && {_this distance _target < 6}
    },
    toString {true},
    {
        params ["", "_caller"];
        _caller call WHF_fnc_lowerWeapon;
    },
    {},
    {
        params ["_target", "_caller"];
        _target setVariable ["WHF_comms_disabled", true, true];
        playSoundUI ["Orange_Access_FM"];
    },
    {},
    [],
    5 + random 5
] call BIS_fnc_holdActionAdd;
