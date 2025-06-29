/*
Function: WHF_fnc_addRecruitLoadoutAction

Description:
    Add an action to edit a recruit's loadout.

Parameters:
    Object recruit:
        The recruit to add the action to.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
params ["_recruit"];

// TODO: consider replacing with equivalent ACE interaction
_recruit removeAction (_recruit getVariable ["WHF_recruitLoadout_actionID", -1]);
private _actionID = _recruit addAction [
    localize "$STR_WHF_addRecruitLoadoutAction_edit",
    {
        params ["_recruit"];
        if (isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
            [_recruit, _recruit, true] call ace_arsenal_fnc_openBox;
        } else {
            ["Open", [true, _recruit, _recruit]] call BIS_fnc_arsenal;
        };
    },
    nil,
    12,
    true,
    true,
    "",
    "
    local _originalTarget
    && {_originalTarget getVariable ['WHF_recruiter', ''] isEqualTo getPlayerUID player
    && {lifeState _originalTarget in ['HEALTHY', 'INJURED']
    && {[getPosATL _originalTarget, 50] call WHF_fnc_isNearArsenal}}}
    ",
    3
];
_recruit setVariable ["WHF_recruitLoadout_actionID", _actionID];
