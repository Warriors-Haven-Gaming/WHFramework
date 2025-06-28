/*
Function: WHF_fnc_isRemoteExecutedByAdmin

Description:
    Checks if the current script is remote executed in single player,
    by the player host, or by an admin.
    On a client, this always returns false.

Returns:
    Boolean

Author:
    thegamecracks

*/
if (!isServer) exitWith {false};
if (!isMultiplayer) exitWith {true};
if (remoteExecutedOwner isEqualTo 0) exitWith {false};
if (!isDedicated && {remoteExecutedOwner isEqualTo 2}) exitWith {true};
admin remoteExecutedOwner isNotEqualTo 0
