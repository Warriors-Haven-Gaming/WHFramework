/*
Function: WHF_fnc_msnMainAnnexRegionReinforcements

Description:
    Periodically spawn reinforcements in the mission.
    Function must be executed in scheduled environment.

Parameters:
    Boolean running:
        Whether the function should run. By setting this to false in
        the arguments array, the function can be safely terminated
        during execution.
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.
    String faction:
        The faction to spawn units from.
    Number thresholdUnits:
        The maximum number of units allowed.
    Array groups:
        An array of groups to count units from.
        Reinforcement groups that spawn in will be appended to this array.
    Array vehicles:
        An array of vehicles to count from. The array's initial size
        will determine the maximum number of vehicles allowed.
        Reinforcement groups that spawn in will be appended to this array.

Author:
    thegamecracks

*/
params [
    "",
    "_center",
    "_radius",
    "_faction",
    "_thresholdUnits",
    "_groups",
    "_vehicles"
];
if !(_this # 0) exitWith {};

private _reinforceUnits = {
    params ["_center", "_radius", "_faction", "_groups"];

    private _unitTypes = +WHF_missions_annex_units_types;
    for "_i" from 0 to (count _unitTypes - 1) step 2 do {
        private _type = _unitTypes # _i # 0;
        _unitTypes # _i set [0, [[_type, _faction]]];
    };

    private _quantity = 2 + floor random 7;
    private _newGroups = [
        opfor,
        _unitTypes,
        _quantity,
        _center,
        _radius,
        ["hidden"]
    ] call WHF_fnc_spawnUnitGroups;

    {[_x, getPosATL leader _x, 200] call BIS_fnc_taskPatrol} forEach _newGroups;
    _groups append _newGroups;
};

private _reinforceVehicles = {
    params ["_center", "_radius", "_faction", "_groups", "_vehicles"];

    private _types = WHF_missions_annex_vehicles_types;
    private _unitTypes = [["standard", _faction]];
    _types = _types apply {[_x, _faction]};

    private _group = [
        opfor,
        _types,
        _unitTypes,
        1,
        _center,
        _radius,
        ["hidden"]
    ] call WHF_fnc_spawnVehicles;

    [_group, getPosATL leader _group, 200] call BIS_fnc_taskPatrol;
    _groups pushBack _group;
    _vehicles append assignedVehicles _group;
};

private _thresholdVehicles = count _vehicles;
private _reinforceArgs = [
    [true, 30, _thresholdUnits, _groups, [_center, _radius, _faction, _groups], _reinforceUnits],
    [true, 30, _thresholdVehicles, _vehicles, [_center, _radius, _faction, _groups, _vehicles], _reinforceVehicles]
];
private _reinforceScripts = _reinforceArgs apply {_x spawn WHF_fnc_reinforceLoop};

while {_this # 0} do {
    sleep 1;
    if !(_this # 0) exitWith {};

    _reinforceArgs # 0 set [1, WHF_missions_annex_reinforce_frequency_units];
    _reinforceArgs # 1 set [1, WHF_missions_annex_reinforce_frequency_vehicles];
};

{_x set [0, false]} forEach _reinforceArgs;
waitUntil {sleep 1; _reinforceScripts findIf {!scriptDone _x} < 0};
