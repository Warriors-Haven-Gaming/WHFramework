/*
Function: WHF_fnc_vehSpawnCatalogClient

Description:
    Generate and cache the hashmap of allowed vehicles.
    Must be called on client.

Returns:
    HashMap

Author:
    thegamecracks

*/
if (isMultiplayer && {isServer}) exitWith {createHashMap};
if (isNil "WHF_vehSpawnCatalog_server") exitWith {createHashMap};
if (!isNil "WHF_vehSpawnCatalog_client") exitWith {+WHF_vehSpawnCatalog_client};

WHF_vehSpawnCatalog_client = [WHF_vehSpawnCatalog_server] call WHF_fnc_vehSpawnCatalogCleanup;
WHF_vehSpawnCatalog_client = compileFinal WHF_vehSpawnCatalog_client;
+WHF_vehSpawnCatalog_client
