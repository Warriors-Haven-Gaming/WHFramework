/*
Function: WHF_fnc_initRecruitLaserHandlers

Description:
    Set up laser target handlers for recruits.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    if (!WHF_recruits_lasers_ignore) exitWith {};
    if (leader player isNotEqualTo player) exitWith {};
    if !(_entity isKindOf "LaserTarget") exitWith {};
    group player ignoreTarget _entity;
}];
