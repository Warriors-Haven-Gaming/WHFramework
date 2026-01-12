/*
Function: WHF_fnc_supportedFactions

Description:
    Return an array of all factions supported by the client.

Returns:
    Array

Author:
    thegamecracks

*/
call WHF_fnc_allFactions select {[_x] call WHF_fnc_isFactionSupported}
