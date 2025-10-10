/*
Function: WHF_fnc_vehSpawnCatalogServer

Description:
    Generate and cache the hashmap of allowed vehicles.
    Function must be executed on server.

Returns:
    HashMap

Author:
    thegamecracks

*/
if (!isServer) exitWith {createHashMap};
if (!isNil "WHF_vehSpawnCatalog_server") exitWith {+WHF_vehSpawnCatalog_server};

private _config = call WHF_fnc_vehSpawnCatalog;
_config params [["_configVersion", -1]];

WHF_vehSpawnCatalog_server = createHashMap;
switch (_configVersion) do {
    case -1: {
        diag_log text "Vehicle spawner catalog is not defined!";
    };
    case 1: {
        _config params ["", "_catalog"];
        WHF_vehSpawnCatalog_server = _catalog;
    };
    default {
        diag_log text format ["Unsupported vehicle spawner catalog version: %1", _configVersion];
    }
};

// Clean up dummy elements. They exist only to allow trailing commas for cleaner diffs.
WHF_vehSpawnCatalog_server deleteAt "";
{
    _y get "_vehicles" deleteAt "";
} forEach WHF_vehSpawnCatalog_server;

private _isVehicleAllowed = {
    params ["_vehicle", "_data"];
    if (!isClass (configFile >> "CfgVehicles" >> _vehicle)) exitWith {false};
    true
};

{
    private _category = _y;
    private _vehicles = _category get "_vehicles";
    {
        private _y = _vehicles get _x;
        if !([_x, _y] call _isVehicleAllowed) then {
            _vehicles deleteAt _x;
        };
    } forEach keys _vehicles;
} forEach WHF_vehSpawnCatalog_server;

WHF_vehSpawnCatalog_server = [WHF_vehSpawnCatalog_server] call WHF_fnc_vehSpawnCatalogCleanup;
WHF_vehSpawnCatalog_server = compileFinal WHF_vehSpawnCatalog_server;

publicVariable "WHF_vehSpawnCatalog_server";

+WHF_vehSpawnCatalog_server
