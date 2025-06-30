/*
Function: WHF_fnc_addPlayerRatingHandlers

Description:
    Set up player rating handlers.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
player addEventHandler ["HandleRating", {call {
    params ["_unit", "_rating"];
    if (!WHF_rating_safe) exitWith {};
    _rating - (rating _unit + _rating min 0)
}}];
