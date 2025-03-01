/*
Function: WHF_fnc_cycleFaction

Description:
    Cycle the current faction to use for units.
    Function must be called on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};

private _faction = switch (true) do {
    case (WHF_factions_selected isEqualTo "random"): {
        private _factions = call WHF_fnc_supportedFactions;
        if (!isNil "WHF_factions_current") then {_factions = _factions - [WHF_factions_current]};
        if (count _factions < 1) exitWith {"base"};
        selectRandom _factions
    };
    case ([WHF_factions_selected] call WHF_fnc_isFactionSupported): {
        WHF_factions_selected
    };
    default {
        private _fallback = "base";

        private _message = format [
            localize "$STR_WHF_cycleFaction_unsupported",
            WHF_factions_selected call WHF_fnc_localizeFaction,
            _fallback call WHF_fnc_localizeFaction
        ];
        diag_log text _message;
        systemChat _message;

        _fallback
    };
};

missionNamespace setVariable ["WHF_factions_current", _faction, true];
