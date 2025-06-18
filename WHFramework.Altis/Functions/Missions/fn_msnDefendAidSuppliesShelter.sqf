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
private _shelteredCivilians = {{alive _x && {insideBuilding _x >= 1}} count _civilians};

private _aliveThreshold = ceil (_initialCivilians * 0.85);
private _getShelterThreshold = {ceil (call _aliveCivilians * 0.5)};
if (call _aliveCivilians < _aliveThreshold) exitWith {};

private _getDescription = {
    private _args = [
        call _aliveCivilians,
        _initialCivilians,
        call _shelteredCivilians,
        _aliveThreshold,
        call _getShelterThreshold
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
        private _sheltered = call _shelteredCivilians >= call _getShelterThreshold;
        private _state = ["CANCELED", "SUCCEEDED"] select _sheltered;
        [_taskID, _state, _sheltered] spawn WHF_fnc_taskEnd;
    };

    if (call _aliveCivilians < _aliveThreshold) exitWith {
        [_taskID, "CANCELED"] spawn WHF_fnc_taskEnd;
    };
};
