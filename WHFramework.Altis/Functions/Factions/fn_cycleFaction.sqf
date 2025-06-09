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
    ["aaf", WHF_factions_aaf],
    ["ldf", WHF_factions_ldf],
    ["ws_sfia", WHF_factions_ws_sfia],
    ["ws_tura", WHF_factions_ws_tura],
    ["rhsafrf", WHF_factions_rhsafrf],
    ["cup_afrf", WHF_factions_cup_afrf],
    ["cup_afrf_modern", WHF_factions_cup_afrf_modern],
    ["cup_npc", WHF_factions_cup_npc],
    ["cup_tk", WHF_factions_cup_tk],
    ["cup_tk_ins", WHF_factions_cup_tk_ins],
    ["nato", WHF_factions_nato],
    ["nato_pacific", WHF_factions_nato_pacific],
    ["cup_usa_woodland", WHF_factions_cup_usa_woodland],
    ["cup_usmc_woodland", WHF_factions_cup_usmc_woodland]
] select {_x # 1} apply {_x # 0};

_factions = _factions arrayIntersect call WHF_fnc_supportedFactions;

if (count _factions < 1) then {
    private _faction = "base";
    private _name = _faction call WHF_fnc_localizeFaction;
    private _message = format [localize "$STR_WHF_cycleFaction_unsupported", _name];
    diag_log text _message;
    systemChat _message;
    _factions pushBack _faction;
};

private _skipCurrent = count _factions > 1 && {!isNil "WHF_factions_current"};
private _faction = if (!_skipCurrent) then {selectRandom _factions} else {
    selectRandom (_factions - [WHF_factions_current])
};

missionNamespace setVariable ["WHF_factions_current", _faction, true];
missionNamespace setVariable ["WHF_factions_pool", _factions, true];
