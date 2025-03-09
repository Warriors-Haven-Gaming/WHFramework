/*
Function: WHF_fnc_addCarryAction

Description:
    Add a carry action to an incapacitated unit.

Parameters:
    Object unit:
        The unit to add revive actions to.

Author:
    thegamecracks

*/
params ["_unit"];

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
        params ["", "_caller"];
        if !("slow" in animationState _caller) then {
            _caller action ["WeaponOnBack", _caller];
        };
    },
    {},
    {
        params ["_target", "_caller"];
        [_caller, _target] call WHF_fnc_carryUnit;
    },
    {},
    [],
    2.5,
    11,
    false
] call BIS_fnc_holdActionAdd;
_unit setVariable ["WHF_revive_carryID", _carryID];
