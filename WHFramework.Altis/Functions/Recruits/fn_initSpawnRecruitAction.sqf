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
        params ["_spawner", "", "", "_position"];
        _position = _spawner modelToWorld _position vectorMultiply [1,1,0];
        [_position] call WHF_fnc_spawnRecruitGUI;
    },
    _position,
    12,
    true,
    false,
    "",
    "
    WHF_recruits_limit > 0
    && {count allPlayers <= WHF_recruits_limit_player
    && {leader _this isEqualTo _this}}
    ",
    3
];
_spawner addAction [
    localize "$STR_WHF_rearmRecruits",
    {
        private _recruits = units focusOn select {
            !isPlayer _x
            && {local _x
            && {focusOn distance _x < 100
            && {_x getVariable ["WHF_recruiter", ""] isEqualTo getPlayerUID player
            && {!isNil {_x getVariable "WHF_role"}}}}}
        };

        // Filter out recruits whose roles have no saved loadouts
        private _roles = _recruits apply {_x getVariable "WHF_role"};
        _roles = _roles arrayIntersect _roles;

        private _loadouts = createHashMapFromArray (_roles apply {
            [_x, [_x] call WHF_fnc_getLastLoadout]
        });

        _recruits = _recruits select {
            private _role = _x getVariable "WHF_role";
            _loadouts get _role isNotEqualTo []
        };

        {
            private _role = _x getVariable "WHF_role";
            private _loadout = _loadouts get _role;
            _x setUnitLoadout _loadout;
        } forEach _recruits;

        if (count _recruits > 0) then {
            hint format [
                localize "$STR_WHF_rearmRecruits_completed",
                count _recruits
            ];
        } else {
            hint localize "$STR_WHF_rearmRecruits_none";
        };
    },
    nil,
    12,
    true,
    true,
    "",
    "WHF_recruits_limit > 0 && {leader _this isEqualTo _this}",
    3
];
