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

Author:
    thegamecracks

*/
params ["_unit", ["_radius", 50]];

// https://community.bistudio.com/wiki/currentCommand
private _allowedCommands = ["", "WAIT", "ATTACK", "MOVE", "GET OUT", "ATTACKFIRE", "Suppress"];
private _reviveRange = 3;

while {local _unit && {alive _unit}} do {
    sleep (2 + random 2);
    if !(lifeState _unit in ["HEALTHY", "INJURED"]) then {continue};
    if (!isNull objectParent _unit) then {continue};
    if (!isNull (_unit getVariable ["WHF_revive_target", objNull])) then {continue};
    if !(currentCommand _unit in _allowedCommands) then {continue};

    private _units = switch (WHF_recruits_revive_targets) do {
        case 2: {allUnits};
        case 0: {units group _unit};
        default {units side group _unit};
    };

    private _area = [getPosATL _unit, _radius, _radius, 0, false];
    private _targets = _units select {call {
        if (isNil {_x getVariable "WHF_revive_actionID_remote"}) exitWith {false};
        if !(_x inArea _area) exitWith {false};

        private _assigned = _x getVariable "WHF_reviveActionAuto_assigned";
        if (!isNil "_assigned" && {_unit distance _x >= _x distance _assigned}) exitWith {false};

        if ([_unit, _x] call WHF_fnc_checkRevive isNotEqualTo "") exitWith {false};
        true
    }};
    if (count _targets < 1) then {continue};

    private _distances = [];
    {_distances pushBack [_unit distance _x, _forEachIndex]} forEach _targets;
    _distances sort true;

    _distances # 0 params ["_initialDistance", "_targetIndex"];
    private _target = _targets # _targetIndex;

    if (_initialDistance <= _reviveRange) then {
        [_unit, _target] call WHF_fnc_reviveAction;
        continue;
    };

    _target setVariable ["WHF_reviveActionAuto_assigned", _unit];
    _unit doMove getPosATL _target;
    private _timeout = time + 10;
    waitUntil {
        moveToCompleted _unit
        || {time > _timeout
        || {_target getVariable ["WHF_reviveActionAuto_assigned", objNull] isNotEqualTo _unit}}
    };

    if (_target getVariable ["WHF_reviveActionAuto_assigned", objNull] isEqualTo _unit) then {
        _target setVariable ["WHF_reviveActionAuto_assigned", nil];
    };

    _unit doFollow leader _unit;
    if (_unit distance _target > _reviveRange) then {continue};
    [_unit, _target] call WHF_fnc_reviveAction;
};
