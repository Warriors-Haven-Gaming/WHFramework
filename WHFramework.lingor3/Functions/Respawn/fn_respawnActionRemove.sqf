/*
Function: WHF_fnc_respawnActionRemove

Description:
    Remove the player's respawn action.

Author:
    thegamecracks

*/
if (isNil "WHF_respawnActionID") exitWith {};
WHF_respawnActionID call BIS_fnc_holdActionRemove;
WHF_respawnActionID = nil;
