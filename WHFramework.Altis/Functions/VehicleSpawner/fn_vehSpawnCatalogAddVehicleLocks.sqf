/*
Function: WHF_fnc_vehSpawnCatalogAddVehicleLocks

Description:
    Add vehicle locks according to the vehicle's category.

Parameters:
    String category:
        The category containing the vehicle type.
    Object vehicle:
        The vehicle to apply locks to.
    Object player:
        The player that owns the vehicle.

Returns:
    Boolean | Nothing

Author:
    thegamecracks

*/
params ["_category", "_vehicle", "_player"];
private _catalog = if (isServer) then {WHF_vehSpawnCatalog_server} else {WHF_vehSpawnCatalog_client};
if (isNil "_catalog") exitWith {};

_category = _catalog get _category;
if (isNil "_category") exitWith {};

private _locks = _category get "_locks";
if (isNil "_locks") exitWith {};

{
    _x params ["_seat", "_type", "_params"];

    private _lock = switch (_type) do {
        case "role": {["role", _params]};
        case "uid": {["uid", [getPlayerUID _player]]};
    };
    if (isNil "_lock") then {continue};

    private _name = format ["WHF_vehicleLock_%1", _seat];
    _vehicle setVariable [_name, _lock, true];
} forEach _locks;
