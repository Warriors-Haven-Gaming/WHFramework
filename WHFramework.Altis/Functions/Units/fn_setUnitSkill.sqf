/*
Function: WHF_fnc_setUnitSkill

Description:
    Set a unit's skill level based on the WHF_units_skill setting.

Parameters:
    Object unit:
        The unit to set their skill.
    Number offset:
        (Optional, default 0)
        An offset to add to the skill setting.
        Fractional values are rounded down.

Author:
    thegamecracks

*/
params ["_unit", ["_offset", 0]];

private _level = floor (WHF_units_skill + _offset) max 0 min 4;

switch (_level) do {
    case 0: {
        _unit setSkill 1;
        _unit setSkill ["aimingAccuracy", 0.10 + random 0.10];
        _unit setSkill [   "aimingShake", 0.45 + random 0.10];
        _unit setSkill [   "aimingSpeed", 0.20 + random 0.10];
        _unit setSkill [       "courage", 0.45 + random 0.10];
        _unit setSkill [   "reloadSpeed", 0.35 + random 0.10];
        _unit setSkill [  "spotDistance", 0.20 + random 0.10];
        _unit setSkill [      "spotTime", 0.20 + random 0.10];
    };
    case 1: {
        _unit setSkill 1;
        _unit setSkill ["aimingAccuracy", 0.45 + random 0.10];
        _unit setSkill [   "aimingShake", 0.55 + random 0.10];
        _unit setSkill [   "aimingSpeed", 0.45 + random 0.10];
        _unit setSkill [       "courage", 0.55 + random 0.10];
        _unit setSkill [   "reloadSpeed", 0.45 + random 0.10];
        _unit setSkill [  "spotDistance", 0.50 + random 0.10];
        _unit setSkill [      "spotTime", 0.50 + random 0.10];
    };
    case 2: {
        _unit setSkill 1;
        _unit setSkill ["aimingAccuracy", 0.60 + random 0.10];
        _unit setSkill [   "aimingShake", 0.65 + random 0.20];
        _unit setSkill [   "aimingSpeed", 0.55 + random 0.20];
        _unit setSkill [       "courage", 0.65 + random 0.20];
        _unit setSkill [   "reloadSpeed", 0.55 + random 0.10];
        _unit setSkill [  "spotDistance", 0.60 + random 0.10];
        _unit setSkill [      "spotTime", 0.60 + random 0.10];
    };
    case 3: {
        _unit setSkill 1;
        _unit setSkill ["aimingAccuracy", 0.70 + random 0.10];
        _unit setSkill [   "aimingShake", 0.70 + random 0.20];
        _unit setSkill [   "aimingSpeed", 0.70 + random 0.20];
        _unit setSkill [       "courage", 0.70 + random 0.20];
        _unit setSkill [   "reloadSpeed", 0.70 + random 0.20];
        _unit setSkill [  "spotDistance", 0.70 + random 0.10];
        _unit setSkill [      "spotTime", 0.70 + random 0.10];
    };
    case 4: {
        _unit setSkill 1;
    };
};

_unit setVariable ["WHF_units_skill_offset", _offset];
