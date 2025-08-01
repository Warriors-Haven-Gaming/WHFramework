/*
Function: WHF_fnc_respawnLoop

Description:
    Handles respawning of objects.
    Function must be executed on server and in scheduled environment.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

private _isDeserted = {
    if (!alive _object) exitWith {false};
    if (crew _object findIf {alive _x} >= 0) exitWith {false};
    if (_object distanceSqr _pos < 1000) exitWith {false};

    private _radius = WHF_respawn_desertedDistance;
    private _area = [getPosATL _object, _radius, _radius];
    if ([_units, _area] call WHF_fnc_anyInArea) exitWith {false};

    true
};

private _respawnVehicle = {
    deleteVehicle _obstructions;
    if (alive _object) exitWith _restoreVehicle;

    deleteVehicle _object;
    sleep 0.5; // Allow for some network delay (and for physics to catch up)

    private _type = _record get "_type";
    private _dir = _record get "_dir";
    private _pylons = _record get "_pylons";
    private _textures = _record get "_textures";
    private _vars = _record get "_vars";

    private _object = createVehicle [_type, [-random 500, -random 500, random 500], [], 0, "CAN_COLLIDE"];
    {_object setPylonLoadout [_x # 0, _x # 3, true, _x # 2]} forEach _pylons;
    {_object setObjectTextureGlobal [_forEachIndex, _x]} forEach _textures;
    {_object setVariable _x} forEach _vars;
    sleep 0.125; // Animations don't like applying on new vehicles unless we wait
    call _animateVehicle;

    // TODO: parameterize UAV side
    private _isUAV = getNumber (configOf _object >> "isUAV") > 0;
    if (_isUAV) then {blufor createVehicleCrew _object};

    _object setDir _dir;
    if (!surfaceIsWater _pos) then {_object setVectorUp surfaceNormal _pos};
    _object setPosATL _pos;

    _object
};

private _restoreVehicle = {
    detach _object;
    {moveOut _x} forEach crew _object;

    _object setOwner 2;
    sleep 0.5; // Allow for some network delay

    private _pylons = _record get "_pylons";
    {_object setPylonLoadout [_x # 0, _x # 3, true, _x # 2]} forEach _pylons;

    _object engineOn false;
    _object setCollisionLight false;
    _object setPilotLight false;
    [_object] call WHF_fnc_serviceVehicle;
    call _animateVehicle;

    private _dir = _record get "_dir";
    _object setDir _dir;
    _object setPosATL _pos;

    _object
};

private _animateVehicle = {
    private _animations = _record get "_animations";
    private _animationDoors = _record get "_animationDoors";
    private _animationSources = _record get "_animationSources";
    {_object animate [_x # 0, _x # 1, true]} forEach _animations;
    {_object animateDoor [_x # 0, _x # 1, true]} forEach _animationDoors;
    {_object animateSource [_x # 0, _x # 1, true]} forEach _animationSources;
};

while {true} do {
    sleep (5 + random 5);

    private _time = time;

    private _recruits = allUnits select {!isNil {_x getVariable "WHF_recruiter"}};
    private _remoteControlledUnits = allPlayers apply {remoteControlled _x} select {!isNull _x};

    private _units = allPlayers;
    _units append _recruits;
    _units append _remoteControlledUnits;
    _units = _units arrayIntersect _units;

    {
        private _record = _x;
        private _respawnAt = _record get "_respawnAt";
        private _object = _record get "_object";
        private _pos = _record get "_pos";

        private _shouldRespawn = switch (true) do {
            case (_respawnAt >= 0): {_time >= _respawnAt};
            case (call _isDeserted): {true};
            case (!alive _object): {
                _record set ["_respawnAt", time + WHF_respawn_delay];
                false
            };
            default {false};
        };
        if (!_shouldRespawn) then {sleep 0.125; continue};

        private _radius = _record get "_radius";
        private _obstructions = [_pos, _radius] call WHF_fnc_nearObjectsRespawn;
        if (_obstructions findIf {alive _x} >= 0) then {sleep 0.125; continue};

        _object = call _respawnVehicle;
        _record set ["_object", _object];
        _record set ["_respawnAt", -1];
    } forEach WHF_respawn_records;
};
