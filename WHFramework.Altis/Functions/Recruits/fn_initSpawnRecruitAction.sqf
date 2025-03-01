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
        [_spawner modelToWorld _position vectorMultiply [1,1,0]] call WHF_fnc_spawnRecruit;
    },
    _position,
    1.5,
    true,
    true,
    "",
    "leader _this isEqualTo _this",
    3
];
_spawner addAction [
    localize "$STR_WHF_rearmRecruits",
    {
        private _recruits = units focusOn select {
            !isPlayer _x
            && {local _x
            && {focusOn distance _x < 100
            && {!isNil {_x getVariable "WHF_recruitLoadout"}}}}
        };

        {_x setUnitLoadout (_x getVariable "WHF_recruitLoadout")} forEach _recruits;

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
    1.5,
    true,
    true,
    "",
    "leader _this isEqualTo _this",
    3
];
