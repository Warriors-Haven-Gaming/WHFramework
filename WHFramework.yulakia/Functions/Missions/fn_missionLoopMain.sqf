/*
Function: WHF_fnc_missionLoopMain

Description:
    Continuously spawn main mission scripts.

Author:
    thegamecracks

*/
private _minScripts = {if (WHF_missions_main_enabled) then {WHF_missions_main_min} else {0}};
private _maxScripts = {if (WHF_missions_main_enabled) then {WHF_missions_main_max} else {0}};

private _scripts = [];
private _countActiveScripts = {
    {
        if (scriptDone _x) then {_scripts deleteAt _forEachIndex};
    } forEachReversed _scripts;
    count _scripts
};

private _spawnNextScript = {
    // Add any complex logic here for stateful mission generation.
    // For example, an FOB mission can be generated and then later
    // followed up with a FOB defense mission.
    if (random 1 < 1) exitWith {
        if (_total > 0) then {sleep (60 + random 120)}; // Grace period
        [] spawn WHF_fnc_msnMainAnnexRegion
    };
    scriptNull
};

private _spawning = true;
private _total = 0;

while {true} do {
    private _nScripts = call _countActiveScripts;
    private _maxScripts = call _maxScripts;
    private _minScripts = call _minScripts min _maxScripts;

    switch (true) do {
        case (!_spawning && {_nScripts < _minScripts}): {
            _spawning = true;
        };
        case (_spawning && {_nScripts >= _maxScripts}): {
            _spawning = false;
        };
        case (_spawning): {
            private _script = call _spawnNextScript;
            if (isNull _script) exitWith {sleep 10}; // No available missions

            _scripts pushBack _script;
            _total = _total + 1;
            sleep (3 + random 30);
        };
        default {
            // Idle state, nothing to do here
            sleep (5 + random 5);
        };
    };
};
