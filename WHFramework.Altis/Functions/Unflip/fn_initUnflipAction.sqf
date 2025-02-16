/*
Function: WH_fnc_initUnflipAction

Description:
    Adds an action to unflip vehicles.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isNil "WH_unflipActionID") then {
    WH_unflipActionID call BIS_fnc_holdActionRemove;
};

private _actionID = [
    player,
    localize "$STR_WH_initUnflipAction_title",
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff1_ca.paa",
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff2_ca.paa",
    "isNull objectParent _this && {call WH_fnc_isLookingAtFlippedVehicle}",
    "true",
    {},
    {},
    {[cursorObject] remoteExec ["WH_fnc_unflipVehicle", cursorObject]},
    {},
    [],
    WH_unflip_duration,
    1000,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;

WH_unflipActionID = [player, _actionID];
