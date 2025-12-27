/*
Function: WHF_fnc_initSkipTimeAction

Description:
    Add skip time actions to an object.

Parameters:
    Object obj:
        The object to add the action to.

Author:
    thegamecracks

*/
params ["_obj"];
_obj addAction [
    localize "$STR_WHF_initSkipTimeAction_morning",
    {[player, "morning"] remoteExec ["WHF_fnc_requestSkipTime", 2]},
    [],
    12,
    true,
    true,
    "",
    toString {
        (dayTime < 5 || {dayTime > 12})
        && {WHF_requestSkipTime_enabled
        || {call BIS_fnc_admin > 0}}
    },
    3
];
_obj addAction [
    localize "$STR_WHF_initSkipTimeAction_noon",
    {[player, "noon"] remoteExec ["WHF_fnc_requestSkipTime", 2]},
    [],
    12,
    true,
    true,
    "",
    toString {
        (dayTime < 10 || {dayTime > 17})
        && {WHF_requestSkipTime_enabled
        || {call BIS_fnc_admin > 0}}
    },
    3
];
_obj addAction [
    localize "$STR_WHF_initSkipTimeAction_evening",
    {[player, "evening"] remoteExec ["WHF_fnc_requestSkipTime", 2]},
    [],
    12,
    true,
    true,
    "",
    toString {
        (dayTime < 15 || {dayTime > 22})
        && {WHF_requestSkipTime_enabled
        || {call BIS_fnc_admin > 0}}
    },
    3
];
