/*
Function: WHF_fnc_vehSpawnCatalogCooldown

Description:
    Return the cooldown for the given vehicle type.
    If the category or vehicle type does not exist, returns nil.

Parameters:
    String category:
        The category containing the vehicle type.
    String vehicle:
        The vehicle type to lookup the cooldown for.

Returns:
    Number | Nothing

Author:
    thegamecracks

*/
params ["_category", "_vehicle"];
private _catalog = if (isServer) then {WHF_vehSpawnCatalog_server} else {WHF_vehSpawnCatalog_client};
if (isNil "_catalog") exitWith {};

_category = _catalog get _category;
if (isNil "_category") exitWith {};

_vehicle = _category get "_vehicles" get _vehicle;
if (isNil "_vehicle") exitWith {};

private _cooldown = _vehicle select 0;
if (_cooldown < 0) exitWith {_category get "_cooldown"};

_cooldown
