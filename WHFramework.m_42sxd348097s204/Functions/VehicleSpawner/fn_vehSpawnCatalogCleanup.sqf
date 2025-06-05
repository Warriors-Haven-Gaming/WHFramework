/*
Function: WHF_fnc_vehSpawnCatalogCleanup

Description:
    Return a copy of a catalog with any unknown vehicles discarded.

Parameters:
    HashMap catalog:
        The catalog to cleanup.

Returns:
    HashMap

Author:
    thegamecracks

*/
params ["_catalog"];

_catalog = +_catalog;
{
    private _category = _catalog get _x;
    private _vehicles = _category get "_vehicles";
    {
        if (!isClass (configFile >> "CfgVehicles" >> _x)) then {
            _vehicles deleteAt _x;
        };
    } forEach keys _vehicles;
} forEach keys _catalog;
_catalog
