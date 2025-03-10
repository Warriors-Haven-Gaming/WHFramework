/*
Function: WHF_fnc_initServiceAction

Description:
    Add an action to service vehicles near repair depots.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isNil "WHF_serviceActionID") then {
    WHF_serviceActionID call BIS_fnc_holdActionRemove;
};

private _actionID = [
    player,
    localize "$STR_WHF_initServiceAction",
    "\a3\ui_f_oldman\data\igui\cfg\holdactions\repair_ca.paa",
    "\a3\ui_f_oldman\data\igui\cfg\holdactions\repair_ca.paa",
    "call WHF_fnc_canServiceVehicle",
    "true",
    {
        [player, ["InBaseMoves_assemblingVehicleErc", random 0.5, 0, false]] remoteExec ["switchMove"];
        [cursorObject] call WHF_fnc_playServiceSounds;
    },
    {},
    {
        [player, ["", 0, 0, false]] remoteExec ["switchMove"];
        call WHF_fnc_stopServiceSounds;
        [cursorObject] remoteExec ["WHF_fnc_serviceVehicle", cursorObject];
        cursorObject setVariable ["WHF_lastService", time];
    },
    {
        [player, ["", 0, 0, false]] remoteExec ["switchMove"];
        call WHF_fnc_stopServiceSounds;
    },
    [],
    10,
    12,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;

WHF_serviceActionID = [player, _actionID];
