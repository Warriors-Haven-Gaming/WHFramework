/*
Function: WHF_fnc_supportedFactions

Description:
    Return an array of all factions supported by the client.

Returns:
    Array

Author:
    thegamecracks

*/
private _factions = ["base", "csat", "rhsafrf"];
_factions select {[_x] call WHF_fnc_isFactionSupported}
