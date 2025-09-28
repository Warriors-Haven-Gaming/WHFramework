/*
Function: WHF_fnc_initArtileryHandlers

Description:
    Set up artillery handlers.

Author:
    thegamecracks

*/
WHF_artyTargets = [];
WHF_artyTargets_lifetime = 90;
WHF_artyTargets_radius = 200;

addMissionEventHandler ["ArtilleryShellFired", {
    params ["_vehicle", "", "", "", "_instigator", "", "_position"];
    if (!local _vehicle) exitWith {};
    if (_position isEqualTo [0,0,0]) exitWith {};
    if (isPlayer _instigator || {isPlayer leader _instigator}) exitWith {};

    private _time = time;
    WHF_artyTargets = WHF_artyTargets select {_time < _x # 0};
    private _targets = WHF_artyTargets apply {_x # 1};
    private _area = [_position, WHF_artyTargets_radius, WHF_artyTargets_radius];
    if ([_targets, _area] call WHF_fnc_anyInArea) exitWith {};

    WHF_artyTargets pushBack [_time + WHF_artyTargets_lifetime, _position];

    private _smokePos = _position vectorAdd [0,0,50];
    private _smoke = createVehicle ["SmokeShellRed", _smokePos, [], 50, "CAN_COLLIDE"];
}];
