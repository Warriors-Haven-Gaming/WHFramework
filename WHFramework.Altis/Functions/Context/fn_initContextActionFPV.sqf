/*
Function: WHF_fnc_initContextActionFPV

Description:
Add a context menu action to create an FPV drone.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
[
    localize "$STR_WHF_context_action_fpv",
    {
        [focusOn] call WHF_fnc_assembleFPVDrone;
    },
    nil,
    true,
    "",
    // TODO: require explosive charge to assemble FPV drone
    "[backpack focusOn] call WHF_fnc_getBackpackDrone isNotEqualTo ''"
] call WHF_fnc_contextMenuAdd;
