/*
Function: WHF_fnc_missionLoop

Description:
    Periodically spawns the given missions.

Parameters:
    Array functions:
        The function names of each mission to spawn.
    Code minScripts:
        A function that returns minimum number of active missions allowed.
    Code maxScripts:
        A function that returns maximum number of active missions allowed.
        Takes priority over minScripts.

Author:
    thegamecracks

*/
params ["_functions", "_minScripts", "_maxScripts"];

if (count _functions < 1) exitWith {
    diag_log text format ["%1: No functions to call", _fnc_scriptName];
};

private _functionCounts = createHashMapFromArray (_functions apply {[_x, 0]});
private _scripts = [];
private _countActiveScripts = {
    {
        if (scriptDone _x) then {_scripts deleteAt _forEachIndex};
    } forEachReversed _scripts;
    count _scripts
};
private _refreshFunctionCounts = {
    /* Ensures that function counts don't go out of bounds. */
    private _counts = values _functionCounts;
    if (selectMax _counts < 1000) exitWith {};
    private _min = selectMin _counts;
    {_functionCounts set [_x, _y - _min]} forEach _functionCounts;
};
private _checkPredicate = {
    params ["_function"];
    // TODO: allow predicates to pass-through arguments to the function
    private _predicate = missionNamespace getVariable [_function + "PreCondition", {true}];
    [] call _predicate
};
private _selectRandomFunction = {
    /* Selects a random mission function to be spawned. */
    call _refreshFunctionCounts;

    if (count _functionCounts < 2) exitWith {
        private _selected = keys _functionCounts select 0;
        _functionCounts set [_selected, (_functionCounts get _selected) + 1];
        if ([_selected] call _checkPredicate) then {_selected}
    };

    private _total = 0;
    {_total = _total + _y} forEach _functionCounts;

    private _functionChances = createHashMapFromArray (
        // Bias towards missions that haven't been spawned as much
        _functionCounts apply {
            private _chance = 1 - _y / (_total max 1);
            [_x, _chance]
        }
    );

    for "_i" from 1 to 30 do {
        private _selected = keys _functionChances selectRandomWeighted values _functionChances;
        _functionCounts set [_selected, (_functionCounts get _selected) + 1];
        if ([_selected] call _checkPredicate) exitWith {_selected};
    }
};

while {true} do {
    private _nScripts = call _countActiveScripts;
    private _maxScripts = call _maxScripts;
    private _minScripts = call _minScripts min _maxScripts;
    if (_nScripts < _minScripts) then {
        for "_i" from 1 to (_maxScripts - _nScripts) do {
            private _function = call _selectRandomFunction;
            if (isNil "_function") then {continue};

            private _script = [] spawn (missionNamespace getVariable _function);
            _scripts pushBack _script;
            sleep (1 + random 4);
        };
    };
    sleep (60 + random 120);
};
