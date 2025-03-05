/*
Function: WHF_fnc_supportedFactions

Description:
    Return an array of all factions supported by the client.

Returns:
    Array

Author:
    thegamecracks

*/
private _factions = ["base", "csat", "csat_pacific", "rhsafrf", "cup_afrf", "cup_afrf_modern"];
_factions select {[_x] call WHF_fnc_isFactionSupported}
