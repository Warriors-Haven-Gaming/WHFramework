/*
Function: WHF_fnc_requestSkipTime

Description:
    Requests time to be skipped.
    Function must be remote executed on server from a client.

Parameters:
    Object player:
        The player requesting a time skip.
    String timeOfDay:
        The time of day to skip to.
        Must be one of "morning", "noon", or "evening".

Author:
    thegamecracks

*/
params ["_player", "_timeOfDay"];
if !([_player] call WHF_fnc_isPlayerRemoteExecuted) exitWith {};
if (!WHF_requestSkipTime_enabled && {!call WHF_fnc_isRemoteExecutedByAdmin}) exitWith {};
if (!isNil "WHF_requestSkipTime_script" && {!scriptDone WHF_requestSkipTime_script}) exitWith {
    ["$STR_WHF_showSkipTimePending"] remoteExec ["WHF_fnc_localizedHint", remoteExecutedOwner];
};

private _last = missionNamespace getVariable ["WHF_requestSkipTime_last", time - WHF_requestSkipTime_cooldown];
private _diff = ceil (_last - time + WHF_requestSkipTime_cooldown);
if (_diff > 0) exitWith {
    [
        localize "$STR_WHF_showSkipTimeCooldown",
        [_diff, "HH:MM:SS"] call BIS_fnc_secondsToString
    ] remoteExec ["WHF_fnc_localizedHint", remoteExecutedOwner];
};

private _target = switch (_timeOfDay) do {
    case "morning": {6.25};
    case "noon": {12};
    case "evening": {17.5};
    default {-1};
};
if (_target < 0) exitWith {};

WHF_requestSkipTime_last = time;
diag_log text format ["Skip time to %1 requested by %2", _timeOfDay, name _player];

private _hours = (_target - dayTime) % 24;
if (_hours < 0) then {_hours = _hours + 24};
private _duration = ceil (_hours * 60 / 2);
[_player, _timeOfDay, _duration] remoteExec ["WHF_fnc_showSkipTime", WHF_globalPlayerTarget];

WHF_requestSkipTime_script = [side group _player, _timeOfDay, _target] spawn {
    params ["_side", "_timeOfDay", "_target"];
    private _lastTimeMultiplier = timeMultiplier;
    private _waitForNextDay = dayTime > _target;
    while {_waitForNextDay || {dayTime < _target}} do {
        if (dayTime < _target) then {_waitForNextDay = FALSE};
        if (timeMultiplier < 120) then {setTimeMultiplier 120};
        sleep 5;
    };

    setTimeMultiplier _lastTimeMultiplier;
    [_side, _timeOfDay] remoteExec ["WHF_fnc_showSkipTimeCompleted", WHF_globalPlayerTarget];
};
