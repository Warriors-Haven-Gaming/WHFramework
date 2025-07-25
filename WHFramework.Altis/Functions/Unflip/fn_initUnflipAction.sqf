/*
Function: WHF_fnc_initUnflipAction

Description:
    Adds an action to unflip vehicles.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isNil "WHF_unflipActionID") then {
    WHF_unflipActionID call BIS_fnc_holdActionRemove;
};

private _actionID = [
    player,
    localize "$STR_WHF_initUnflipAction_title",
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff1_ca.paa",
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff2_ca.paa",
    "isNull objectParent _this && {call WHF_fnc_isLookingAtFlippedVehicle}",
    toString {
        private _vehicle = cursorObject;
        if (unitIsUAV _vehicle) exitWith {true};
        if (crew _vehicle findIf {lifeState _x in ["HEALTHY", "INJURED"]} < 0) exitWith {true};
        50 cutText [localize "$STR_WHF_initUnflipAction_crew", "PLAIN", 0.5];
        false
    },
    {
        params ["", "_caller"];
        _caller call WHF_fnc_lowerWeapon;
    },
    {},
    {[cursorObject] remoteExec ["WHF_fnc_unflipVehicle", cursorObject]},
    {},
    [],
    WHF_unflip_duration,
    12,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;

WHF_unflipActionID = [player, _actionID];
