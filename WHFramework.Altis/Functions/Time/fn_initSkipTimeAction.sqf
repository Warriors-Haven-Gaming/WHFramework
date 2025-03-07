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
    11,
    true,
    true,
    "",
    "WHF_requestSkipTime_enabled && {daytime < 5 || {daytime > 12}}",
    3
];
_obj addAction [
    localize "$STR_WHF_initSkipTimeAction_noon",
    {[player, "noon"] remoteExec ["WHF_fnc_requestSkipTime", 2]},
    [],
    11,
    true,
    true,
    "",
    "WHF_requestSkipTime_enabled && {daytime < 10 || {daytime > 17}}",
    3
];
_obj addAction [
    localize "$STR_WHF_initSkipTimeAction_evening",
    {[player, "evening"] remoteExec ["WHF_fnc_requestSkipTime", 2]},
    [],
    11,
    true,
    true,
    "",
    "WHF_requestSkipTime_enabled && {daytime < 15 || {daytime > 22}}",
    3
];
