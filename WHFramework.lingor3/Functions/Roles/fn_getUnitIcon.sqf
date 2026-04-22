/*
Function: WHF_fnc_getUnitIcon

Description:
    Return the icon representing the given unit,
    preferring their role icon if available.

Parameters:
    Object | String unit:
        The unit or unit type to get the icon of.

Returns:
    String

Author:
    thegamecracks

*/
params ["_unit"];

if (_unit isEqualType "") exitWith {
    getText (configFile >> "CfgVehicles" >> _unit >> "icon")
};

private _role = _unit getVariable "WHF_role";
if (isNil "_role") exitWith {getText (configOf _unit >> "icon")};

private _icon = [_role] call WHF_fnc_getRoleIcon;
if (_icon isEqualTo "") exitWith {getText (configOf _unit >> "icon")};

_icon
