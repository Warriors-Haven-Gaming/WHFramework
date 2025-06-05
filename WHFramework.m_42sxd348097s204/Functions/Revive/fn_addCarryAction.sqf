/*
Function: WHF_fnc_addCarryAction

Description:
    Add a carry action to an incapacitated unit.

Parameters:
    Object unit:
        The unit to add carry actions to.

Author:
    thegamecracks

*/
params ["_unit"];

if (isClass (configFile >> "CfgPatches" >> "ace_dragging")) exitWith {};

[_unit, _unit getVariable ["WHF_revive_carryID", -1]] call BIS_fnc_holdActionRemove;
private _carryID = [
    _unit,
    format ["<t color='#00FF00'>%1</t>", localize "$STR_WHF_addCarryAction_action"],
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff1_ca.paa",
    "a3\ui_f\data\igui\cfg\holdactions\holdaction_takeoff2_ca.paa",
    "
    isNil {_this getVariable 'WHF_carry'}
    && {isNil {_originalTarget getVariable 'WHF_revive_caller'}
    && {lifeState _originalTarget in ['INCAPACITATED']
    && {isNull attachedTo _originalTarget
    && {_this distance _target < 3}}}}
    ",
    "true",
    {
        params ["_target", "_caller"];
        _target setVariable ["WHF_carry_caller", _caller];
        _caller call WHF_fnc_lowerWeapon;
    },
    {},
    {
        params ["_target", "_caller"];
        _target setVariable ["WHF_carry_caller", nil];
        [_caller, _target] call WHF_fnc_carryUnit;
    },
    {
        params ["_target"];
        _target setVariable ["WHF_carry_caller", nil];
    },
    [],
    2.5,
    12,
    false
] call BIS_fnc_holdActionAdd;
_unit setVariable ["WHF_revive_carryID", _carryID];
