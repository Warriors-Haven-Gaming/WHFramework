/*
Function: WHF_fnc_detainUnitRequest

Description:
    Handle a unit's attempt to detain another unit.
    Function must be executed where the target is local.

Parameters:
    Object caller:
        The unit attempting to detain the target.
    Object target:
        The unit to be detained. Unit must be local.

Author:
    thegamecracks

*/
params ["_caller", "_target"];
if (!local _target) exitWith {};

private _callerArmed = currentWeapon _caller isNotEqualTo "";
private _targetArmed = currentWeapon _target isNotEqualTo "";

private _requests = [
    "$STR_WHF_detain_request_generic_1",
    "$STR_WHF_detain_request_generic_2",
    "$STR_WHF_detain_request_generic_3",
    "$STR_WHF_detain_request_generic_4"
];
if (vectorMagnitude velocity _target > 1) then {_requests append [
    "$STR_WHF_detain_request_stop_1",
    "$STR_WHF_detain_request_stop_2"
]};
if (_targetArmed) then {_requests append [
    "$STR_WHF_detain_request_gun_1"
]};

[_caller, selectRandom _requests] remoteExec ["WHF_fnc_localChat", WHF_globalPlayerTarget];
_target reveal _caller;
if !(_target checkAIFeature "PATH") then {_target enableAIFeature ["PATH", true]};

sleep (1.5 + random 1);

if !(lifeState _target in ["HEALTHY", "INJURED"]) exitWith {};

private _intimidated = switch (true) do {
    case !(lifeState _caller in ["HEALTHY", "INJURED"]): {false};
    case (side group _target isEqualTo civilian): {true};
    case (!_callerArmed): {false};
    case (_target knowsAbout _caller < 2.5): {true};
    default {random 1 > (0.6 - damage _target * 0.6 - needReload _target * 0.3)};
};
if (!_intimidated) exitWith {
    private _failed = [
        "$STR_WHF_detain_failed_1",
        "$STR_WHF_detain_failed_2",
        "$STR_WHF_detain_failed_3",
        "$STR_WHF_detain_failed_4",
        "$STR_WHF_detain_failed_5",
        "$STR_WHF_detain_failed_6",
        "$STR_WHF_detain_failed_7",
        "$STR_WHF_detain_failed_8",
        "$STR_WHF_detain_failed_9"
    ];
    if (_targetArmed) then {_failed append [
        "$STR_WHF_detain_failed_kill_1",
        "$STR_WHF_detain_failed_kill_2",
        "$STR_WHF_detain_failed_kill_3",
        "$STR_WHF_detain_failed_kill_4"
    ]};
    [_target, selectRandom _failed] remoteExec ["WHF_fnc_localChat", WHF_globalPlayerTarget];
    _target reveal [_caller, 4];
};

private _success = [
    "$STR_WHF_detain_success_1",
    "$STR_WHF_detain_success_2",
    "$STR_WHF_detain_success_3"
];
if (_targetArmed) then {_success append [
    "$STR_WHF_detain_success_gun_1",
    "$STR_WHF_detain_success_gun_2",
    "$STR_WHF_detain_success_gun_3",
    "$STR_WHF_detain_success_gun_4",
    "$STR_WHF_detain_success_gun_5"
]};

[_target, selectRandom _success] remoteExec ["WHF_fnc_localChat", WHF_globalPlayerTarget];
if (side group _target isNotEqualTo civilian) then {
    private _group = createGroup [civilian, true];
    [_target] joinSilent _group;
};
_target enableAIFeature ["PATH", false];
_target setCaptive true;
_target setUnitPos "UP";
moveOut _target;
unassignVehicle _target;

[_target] remoteExec ["WHF_fnc_addPrisonerActions", 0, netId _target + ":addPrisonerActions"];
_target action ["Surrender", _target];
[_target, ["", 0, 0, false]] remoteExec ["switchGesture"];

if (isNil {_target getVariable "WHF_disableGC"}) then {
    _target remoteExec ["WHF_fnc_queueGCDeletion", 2];
};

_target removeWeapon binocular _target;
_target spawn {
    {
        if (_x isEqualTo "") then {continue};

        sleep (0.4 + random 0.2);
        if !(lifeState _this in ["HEALTHY", "INJURED"]) exitWith {};

        private _distance = [0, -1, 1] select _forEachIndex;
        private _start = ATLToASL (_this modelToWorldVisual [_distance, 0.5, 1.5]);
        private _end = AGLToASL (_start vectorMultiply [1, 1, 0]);
        private _surfaces = lineIntersectsSurfaces [_start, _end, _this];

        private _pos = if (count _surfaces > 0) then {ASLToATL (_surfaces # 0 # 0)} else {
            _this modelToWorldVisual [_distance, 0.5, 0]
        };
        private _normal = if (count _surfaces > 0) then {_surfaces # 0 # 1} else {
            surfaceNormal _pos
        };

        private _holder = createVehicle ["GroundWeaponHolder", _pos, [], 0, "CAN_COLLIDE"];
        _holder setDir random 360;
        _holder setVectorUp _normal;
        _this actionNow ["DropWeapon", _holder, _x];
    } forEach [primaryWeapon _this, handgunWeapon _this, secondaryWeapon _this];
};

_target spawn {
    sleep 5;
    while {alive _this && {captive _this}} do {
        sleep (1 + random 1);
        if (isNil {_this getVariable "WHF_prisoner_actionIDs"}) then {break};
        if (!isNull objectParent _this) then {continue};
        if !(lifeState _this in ["HEALTHY", "INJURED"]) then {continue};
        if (unitPos _this isNotEqualTo "Up") then {_this setUnitPos "UP"};
        if (stance _this isNotEqualTo "STAND") then {continue};
        if (animationState _this isEqualTo "amovpercmstpssurwnondnon") then {continue};
        [_this, ["amovpercmstpssurwnondnon", 0, 0, false]] remoteExec ["switchMove"];
    };
};
