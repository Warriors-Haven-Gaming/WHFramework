/*
Function: WHF_fnc_haloJumpGUI

Description:
    Shows the map to select a location for halo jumping.

Author:
    thegamecracks

*/
if (!isNil "WHF_haloJump_mapHandlers") exitWith {};

private _vehicles = focusOn nearEntities ["LandVehicle", WHF_halo_antiair_distance];
if (_vehicles findIf {[_x, focusOn] call WHF_fnc_isEnemyAntiAir} >= 0) exitWith {
    50 cutText [localize "$STR_WHF_haloJumpGUI_antiair", "PLAIN DOWN", 0.3];
};

// TODO: add combat restrictions
// TODO: add halo jump cooldown
if (!openMap true) exitWith {};

hint localize "$STR_WHF_haloJumpGUI_description";

WHF_haloJump_mapHandlers = [];
WHF_haloJump_mapHandlers pushBack ["Map", addMissionEventHandler ["Map", {
    params ["_opened"];
    if (_opened) exitWith {};

    hintSilent "";
    {removeMissionEventHandler _x} forEach WHF_haloJump_mapHandlers;
    {
        _x params ["_unit", "_event"];
        _unit removeEventHandler _event;
    } forEach WHF_haloJump_mapUnitHandlers;
    WHF_haloJump_mapHandlers = nil;
    WHF_haloJump_mapUnitHandlers = nil;
}]];
WHF_haloJump_mapHandlers pushBack ["MapSingleClick", addMissionEventHandler ["MapSingleClick", {
    params ["", "_pos"];

    // TODO: drawIcon on cursor position
    private _reason = [focusOn, _pos] call WHF_fnc_checkHaloJump;
    if (_reason isNotEqualTo "") exitWith {50 cutText [_reason, "PLAIN", 0.3]};

    hintSilent "";
    {removeMissionEventHandler _x} forEach WHF_haloJump_mapHandlers;
    WHF_haloJump_mapHandlers = nil;

    openMap false;
    _pos = _pos vectorAdd [random 100 - 50, random 100 - 50];
    [_pos] spawn WHF_fnc_haloJump;
}]];

WHF_haloJump_mapUnitHandlers = [];
WHF_haloJump_mapUnitHandlers pushBack [
    focusOn,
    ["HandleDamage", focusOn addEventHandler ["HandleDamage", {
        params ["_unit"];
        openMap false;
        _unit removeEventHandler [_thisEvent, _thisEventHandler];
    }]]
];
