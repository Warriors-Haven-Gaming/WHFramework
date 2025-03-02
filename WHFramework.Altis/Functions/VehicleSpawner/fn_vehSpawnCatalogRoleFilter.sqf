/*
Function: WHF_fnc_vehSpawnCatalogRoleFilter

Description:
    Return a copy of the cached catalog with vehicles filtered by role.

Parameters:
    String role:
        The role to filter for.

Returns:
    HashMap

Author:
    thegamecracks

*/
params ["_role"];
private _catalog = if (isServer) then {+WHF_vehSpawnCatalog_server} else {+WHF_vehSpawnCatalog_client};
if (isNil "_catalog") exitWith {};

{
    private _category = _x;
    private _vehicles = _category get "_vehicles";
    {
        _vehicles get _x params ["", "_allowedRoles"];
        if (count _allowedRoles == 0) then {continue};
        if !(_role in _allowedRoles) then {_vehicles deleteAt _x};
    } forEach keys _vehicles;
} forEach values _catalog;

_catalog
