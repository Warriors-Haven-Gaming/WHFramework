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
    "WHF_context_action_cruise_on",
    localize "$STR_WHF_context_action_cruise_on",
    WHF_fnc_cruiseAction,
    nil,
    true,
    {
        private _vehicle = objectParent focusOn;
        (_vehicle isKindOf 'LandVehicle' || {_vehicle isKindOf 'Ship'})
        && {currentPilot _vehicle isEqualTo focusOn
        && {getCruiseControl _vehicle # 0 <= 0
        && {vectorMagnitude velocity _vehicle > 1.39}}}
    }
] call WHF_fnc_contextMenuAdd;
[
    "WHF_context_action_cruise_up",
    localize "$STR_WHF_context_action_cruise_up",
    {true call WHF_fnc_cruiseActionAdjust},
    nil,
    false,
    {
        currentPilot objectParent focusOn isEqualTo focusOn
        && {getCruiseControl objectParent focusOn # 0 > 0}
    }
] call WHF_fnc_contextMenuAdd;
[
    "WHF_context_action_cruise_down",
    localize "$STR_WHF_context_action_cruise_down",
    {false call WHF_fnc_cruiseActionAdjust},
    nil,
    false,
    {
        currentPilot objectParent focusOn isEqualTo focusOn
        && {getCruiseControl objectParent focusOn # 0 > 5}
    }
] call WHF_fnc_contextMenuAdd;
[
    "WHF_context_action_cruise_off",
    localize "$STR_WHF_context_action_cruise_off",
    WHF_fnc_cruiseAction,
    nil,
    true,
    {
        currentPilot objectParent focusOn isEqualTo focusOn
        && {getCruiseControl objectParent focusOn # 0 > 0}
    }
] call WHF_fnc_contextMenuAdd;
