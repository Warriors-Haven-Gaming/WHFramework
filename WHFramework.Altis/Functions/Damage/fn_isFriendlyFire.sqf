/*
Function: WHF_fnc_isFriendlyFire

Description:
    Check if the given damage should be considered friendly fire.
    Parameters are the same as those passed to the HandleDamage EH.
    https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#HandleDamage

Author:
    thegamecracks

*/
params ["_unit", "", "", "_source", "_projectile", "", "_instigator"];

private _sideA = side group _unit;
if (_sideA isEqualTo sideUnknown) then {_sideA = _unit getVariable ["WHF_vehicle_side", sideUnknown]};

private _sideB = side group _instigator;
// NOTE: falling back to source side prevents physics damage
// if (_sideB isEqualTo sideUnknown) then {_sideB = side group _source};

switch (true) do {
    case (_sideA isNotEqualTo _sideB): {false};
    case (_unit getVariable ["WHF_safezone_friendly", false] isEqualTo true): {true};
    case (!WHF_damage_ff_missile && {_projectile isKindOf "MissileCore"}): {true};
    case (!WHF_damage_ff_missile && {_projectile isKindOf "RocketCore"}): {true};
    default {false};
}
