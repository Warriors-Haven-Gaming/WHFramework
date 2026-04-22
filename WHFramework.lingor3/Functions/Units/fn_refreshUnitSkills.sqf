/*
Function: WHF_fnc_refreshUnitSkills

Description:
    Refresh all local units' skill levels based on the WHF_units_skill setting.

Author:
    thegamecracks

*/
{
    if (!local _x) then {continue};
    private _offset = _x getVariable "WHF_units_skill_offset";
    if (isNil "_offset") then {continue};
    [_x, _offset] call WHF_fnc_setUnitSkill;
} forEach allUnits;
