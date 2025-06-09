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
    "focusOn isNotEqualTo player && {[focusOn] call WHF_fnc_canAssembleFPVDrone}"
] call WHF_fnc_contextMenuAdd;
