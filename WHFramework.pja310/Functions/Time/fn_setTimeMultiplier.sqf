/*
Function: WHF_fnc_setTimeMultiplier

Description:
    Set the time multiplier according to the given action.
    Function must be executed on server.

Parameters:
    String action:
        (Optional, default "refresh")
        The action to perform. Can be one of:
            "day": Set the current state to day.
            "night": Set the current state to night.
            "skip": Set the current state to skip.
            "refresh": Re-apply the last state set.
            "reset": Set the current state based on the current time.

Returns:
    String
        The current time multiplier state as "day", "night", or "skip".

Author:
    thegamecracks

*/
params [["_action", "refresh"]];
if (!isServer) exitWith {};

private _stateByTime = {
    private _isNight = dayTime < 6.25 || {dayTime > 18.5};
    ["day", "night"] select _isNight
};

if (isNil "WHF_timeMultiplier_state") then {WHF_timeMultiplier_state = call _stateByTime};

private _state = switch (_action) do {
    case "day": {"day"};
    case "night": {"night"};
    case "skip": {"skip"};
    case "reset": {call _stateByTime};
    case "refresh": {WHF_timeMultiplier_state};
    default {-1};
};
if (_state isEqualType -1) exitWith {WHF_timeMultiplier_state};

private _multiplier = switch (_state) do {
    case "day": {WHF_timeMultiplier};
    case "night": {WHF_timeMultiplier_night};
    case "skip": {120};
    default {-1};
};
if (_multiplier < 0) exitWith {WHF_timeMultiplier_state};

if (timeMultiplier isNotEqualTo _multiplier) then {setTimeMultiplier _multiplier};
WHF_timeMultiplier_state = _state;
_state
