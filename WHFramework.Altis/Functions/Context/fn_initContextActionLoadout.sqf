/*
Function: WHF_fnc_initContextActionLoadout

Description:
    Add a context menu action to edit a recruit's loadout.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    localize "$STR_WHF_context_action_loadout",
    {
        // TODO: add compatibility with ACE arsenal, also consider adding
        //       an equivalent ACE interaciton
        ["Open", [true, cursorObject, cursorObject]] call BIS_fnc_arsenal;
    },
    nil,
    true,
    "",
    "
    getCursorObjectParams params ['_unit', '', '_distance'];
    local _unit
    && {_distance < 3
    && {cursorObject getVariable ['WHF_recruiter', ''] isEqualTo getPlayerUID player
    && {lifeState cursorObject in ['HEALTHY', 'INJURED']
    && {[getPosATL cursorObject, 50] call WHF_fnc_isNearArsenal}}}}
    "
] call WHF_fnc_contextMenuAdd;
