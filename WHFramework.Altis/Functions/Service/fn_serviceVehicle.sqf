/*
Function: WHF_fnc_serviceVehicle

Description:
    Service the given vehicle.
    Function must be executed where vehicle is local.

Parameters:
    Object vehicle:
        The vehicle to be serviced.

Author:
    thegamecracks

*/
params ["_vehicle"];

_vehicle setDamage 0;
_vehicle setVehicleAmmo 1;
_vehicle setFuel 1;

_vehicle setRepairCargo 1;
_vehicle setAmmoCargo 1;
_vehicle setFuelCargo 1;

private _apsAmmo = _vehicle getVariable "WHF_aps_ammo_max";
if (!isNil "_apsAmmo") then {_vehicle setVariable ["WHF_aps_ammo", _apsAmmo, true]};
