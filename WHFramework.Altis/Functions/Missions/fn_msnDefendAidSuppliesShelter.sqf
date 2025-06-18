/*
Function: WHF_fnc_msnDefendAidSuppliesShelter

Description:
    Create a task keeping track of sheltered civilians.
    Function must be ran in scheduled environment.

Parameters:
    Array signal:
        An array that should contain a single boolean.
        By setting this to false, the function can be safely terminated
        during execution.
    Array groups:
        An array containing civilian groups to check for shelter.
    String parent:
        The parent task ID.

Author:
    thegamecracks

*/
params ["_signal", "_groups", "_parent"];

private _civilians = flatten (_groups select {side _x isEqualTo civilian} apply {units _x});
private _initialCivilians = count _civilians;
private _aliveCivilians = {{alive _x} count _civilians};

private _aliveThreshold = ceil (_initialCivilians * 0.85);
if (call _aliveCivilians < _aliveThreshold) exitWith {};

private _getDescription = {
    private _alive = call _aliveCivilians;
    private _casualties = _initialCivilians - _alive;
    private _casualtyThreshold = _initialCivilians - _aliveThreshold + 1;
    private _args = [
        _alive,
        _initialCivilians,
        _casualties,
        _casualtyThreshold
    ];
    [
        ["STR_WHF_defendAidSupplies_shelter_description"] + _args,
        ["STR_WHF_defendAidSupplies_shelter_title"] + _args
    ]
};

private _taskDescription = call _getDescription;
private _taskID = [
    blufor,
    ["", _parent],
    _taskDescription,
    objNull,
    "CREATED",
    -1,
    true,
    "meet"
] call WHF_fnc_taskCreate;

while {true} do {
    sleep 5;

    private _description = call _getDescription;
    if (_taskDescription isNotEqualTo _description) then {
        [_taskID, nil, _description] call BIS_fnc_setTask;
        _taskDescription = _description;
    };

    if !(_signal # 0) exitWith {
        [_taskID, "SUCCEEDED"] spawn WHF_fnc_taskEnd;
    };

    if (call _aliveCivilians < _aliveThreshold) exitWith {
        [_taskID, "CANCELED"] spawn WHF_fnc_taskEnd;
    };
};
