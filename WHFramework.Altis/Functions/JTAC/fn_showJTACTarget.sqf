/*
Function: WHF_fnc_showJTACTarget

Description:
    Show a JTAC target being marked.
    Function must be remote executed on client from the server.

Parameters:
    Object unit:
        The unit reporting the target.
    Object target:
        The target that was reported.

Author:
    thegamecracks

*/
if (remoteExecutedOwner isNotEqualTo 2 && {isMultiplayer}) exitWith {};
if (isNull player) exitWith {};
params ["_unit", "_target"];

private _locations = nearestLocations [
    _target,
    WHF_missions_annex_location_types, // Probably should be hardcoded
    1000,
    _target
] apply {text _x} select {_x isNotEqualTo ""};
private _location = if (count _locations > 0) then {_locations # 0} else {""};

private _key = [
    "$STR_WHF_showJTACTarget",
    "$STR_WHF_showJTACTarget_location"
] select (_location isNotEqualTo "");

[side group player, "BLU"] sideChat format [
    localize _key,
    name _unit,
    [configOf _target] call BIS_fnc_displayName,
    mapGridPosition _target,
    _location
];
