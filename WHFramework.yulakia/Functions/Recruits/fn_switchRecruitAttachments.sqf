/*
Function: WHF_fnc_switchRecruitAttachments

Description:
    Switch the attachments of recruits to match the player's attachments.
    Requires CBA Accessory and CBA Events.
    https://github.com/CBATeam/CBA_A3/blob/master/addons/accessory/fnc_switchAttachment.sqf

Parameters:
    Object unit:
        The unit whose attachment to match.
    String currItem:
        The attachment that was switched.
    String switchItem:
        The attachment to switch to.
    Number currWeaponType:
        The weapon that was switched.

Author:
    thegamecracks

*/
params ["_unit", "_currItem", "_switchItem", "_currWeaponType"];
if (isNil "CBA_fnc_execNextFrame") exitWith {};
if (_unit isNotEqualTo focusOn) exitWith {};
if (_currItem isEqualTo "") exitWith {};
if (!local group _unit) exitWith {};
if (leader _unit isNotEqualTo _unit) exitWith {};

private _recruits = units _unit select {
    !isPlayer _x
    && {local _x
    && {alive _x
    && {_x getVariable ["WHF_recruiter", ""] isEqualTo getPlayerUID player}}}
};

{
    private _recruit = _x;
    private _args = [_recruit, _switchItem];
    switch (_currWeaponType) do {
        case 0: {
            if !(_currItem in primaryWeaponItems _recruit) exitWith {};
            _recruit removePrimaryWeaponItem _currItem;
            [{_this # 0 addPrimaryWeaponItem _this # 1}, _args] call CBA_fnc_execNextFrame;
        };
        case 1: {
            if !(_currItem in handgunItems _recruit) exitWith {};
            _recruit removeHandgunItem _currItem;
            [{_this # 0 addHandgunItem _this # 1}, _args] call CBA_fnc_execNextFrame;
        };
        case 2: {
            if !(_currItem in secondaryWeaponItems _recruit) exitWith {};
            _recruit removeSecondaryWeaponItem _currItem;
            [{_this # 0 addSecondaryWeaponItem _this # 1}, _args] call CBA_fnc_execNextFrame;
        };
    };
} forEach _recruits;
