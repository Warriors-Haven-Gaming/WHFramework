/*
Function: WHF_fnc_setRoleTraits

Description:
    Set a unit's traits to match the given role.

Parameters:
    Object unit:
        The unit to set traits on.
    String role:
        (Optional, default "")
        The role ID to use traits from.
        If empty, the unit's current role is used if available,
        otherwise no changes are applied.

Author:
    thegamecracks

*/
params ["_unit", ["_role", ""]];
if (_role isEqualTo "") then {_role = _unit getVariable ["WHF_role", ""]};
if (_role isEqualTo "") exitWith {};

private _isEngineer = _role in ["engineer"];
private _isMedic = _role in ["medic"];
_unit setUnitTrait ["engineer", _isEngineer];
_unit setUnitTrait ["explosiveSpecialist", _isEngineer];
_unit setUnitTrait ["medic", _isMedic];

private _isSneaky = _role in ["sniper"];
private _camouflageCoef = [1, 0.5] select _isSneaky;
private _audibleCoef = [1, 0.5] select _isSneaky;
_unit setUnitTrait ["camouflageCoef", _camouflageCoef];
_unit setUnitTrait ["audibleCoef", _audibleCoef];
