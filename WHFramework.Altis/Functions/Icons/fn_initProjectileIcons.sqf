/*
Function: WHF_fnc_initProjectileIcons

Description:
    Set up projectile icons.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

WHF_projectiles = [];
WHF_projectiles_launches = [];

addMissionEventHandler ["ProjectileCreated", {
    params ["_projectile"];
    if (!WHF_icons_projectiles) exitWith {};

    getShotParents _projectile params ["_source", "_instigator"];
    if (
        !WHF_icons_projectiles_self
        && {cameraOn isEqualTo _source}
    ) exitWith {};
    if(
        !WHF_icons_projectiles_friendly
        && {side group _instigator isEqualTo side group focusOn}
    ) exitWith {};

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

        private _distanceSqr = _cameraPos distanceSqr _x;
        private _speedSqr = vectorMagnitudeSqr velocity _x;
        private _timeToImpactSqr = _distanceSqr / (_speedSqr max 1);

        private _started = _x getVariable ["WHF_projectiles_time", 0];
        private _delta = _time - _started;
        private _scale = linearConversion [0, 25, _timeToImpactSqr, 1, 0.25, true];
        private _opacity = linearConversion [0, 400, _timeToImpactSqr, 1, 0, true];
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

addMissionEventHandler ["Draw3D", {
    if (!WHF_icons_projectiles_launches) exitWith {};
    if (isNil "WHF_projectiles_launches") then {WHF_projectiles_launches = []};

    private _time = time;
    private _duration = 4;
    private _cameraPos = positionCameraToWorld [0, 0, 0];

    private _toRemove = [];
    {
        _x params ["_started", "_source", "_projectile"];
        if (isNull _source) then {_toRemove pushBack _forEachIndex; continue};

        private _delta = _time - _started;
        if (_delta > _duration) then {_toRemove pushBack _forEachIndex; continue};

        private _distanceSqr = _cameraPos distanceSqr _source;
        private _scale =
            linearConversion [250, 250000, _distanceSqr, 1, 0.5, true]
            + (_started * 1000 random 0.25);
        private _opacity = linearConversion [1, _duration, _delta, 1, 0, true];
        private _color = [1, 0.1, 0, _opacity];

        drawIcon3D [
            "a3\ui_f\data\igui\cfg\cursors\select_ca.paa",
            _color,
            _source modelToWorldVisual (_source selectionPosition "Spine3"),
            _scale,
            _scale,
            0
        ];
    } forEach WHF_projectiles_launches;
    {WHF_projectiles_launches deleteAt _x} forEach _toRemove;
}];
