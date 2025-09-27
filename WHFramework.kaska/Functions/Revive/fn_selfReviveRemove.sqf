/*
Function: WHF_fnc_selfReviveRemove

Description:
    Remove the player's self-revive action.

Author:
    thegamecracks

*/
if (isNil "WHF_selfReviveID") exitWith {};
WHF_selfReviveID call BIS_fnc_holdActionRemove;
WHF_selfReviveID = nil;
