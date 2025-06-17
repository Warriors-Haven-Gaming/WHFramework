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

    private _supply = selectRandom (_supplies select {alive _x});
    if (isNil "_supply") exitWith {};

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
        {
            _x disableAI "AUTOCOMBAT";
            _x disableAI "COVER";
            _x disableAI "SUPPRESSION";
        } forEach units _x;
        _x enableAttack false;
        _x setBehaviourStrong "AWARE";
        _x setCombatMode "WHITE";
        _x setSpeedMode "FULL";
    } forEach _newGroups;
    _groups append _newGroups;
};

private _reinforceVehicles = {
    params ["_center", "_supplies", "_factionRaid", "_groups", "_vehicles"];

    private _supply = selectRandom (_supplies select {alive _x});
    if (isNil "_supply") exitWith {};

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

    {
        _x disableAI "AUTOCOMBAT";
        _x disableAI "COVER";
        _x disableAI "SUPPRESSION";
    } forEach units _group;
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

while {true} do {
    sleep 3;
    if !(_signal # 0) exitWith {};

    {
        if (units _x findIf {alive _x} < 0) then {continue};
        if (currentWaypoint _x < count waypoints _x) then {continue};

        private _supply = selectRandom (_supplies select {alive _x});
        if (isNil "_supply") then {break};

        private _waypoint = _x addWaypoint [getPosASL _supply, -1];
        _waypoint setWaypointCompletionRadius 10;
        _waypoint setWaypointTimeout [30, 30, 30];
    } forEach _groups;
};

{_x set [0, false]} forEach _reinforceArgs;
waitUntil {sleep 1; _reinforceScripts findIf {!scriptDone _x} < 0};

{
    [_x, _center] spawn {
        scriptName "WHF_fnc_msnDefendAidSuppliesReinforcements_retreat";
        params ["_group", "_center"];
        if (currentWaypoint _group > 0) then {
            [_group, currentWaypoint _group] setWaypointPosition [getPosASL leader _group, -1];
            sleep (0.1 + random 5);
            {deleteWaypoint _x} forEachReversed waypoints _group;
        };
        private _dir = _center getDir leader _group;
        private _pos = _center getPos [1000, _dir];
        _group addWaypoint [_pos, 0];
        _group setCombatMode "WHITE";
        {_x setUnitPos "AUTO"} forEach units _group;
    };
} forEach _groups;
