/*
Function: WHF_fnc_isPlayerRemoteExecuted

Description:
    Checks if the current script is remote executed by the given player.
    On a client, this always returns false.

Parameters:
    Object player:
        The player that should be the remote executed owner.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_player"];
if (!isServer) exitWith {false};
if (remoteExecutedOwner isEqualTo 0 && {isMultiplayer}) exitWith {false};
if (!isPlayer _player) exitWith {false};
if (owner _player isNotEqualTo remoteExecutedOwner) exitWith {false};
if (getPlayerUID _player isEqualTo "") exitWith {false};
true
