/*
Function: WHF_fnc_msnDefendAidSuppliesReinforcements

Description:
    Continuously spawn attackers to move towards supplies.
    Function must be ran in scheduled environment.

Parameters:
    Array signal:
        An array that should contain a single boolean.
        By setting this to false, the function can be safely terminated
        during execution. The status task will count as completed.
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

    private _pos = getPosATL selectRandom (_supplies select {alive _x});
    if (isNil "_pos") exitWith {};

    private _quantity = 8 + floor random 9;
    private _newGroups = [
        opfor,
        [
            [[["standard", _factionRaid]], 2, 8, 0], 0.8,
            [[[   "recon", _factionRaid]], 2, 8, 1], 0.1,
            [[[   "elite", _factionRaid]], 4, 8, 2], 0.05,
            [[[  "sniper", _factionRaid]], 2, 2, 3], 0.05
        ],
        _quantity,
        _center getPos [500 + random 250, random 360],
        200,
        ["hidden", "noDynamicSimulation"]
    ] call WHF_fnc_spawnUnitGroups;

    {
        {
            _x disableAI "AUTOCOMBAT";
            _x disableAI "COVER";
            _x disableAI "SUPPRESSION";
        } forEach units _x;
        _x addWaypoint [ATLToASL _pos, -1];
        _x addWaypoint [getPosASL leader _x, -1];
        _x enableAttack false;
        _x setBehaviourStrong "AWARE";
        _x setSpeedMode "FULL";
    } forEach _newGroups;
    _groups append _newGroups;
};

private _reinforceVehicles = {
    params ["_center", "_supplies", "_factionRaid", "_groups", "_vehicles"];

    private _pos = getPosATL selectRandom (_supplies select {alive _x});
    if (isNil "_pos") exitWith {};

    private _standard = ["standard", _factionRaid];
    // TODO: disable dynamic simulation on vehicles
    private _group = [
        opfor,
        [_standard],
        [_standard],
        1,
        _center,
        [300, 750],
        ["hidden"]
    ] call WHF_fnc_spawnVehicles;

    {
        _x disableAI "AUTOCOMBAT";
        _x disableAI "COVER";
        _x disableAI "SUPPRESSION";
    } forEach units _group;
    _group addWaypoint [ATLToASL _pos, -1];
    _group addWaypoint [getPosASL leader _group, -1];
    _group enableAttack false;
    _group setBehaviourStrong "AWARE";
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _reinforceArgs = [
    [true, 30, 64, _groups, [_center, _supplies, _factionRaid, _groups], _reinforceUnits],
    [true, 120, 10, _vehicles, [_center, _supplies, _factionRaid, _groups, _vehicles], _reinforceVehicles]
];
private _reinforceScripts = _reinforceArgs apply {_x spawn WHF_fnc_reinforceLoop};

waitUntil {sleep 1; !(_signal # 0)};
{_x set [0, false]} forEach _reinforceArgs;
waitUntil {sleep 1; _reinforceScripts findIf {!scriptDone _x} < 0};

{
    {deleteWaypoint _x} forEachReversed waypoints _x;
    private _dir = _center getDir leader _x;
    private _pos = _center getPos [1000, _dir];
    _x move _pos;
    _x setCombatMode "WHITE";
} forEach _groups;
