/*
Function: WHF_fnc_vehSpawnCatalogRoleAllowed

Description:
    Determine if a vehicle can be spawned by a given role.
    If the category or vehicle type does not exist, returns nil.

Parameters:
    String category:
        The category containing the vehicle type.
    String vehicle:
        The vehicle type to lookup the cooldown for.
    String role:
        The role to check.

Returns:
    Boolean | Nothing

Author:
    thegamecracks

*/
params ["_category", "_vehicle", "_role"];
private _catalog = if (isServer) then {WHF_vehSpawnCatalog_server} else {WHF_vehSpawnCatalog_client};
if (isNil "_catalog") exitWith {};

_category = _catalog get _category;
if (isNil "_category") exitWith {};

_vehicle = _category get "_vehicles" get _vehicle;
if (isNil "_vehicle") exitWith {};

private _allowedRoles = _vehicle select 1;
if (count _allowedRoles == 0) exitWith {true};

_role in _allowedRoles
