/*
Function: WHF_fnc_fogCleanupLoop

Description:
    Periodically cleans up fog.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (!isNil "WHF_fog_cleanup" && {WHF_fog_cleanup isEqualType objNull}) exitWith {
    // Used in former Warriors Haven maps
    diag_log text format ["%1: found legacy 'WHF_fog_cleanup' entity, disabling fog cleanup", _fnc_scriptName];
};

while {true} do {
    sleep 300;

    if (!WHF_weather_fog_cleanup_enabled) then {continue};
    if (fog < 0.15) then {continue};

    private _newFog = fog / 4;
    diag_log text format ["%1: reducing fog to %2", _fnc_scriptName, _newFog];
    180 setFog _newFog;
};
