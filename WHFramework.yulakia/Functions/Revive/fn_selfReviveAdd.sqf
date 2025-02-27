/*
Function: WHF_fnc_selfReviveAdd

Description:
    Add a self-revive action to the player.

Author:
    thegamecracks

*/
call WHF_fnc_selfReviveRemove;
private _unit = player;
_unit setVariable ["WHF_incapacitated_at", time];
private _id = [
    _unit,
    format ["<t color='#00FF00'>%1</t>", localize "$STR_WHF_selfReviveAdd_action"],
    "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
    "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
    "
    lifeState _target isEqualTo 'INCAPACITATED'
    && {isNil {_target getVariable 'WHF_revive_caller'}
    && {time - (_target getVariable ['WHF_incapacitated_at',0]) > WHF_selfRevive_minTime}}
    ",
    "[_target, _caller, _actionId, _arguments] call WHF_fnc_selfReviveConditionProgress",
    {},
    {},
    WHF_fnc_selfReviveCompleted,
    {},
    [],
    WHF_selfRevive_duration,
    12,
    false,
    true,
    true
] call BIS_fnc_holdActionAdd;
WHF_selfReviveID = [_unit, _id];
