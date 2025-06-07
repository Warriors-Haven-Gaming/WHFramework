/*
Function: WHF_fnc_respawnActionAdd

Description:
    Add a respawn action to the player.

Author:
    thegamecracks

*/
call WHF_fnc_respawnActionRemove;
private _unit = player;
private _id = [
    _unit,
    format ["<t color='#FF0000'>%1</t>", localize "$STR_A3_ForceRespawn"],
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa",
    toString {
        // Partially duplicated in WHF_fnc_selfReviveAdd
        lifeState _target isEqualTo "INCAPACITATED"
        && {_target isNil "WHF_revive_caller"
        && {time - (_target getVariable ["WHF_incapacitated_at",0]) > 3}}
    },
    toString {true},
    {},
    {},
    {
        params ["", "_caller"];
        _caller call WHF_fnc_respawnUnit;
    },
    {},
    [],
    2,
    11,
    false,
    true,
    true
] call BIS_fnc_holdActionAdd;
WHF_respawnActionID = [_unit, _id];
