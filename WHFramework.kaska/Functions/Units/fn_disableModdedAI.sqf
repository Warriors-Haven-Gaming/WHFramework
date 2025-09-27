/*
Function: WHF_fnc_disableModdedAI

Description:
    Disable certain AI mods from affecting the given group.
    Function must be executed where the group is local.

Parameters:
    Group group:
        The group to disable modded AI.

Author:
    thegamecracks

*/
params ["_group"];

// https://github.com/nk3nny/LambsDanger/wiki/variables
_group setVariable ["lambs_danger_disableGroupAI", true];
{_x setVariable ["lambs_danger_disableAI", true]} forEach units _group;
