/*
Function: WHF_fnc_isFriendlyFire

Description:
    Check if the given damage should be considered friendly fire.
    Parameters are the same as those passed to the HandleDamage EH.
    https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#HandleDamage

Author:
    thegamecracks

*/
params ["_unit", "", "", "_source", "", "", "_instigator"];
if (_unit getVariable ["WHF_safezone_friendly", false] isNotEqualTo true) exitWith {false};

private _sideA = side group _unit;
if (_sideA isEqualTo sideUnknown) then {_sideA = _unit getVariable ["WHF_vehicle_side", sideUnknown]};

private _sideB = side group _instigator;
// NOTE: falling back to source side prevents physics damage
// if (_sideB isEqualTo sideUnknown) then {_sideB = side group _source};

_sideA isEqualTo _sideB
