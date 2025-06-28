/*
Function: WHF_fnc_cycleFaction

Description:
    Cycle the current faction to use for units.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

private _isFactionEnabled = {
    params ["_faction", "_suffix"];
    private _key = format ["WHF_factions_%1_%2", _faction, _suffix];
    missionNamespace getVariable _key
};

private _factions = call WHF_fnc_supportedFactions;
private _categories = [
    ["blufor", "str_west", blufor],
    ["opfor", "str_east", opfor]
] apply {
    _x params ["_suffix"];
    private _factions = _factions select {[_x, _suffix] call _isFactionEnabled};
    _x + [_factions]
};

if (isNil "WHF_factions_current") then {WHF_factions_current = createHashMap};
WHF_factions_pool = createHashMap;

{
    _x params ["", "_name", "_side", "_factions"];

    if (count _factions < 1) then {
        private _faction = "base";
        private _message = format [
            localize "$STR_WHF_cycleFaction_unsupported",
            localize _name,
            _faction call WHF_fnc_localizeFaction
        ];
        diag_log text _message;
        systemChat _message;
        _factions pushBack _faction;
    };

    private _current = WHF_factions_current get _side;
    private _skipCurrent = count _factions > 1 && {!isNil "_current"};
    private _faction = if (!_skipCurrent) then {selectRandom _factions} else {
        selectRandom (_factions - [_current])
    };

    WHF_factions_current set [_side, _faction];
    WHF_factions_pool set [_side, _factions];
} forEach _categories;

publicVariable "WHF_factions_current";
publicVariable "WHF_factions_pool";
