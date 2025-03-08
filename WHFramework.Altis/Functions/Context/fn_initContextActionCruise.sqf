/*
Function: WHF_fnc_initContextActionCruise

Description:
    Add context menu actions to set cruise control.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (isClass (configFile >> "CfgPatches" >> "ace_vehicles")) exitWith {};
[
    localize "$STR_WHF_context_action_cruise",
    WHF_fnc_cruiseAction,
    nil,
    true,
    "",
    "
    private _vehicle = objectParent focusOn;
    _vehicle isKindOf 'LandVehicle'
    && {currentPilot _vehicle isEqualTo focusOn
    && {vectorMagnitude velocity _vehicle > 0}}
    "
] call WHF_fnc_contextMenuAdd;
[
    localize "$STR_WHF_context_action_cruise_up",
    {true call WHF_fnc_cruiseActionAdjust},
    nil,
    false,
    "",
    "
    currentPilot objectParent focusOn isEqualTo focusOn
    && {getCruiseControl objectParent focusOn # 0 > 0}
    "
] call WHF_fnc_contextMenuAdd;
[
    localize "$STR_WHF_context_action_cruise_down",
    {false call WHF_fnc_cruiseActionAdjust},
    nil,
    false,
    "",
    "
    currentPilot objectParent focusOn isEqualTo focusOn
    && {getCruiseControl objectParent focusOn # 0 > 5}
    "
] call WHF_fnc_contextMenuAdd;
