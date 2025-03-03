/*
Function: WHF_fnc_haloJumpGUI

Description:
    Shows the map to select a location for halo jumping.

Author:
    thegamecracks

*/
if (!isNil "WHF_haloJump_mapHandlers") exitWith {};
// TODO: add combat restrictions
// TODO: add halo jump cooldown
if (!openMap true) exitWith {};

hint localize "$STR_WHF_haloJumpGUI_description";

WHF_haloJump_mapHandlers = [];
WHF_haloJump_mapHandlers pushBack ["Map", addMissionEventHandler ["Map", {
    params ["_opened"];
    if (_opened) exitWith {};

    {removeMissionEventHandler _x} forEach WHF_haloJump_mapHandlers;
    WHF_haloJump_mapHandlers = nil;
}]];
WHF_haloJump_mapHandlers pushBack ["MapSingleClick", addMissionEventHandler ["MapSingleClick", {
    params ["", "_pos"];

    private _reason = [_pos] call WHF_fnc_checkHaloJump;
    if (_reason isNotEqualTo "") exitWith {50 cutText [_reason, "PLAIN", 0.3]};

    {removeMissionEventHandler _x} forEach WHF_haloJump_mapHandlers;
    WHF_haloJump_mapHandlers = nil;

    openMap false;
    _pos = _pos vectorAdd [random 100 - 50, random 100 - 50];
    [_pos] spawn WHF_fnc_haloJump;
}]];
