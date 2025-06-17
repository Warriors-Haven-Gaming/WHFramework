/*
Function: WHF_fnc_msnDefendAidSuppliesReinforcements

Description:
    Continuously spawn attackers to move towards supplies.
    Function must be ran in scheduled environment.

Parameters:
    Array signal:
        An array that should contain a single boolean.
        By setting this to false, the function can be safely terminated
        during execution. Units will be ordered to retreat.
    Position2D center:
        The center of the mission area.
    Array supplies:
        The supplies being defended.
    String factionRaid:
        The attacking faction to spawn units from.
    Array groups:
        An array to append groups to.
        Useful for garbage collection.
    Array vehicles:
        An array to append vehicles to.
        Useful for garbage collection.

Author:
    thegamecracks

*/
params ["_signal", "_center", "_supplies", "_factionRaid", "_groups", "_vehicles"];

private _reinforceUnits = {
    params ["_center", "_supplies", "_factionRaid", "_groups"];

    if (_supplies findIf {alive _x} < 0) exitWith {};

    private _quantity = 4 + floor random 5;
    private _newGroups = [
        opfor,
        [
            [[["standard", _factionRaid]], 2, 8, 0], 0.8,
            [[[   "recon", _factionRaid]], 2, 8, 1], 0.1,
            [[[   "elite", _factionRaid]], 4, 8, 2], 0.05,
            [[[  "sniper", _factionRaid]], 2, 2, 3], 0.05
        ],
        _quantity,
        _center getPos [600, random 360],
        400,
        ["hidden", "noDynamicSimulation"]
    ] call WHF_fnc_spawnUnitGroups;

    {
        _x enableAttack false;
        _x setBehaviourStrong "AWARE";
        _x setCombatMode "WHITE";
        _x setSpeedMode "FULL";

        if (random 1 < 0.75) then {
            private _enableTargeting = {
                params ["_unit"];
                _unit removeEventHandler [_thisEvent, _thisEventHandler];
                _unit enableAI "AUTOTARGET";
                _unit enableAI "TARGET";
            };
            {
                _x addEventHandler ["FiredNear", _enableTargeting];
                _x addEventHandler ["Hit", _enableTargeting];
                _x disableAI "AUTOTARGET";
                _x disableAI "TARGET";
            } forEach units _x;
        };
    } forEach _newGroups;
    _groups append _newGroups;
};

private _reinforceVehicles = {
    params ["_center", "_supplies", "_factionRaid", "_groups", "_vehicles"];

    if (_supplies findIf {alive _x} < 0) exitWith {};

    private _standard = ["standard", _factionRaid];
    private _group = [
        opfor,
        [_standard],
        [_standard],
        1,
        _center,
        [300, 750],
        ["hidden", "noDynamicSimulation"]
    ] call WHF_fnc_spawnVehicles;

    _group enableAttack false;
    _group setBehaviourStrong "AWARE";
    _group setCombatMode "WHITE";
    _group setSpeedMode "FULL";
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _reinforceArgs = [
    [true, 30, 64, _groups, [_center, _supplies, _factionRaid, _groups], _reinforceUnits],
    [true, 120, 10, _vehicles, [_center, _supplies, _factionRaid, _groups, _vehicles], _reinforceVehicles]
];
private _reinforceScripts = _reinforceArgs apply {_x spawn WHF_fnc_reinforceLoop};

private _hasNearestSupplyWaypoint = {
    params ["_group", "_supply"];
    private _current = currentWaypoint _group;
    private _waypoints = waypoints _x;
    if (_current >= count _waypoints) exitWith {false};

    private _pos = waypointPosition (_waypoints # _current);
    _pos distance _supply < 5
};

while {true} do {
    sleep 3;
    if !(_signal # 0) exitWith {};

    private _supplies = _supplies select {alive _x};
    if (count _supplies < 1) exitWith {};

    {
        if (units _x findIf {alive _x} < 0) then {continue};

        private _supply = [leader _x, _supplies] call WHF_fnc_nearestPosition;
        if ([_x, _supply] call _hasNearestSupplyWaypoint) then {continue};

        [_x] call WHF_fnc_clearWaypoints;
        private _waypoint = _x addWaypoint [getPosASL _supply, -1];
        _waypoint setWaypointCompletionRadius 5;
        _waypoint setWaypointTimeout [30, 30, 30];
        {_x doMove getPosATL _supply} forEach units _x;
    } forEach _groups;
};

{_x set [0, false]} forEach _reinforceArgs;
waitUntil {sleep 1; _reinforceScripts findIf {!scriptDone _x} < 0};

{
    [_x, _center] spawn {
        scriptName "WHF_fnc_msnDefendAidSuppliesReinforcements_retreat";
        params ["_group", "_center"];
        [_group] call WHF_fnc_clearWaypoints;
        sleep random 5;
        private _dir = _center getDir leader _group;
        private _pos = _center getPos [1000, _dir];
        _group addWaypoint [_pos, 0];
        _group setCombatMode "WHITE";
        {_x setUnitPos "AUTO"; _x doMove _pos} forEach units _group;
    };
} forEach _groups;
