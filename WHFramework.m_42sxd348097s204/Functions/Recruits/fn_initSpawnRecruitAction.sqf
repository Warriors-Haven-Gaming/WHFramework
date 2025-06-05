/*
Function: WHF_fnc_initSpawnRecruitAction

Description:
    Add an action to recruit units from a spawner.

Parameters:
    Object spawner:
        The object to add the action to.
    PositionRelative position:
        The relative position to spawn recruits from.

Author:
    thegamecracks

*/
params ["_spawner", "_position"];
_spawner addAction [
    localize "$STR_WHF_spawnRecruit",
    {
        params ["_spawner", "_caller", "", "_position"];

        if (leader _caller isNotEqualTo _caller) exitWith {
            hint localize "$STR_WHF_spawnRecruit_leader";
        };
        if (count allPlayers > WHF_recruits_limit_player) exitWith {
            hint format [localize "$STR_WHF_spawnRecruit_limit_player", WHF_recruits_limit_player];
        };

        _position = _spawner modelToWorld _position vectorMultiply [1,1,0];
        [_position] call WHF_fnc_spawnRecruitGUI;
    },
    _position,
    12,
    true,
    true,
    "",
    "WHF_recruits_limit > 0",
    3
];
_spawner addAction [
    localize "$STR_WHF_rearmRecruits",
    {
        params ["", "_caller"];

        if (leader _caller isNotEqualTo _caller) exitWith {
            hint localize "$STR_WHF_spawnRecruit_leader";
        };
        if (count allPlayers > WHF_recruits_limit_player) exitWith {
            hint format [localize "$STR_WHF_spawnRecruit_limit_player", WHF_recruits_limit_player];
        };

        private _recruits = units _caller select {
            !isPlayer _x
            && {local _x
            && {_caller distance _x < 100
            && {_x getVariable ["WHF_recruiter", ""] isEqualTo getPlayerUID player
            && {!isNil {_x getVariable "WHF_role"}}}}}
        };

        // Filter out recruits whose roles have no saved loadouts
        private _roles = _recruits apply {_x getVariable "WHF_role"};
        _roles = _roles arrayIntersect _roles;

        private _loadouts = createHashMapFromArray (_roles apply {
            [_x, [_x] call WHF_fnc_getLastLoadout]
        });

        if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
            {_x call ace_medical_fnc_fullHeal} forEach _recruits;
        } else {
            {_x setDamage 0} forEach _recruits;
        };

        _recruits = _recruits select {
            private _role = _x getVariable "WHF_role";
            _loadouts get _role isNotEqualTo []
        };

        private _scripts = _recruits apply {
            private _role = _x getVariable "WHF_role";
            private _loadout = _loadouts get _role;

            private _output = [];
            private _script = [_x, _loadout, _output] spawn {
                params ["_x", "_loadout", "_output"];
                scriptName "WHF_fnc_initSpawnRecruitAction_rearmRecruit";
                private _ret = [_x, _loadout] call WHF_fnc_setUnitLoadout;
                _output pushBack _ret;
            };

            [_script, _output]
        };

        waitUntil {_scripts findIf {!scriptDone (_x # 0)} < 0};
        private _rearmed = {_x # 1 # 0} count _scripts;

        if (_rearmed > 0) then {
            hint format [localize "$STR_WHF_rearmRecruits_completed", _rearmed];
        } else {
            hint localize "$STR_WHF_rearmRecruits_none";
        };
    },
    nil,
    12,
    true,
    true,
    "",
    "WHF_recruits_limit > 0",
    3
];
