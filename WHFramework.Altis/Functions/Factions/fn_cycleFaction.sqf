/*
Function: WHF_fnc_cycleFaction

Description:
    Cycle the current faction to use for units.
    Function must be called on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

private _factions = [
    ["base", WHF_factions_base],
    ["csat", WHF_factions_csat],
    ["csat_pacific", WHF_factions_csat_pacific],
    ["rhsafrf", WHF_factions_rhsafrf],
    ["cup_afrf", WHF_factions_cup_afrf],
    ["cup_afrf_modern", WHF_factions_cup_afrf_modern],
    ["cup_npc", WHF_factions_cup_npc],
    ["nato", WHF_factions_nato],
    ["nato_pacific", WHF_factions_nato_pacific],
    ["cup_usa_woodland", WHF_factions_cup_usa_woodland]
] select {_x # 1} apply {_x # 0};
_factions = _factions arrayIntersect call WHF_fnc_supportedFactions;
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
