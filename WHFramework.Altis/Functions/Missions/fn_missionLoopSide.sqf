/*
Function: WHF_fnc_missionLoopSide

Description:
    Continuously spawn side mission scripts.

Author:
    thegamecracks

*/
private _functions = [
    "WHF_fnc_msnDefendAidSupplies",
    "WHF_fnc_msnDestroyAAA",
    "WHF_fnc_msnDestroyArmor",
    "WHF_fnc_msnDestroyArtillery",
    "WHF_fnc_msnDestroyBarracks",
    "WHF_fnc_msnDestroyRoadblock",
    "WHF_fnc_msnDownloadIntel",
    "WHF_fnc_msnSecureCaches"
];
private _minScripts = {if (WHF_missions_side_enabled) then {WHF_missions_side_min} else {0}};
private _maxScripts = {if (WHF_missions_side_enabled) then {WHF_missions_side_max} else {0}};

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

private _spawning = true;
private _total = 0;

while {true} do {
    private _nScripts = call _countActiveScripts;
    private _maxScripts = call _maxScripts;
    private _minScripts = call _minScripts min _maxScripts;

    switch (true) do {
        case (!_spawning && {_nScripts < _minScripts}): {
            sleep (120 + random 180); // Grace period
            _spawning = true;
        };
        case (_spawning && {_nScripts >= _maxScripts}): {
            _spawning = false;
        };
        case (_spawning): {
            // Spawn state
            private _function = call _selectRandomFunction;
            if (isNil "_function") exitWith {sleep 10}; // No available missions

            private _script = [] spawn (missionNamespace getVariable _function);
            _scripts pushBack _script;
            _total = _total + 1;
            sleep (30 + random 30);
        };
        default {
            // Idle state
            sleep (5 + random 5);
        };
    };
};
