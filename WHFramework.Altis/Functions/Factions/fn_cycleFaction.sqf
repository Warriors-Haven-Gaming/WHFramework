/*
Function: WHF_fnc_cycleFaction

Description:
    Cycle the current faction to use for units.
    Function must be called on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

private _factions = WHF_factions_pool arrayIntersect call WHF_fnc_supportedFactions;
if (count _factions > 1 && {!isNil "WHF_factions_current"}) then {
    _factions = _factions - [WHF_factions_current];
};

private _faction = "base";
if (count _factions > 0) then {
    _faction = selectRandom _factions;
} else {
    private _name = _faction call WHF_fnc_localizeFaction;
    private _message = format [localize "$STR_WHF_cycleFaction_unsupported", _name];
    diag_log text _message;
    systemChat _message;
};

missionNamespace setVariable ["WHF_factions_current", _faction, true];
