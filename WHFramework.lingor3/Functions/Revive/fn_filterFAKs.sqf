/*
Function: WHF_fnc_filterFAKs

Description:
    Filter an array of for first aid kits allowed to be used in reviving.

Parameters:
    Array items:
        The array of items to filter.

Returns:
    Array


Author:
    thegamecracks

*/
params ["_items"];
if (!WHF_revive_FAKs_modded) exitWith {_items select {_x isEqualTo "FirstAidKit"}};
_items select {_x call BIS_fnc_itemType select 1 isEqualTo "FirstAidKit"}
