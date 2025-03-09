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
    Number threshold:
        The maximum number of units before reinforcements are paused.
    Array groups:
        An array of groups to count units from.
        Reinforcement groups that spawn in will be appended to this array.

Author:
    thegamecracks

*/
params ["", "_center", "_radius", "_threshold", "_groups"];
if !(_this # 0) exitWith {};

private _reinforceUnits = {
    params ["_center", "_radius", "_groups"];

    private _pos = [_center, _radius] call WHF_fnc_randomPosHidden;
    if (_pos isEqualTo [0, 0]) then {continue};

    private _types = WHF_missions_annex_units_types;
    private _quantity = selectRandom [2, 4, 6, 8];
    private _group = [opfor, _types, _quantity, _pos, 10] call WHF_fnc_spawnUnits;
    [_group, getPosATL leader _group, 200] call BIS_fnc_taskPatrol;

    _groups pushBack _group;
};

private _frequency = [50, 100];
private _reinforceArgs = [
    [true, _frequency, _threshold, _groups, [_center, _radius, _groups], _reinforceUnits]
];
private _reinforceScripts = _reinforceArgs apply {_x spawn WHF_fnc_reinforceLoop};

waitUntil {sleep (5 + random 5); !(_this # 0)};
{_x set [0, false]} forEach _reinforceArgs;
