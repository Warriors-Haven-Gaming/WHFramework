/*
Function: WHF_fnc_initProjectileIcons

Description:
    Set up projectile icons.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

WHF_projectiles = [];

addMissionEventHandler ["ProjectileCreated", {
    params ["_projectile"];

    getShotParents _projectile params ["_source"];
    if (cameraOn isEqualTo _source) exitWith {};

    private _types = ["BombCore", "MissileCore", "RocketCore"];
    if (_types findIf {_projectile isKindOf _x} < 0) exitWith {};

    _projectile setVariable ["WHF_projectiles_started", time];
    WHF_projectiles pushBack _projectile;
}];

addMissionEventHandler ["Draw3D", {
    if (!WHF_icons_projectiles) exitWith {};
    if (isNil "WHF_projectiles") then {WHF_projectiles = []};

    private _time = time;
    private _cameraPos = positionCameraToWorld [0, 0, 0];

    private _toRemove = [];
    {
        if (!alive _x) then {_toRemove pushBack _forEachIndex; continue};

        private _distance = _cameraPos distanceSqr _x;
        if (_distance > 9000000) then {continue};

        private _started = _x getVariable ["WHF_projectiles_time", 0];
        private _delta = _time - _started;
        private _scale = linearConversion [250000, 1000000, _distance, 1, 0.25, true];
        private _opacity = linearConversion [250000, 9000000, _distance, 1, 0, true];
        private _color = [1, 0.1, 0, _opacity];

        drawIcon3D [
            "a3\ui_f\data\igui\cfg\cursors\explosive_ca.paa",
            _color,
            _x modelToWorldVisual [0,0,0],
            _scale,
            _scale,
            _delta * 720
        ];
    } forEach WHF_projectiles;
    {WHF_projectiles deleteAt _x} forEach _toRemove;
}];
