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
