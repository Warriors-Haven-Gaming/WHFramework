/*
Function: WHF_fnc_initManualFireSlewHandlers

Description:
    Set up laser target handlers for recruits.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

// For performance, assume turret path is always [0]
#define TURRET_PATH [0]
WHF_vehicle_slewed = objNull;
// WHF_helper = createVehicleLocal ["Sign_Sphere100cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
addMissionEventHandler ["EachFrame", {
    if (isGamePaused) exitWith {};

    private _maybeResetSlew = {
        if (isNull _active) exitWith {};
        if (local gunner _active && {isManualFire _active}) exitWith {};
        _active lockCameraTo [objNull, TURRET_PATH, false];
        _active = objNull;
        WHF_vehicle_slewed = objNull;
    };
    private _maybeStartSlew = {
        if (!isNull _active) exitWith {};
        if (!isManualFire _candidate) exitWith {};
        if (!local gunner _candidate) exitWith {};
        if !(_candidate isKindOf "Air") exitWith {}; // could work with ground vics, but guns aren't zeroed
        _active = _candidate;
        WHF_vehicle_slewed = _candidate;
    };
    private _updateSlew = {
        if (isNull _active) exitWith {};
        private _targetASL = call {
            private _startASL = AGLToASL positionCameraToWorld [0, 0, 0];
            private _endASL = AGLToASL positionCameraToWorld [0, 0, 5000];
            private _targets = lineIntersectsSurfaces [_startASL, _endASL, cameraOn, objNull, true, 1, "FIRE"];
            if (_targets isNotEqualTo []) exitWith {_targets # 0 # 0};
            _endASL
        };
        // WHF_helper setPosASL _targetASL;
        _active lockCameraTo [_targetASL, TURRET_PATH, false];
    };

    private _active = missionNamespace getVariable ["WHF_vehicle_slewed", objNull];
    private _candidate = cameraOn;
    call _maybeResetSlew;
    call _maybeStartSlew;
    call _updateSlew;
}];
