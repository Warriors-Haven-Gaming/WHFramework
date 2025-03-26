/*
Function: WHF_fnc_reviveActionAuto

Description:
    Handle automatically performing revives on nearby units.
    Function must be executed in scheduled environment.
    Function must be executed where unit is local.

Parameters:
    Object unit:
        The unit to perform revives.
    Number radius:
        (Optional, default 50)
        The radius at which the unit will search for incapacitated units.
        Units in the same group will always be searched up to 500m.

Author:
    thegamecracks

*/
params ["_unit", ["_radius", 50]];

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

    private _area = [getPosATL _unit, _radius, _radius, 0, false];
    private _groupArea = [getPosATL _unit, 500, 500, 0, false];
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
    if (!isNil "_assigned" && {_unit distance _x >= _x distance _assigned}) exitWith {false};

    if ([_unit, _x] call WHF_fnc_checkRevive isNotEqualTo "") exitWith {false};
    true
};

private _moveToTarget = {
    // params ["_target"];
    _unit doMove getPosATL _target;
    private _timeout = time + 10;
    waitUntil {
        moveToCompleted _unit
        || {time > _timeout
        || {_target getVariable ["WHF_reviveActionAuto_assigned", objNull] isNotEqualTo _unit}}
    };
    _unit doFollow leader _unit;
};

// https://community.bistudio.com/wiki/currentCommand
private _allowedCommands = ["", "WAIT", "ATTACK", "MOVE", "GET OUT", "ATTACKFIRE", "Suppress"];
private _reviveRange = 3;

while {local _unit && {alive _unit}} do {
    sleep (2 + random 2);
    if (!call _canRevive) then {continue};

    call _findNearestTarget params ["_target", "_distance"];
    if (isNull _target) then {continue};

    _target setVariable ["WHF_reviveActionAuto_assigned", _unit];

    if (_distance > _reviveRange) then {
        call _moveToTarget;
        _distance = _unit distance _target;
    };

    if (_distance <= _reviveRange) then {
        [_unit, _target] call WHF_fnc_reviveAction;
    };

    if (_target getVariable ["WHF_reviveActionAuto_assigned", objNull] isEqualTo _unit) then {
        _target setVariable ["WHF_reviveActionAuto_assigned", nil];
    };
};
