/*
Function: WHF_fnc_selfReviveAdd

Description:
    Add a self-revive action to the player.

Author:
    thegamecracks

*/
call WHF_fnc_selfReviveRemove;
private _unit = player;
private _id = [
    _unit,
    format ["<t color='#00FF00'>%1</t>", localize "$STR_WHF_selfReviveAdd_action"],
    "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
    "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
    "lifeState _target isEqualTo 'INCAPACITATED'",
    "[_target, _caller, _actionId, _arguments] call WHF_fnc_selfReviveConditionProgress",
    {},
    {},
    WHF_fnc_selfReviveCompleted,
    {},
    [],
    WHF_selfRevive_duration,
    1001, // slightly higher priority than vanilla Force Respawn action
    false,
    true,
    true
] call BIS_fnc_holdActionAdd;
WHF_selfReviveID = [_unit, _id];
