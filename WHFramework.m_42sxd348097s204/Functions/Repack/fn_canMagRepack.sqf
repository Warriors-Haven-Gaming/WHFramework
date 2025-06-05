/*
Function: WHF_fnc_canMagRepack

Description:
    Check if a unit can repack magazines.

Parameters:
    Object unit:
        The unit to check.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_unit"];
if (isClass (configFile >> "CfgPatches" >> "ace_magazinerepack")) exitWith {false};

private _vehicle = objectParent _unit;
if (isEngineOn _vehicle && {currentPilot _vehicle isEqualTo _unit}) exitWith {false};
if (!isTouchingGround vehicle _unit) exitWith {false};
if !(lifeState _unit in ["HEALTHY", "INJURED"]) exitWith {false};
if (!isNil {_unit getVariable "WHF_magRepack"}) exitWith {false};

private _magazineGroups = [_unit, true] call WHF_fnc_groupMagazines;
if (count _magazineGroups < 1) exitWith {false};

true
