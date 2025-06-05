/*
Function: WHF_fnc_msnSecureCachesActionCompleted

Description:
    Secure the given cache.
    Function should be globally remote executed.

Parameters:
    Object cache:
        The cache to secure.

Author:
    thegamecracks

*/
params ["_cache"];
if !(_cache isKindOf "Box_FIA_Ammo_F") exitWith {};
if (local _cache) then {deleteVehicle _cache};
// _cache setVariable ["WHF_cache_secured", true, true];
// TODO: add sideChat notification
