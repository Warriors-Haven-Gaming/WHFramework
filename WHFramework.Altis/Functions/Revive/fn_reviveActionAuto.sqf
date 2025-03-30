/*
Function: WHF_fnc_reviveActionAuto

Description:
    Handle automatically performing revives on nearby units.
    Function must be executed in scheduled environment.
    Function must be executed where unit is local.

Parameters:
    Object unit:
        The unit to perform revives.

Author:
    thegamecracks

*/
params ["_unit"];

private _canRevive = {
    if !(lifeState _unit in ["HEALTHY", "INJURED"]) exitWith {false};
    if (!isNull objectParent _unit) exitWith {false};
    if (!isNull (_unit getVariable ["WHF_revive_target", objNull])) exitWith {false};
    if !(currentCommand _unit in _allowedCommands) exitWith {false};
    true
};

private _findNearestTarget = {
    private _units = switch (WHF_recruits_revive_targets) do {
        case 2: {allUnits};
        case 0: {units group _unit};
        default {units side group _unit};
    };

    private _radius = WHF_recruits_revive_radius;
    private _area = [getPosATL _unit, _radius, _radius, 0, false];
    private _groupRadius = WHF_recruits_revive_radius_group;
    private _groupArea = [getPosATL _unit, _groupRadius, _groupRadius, 0, false];
    private _targets = _units select {call _isTargetSuitable};
    if (count _targets < 1) exitWith {[objNull, 0]};

    private _distances = [];
    {_distances pushBack [_unit distance _x, _forEachIndex]} forEach _targets;
    _distances sort true;
    _distances # 0 params ["_distance", "_targetIndex"];
    [_targets # _targetIndex, _distance]
};

private _isTargetSuitable = {
    // params ["_x"];
    if (isNil {_x getVariable "WHF_revive_actionID_remote"}) exitWith {false};

    private _area = [_area, _groupArea] select (group _x isEqualTo group _unit);
    if !(_x inArea _area) exitWith {false};

    private _assigned = _x getVariable "WHF_reviveActionAuto_assigned";
    if (
        !isNil "_assigned"
        && {_assigned isNotEqualTo _unit
        && {_unit distance _x >= _x distance _assigned}}
    ) exitWith {false};

    if ([_unit, _x] call WHF_fnc_checkRevive isNotEqualTo "") exitWith {false};
    true
};

private _switchTarget = {
    // params ["_target"];
    if (_target isNotEqualTo _assignedTarget) then {call _cancelTarget};
    _assignedTarget = _target;
    _assignedTarget setVariable ["WHF_reviveActionAuto_assigned", _unit];
};

private _cancelTarget = {
    if (isNull _assignedTarget) exitWith {};
    if (_assignedTarget call _isAssigned) then {
        _assignedTarget setVariable ["WHF_reviveActionAuto_assigned", nil];
    };
    _assignedTarget = objNull;
    _unit doFollow leader _unit;
};

private _isAssigned = {
    private _assigned = _this getVariable "WHF_reviveActionAuto_assigned";
    !isNil "_assigned" && {_assigned isEqualTo _unit}
};

private _moveToTarget = {
    // params ["_target"];
    private _pos = getPosATL _target;
    if (call _shouldRepath) then {_unit doMove _pos};

    private _timeout = time + 3;
    waitUntil {
        moveToCompleted _unit
        || {time > _timeout
        || {!(_target call _isAssigned)}}
    };
    if !(_target call _isAssigned) then {call _cancelTarget};
};

private _shouldRepath = {
    // params ["_pos"];
    expectedDestination _unit params ["_destination", "_plan"];
    _plan isNotEqualTo "LEADER PLANNED" || {_destination distance _pos > _reviveRange}
};

// https://community.bistudio.com/wiki/currentCommand
private _allowedCommands = ["", "WAIT", "ATTACK", "MOVE", "GET OUT", "ATTACKFIRE", "Suppress"];
private _reviveRange = 3;
private _assignedTarget = objNull;

while {true} do {
    if (!local _unit || {!alive _unit}) exitWith {call _cancelTarget};

    if (isNull _assignedTarget) then {sleep (2 + random 2)};
    if (!call _canRevive) then {call _cancelTarget; continue};

    call _findNearestTarget params ["_target", "_distance"];
    if (isNull _target) then {call _cancelTarget; continue};

    call _switchTarget;
    if (_distance > _reviveRange) then {
        call _moveToTarget;
        _distance = _unit distance _target;
    };

    if (_distance <= _reviveRange) then {
        [_unit, _target] call WHF_fnc_reviveAction;
        sleep 0.5; // Allow for some network delay
    };
};
