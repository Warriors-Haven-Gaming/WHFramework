/*
Function: WHF_fnc_initDeathMessages

Description:
    Set up death message handlers.
    Function must be executed on server.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
if (difficultyOption "deathMessages" isNotEqualTo 0) exitWith {
    diag_log text format [
        "%1: deathMessages difficulty option enabled, skipping custom messages",
        _fnc_scriptName
    ];
};

addMissionEventHandler ["EntityKilled", {
    params ["_entity", "_source", "_instigator"];
    if (isNull _source) exitWith {};
    if (_entity isEqualTo _source) exitWith {}; // Likely force respawned

    private _side = side group _entity;
    if (_side isEqualTo sideUnknown) exitWith {};

    private _friendly = _side isEqualTo side group _instigator;
    private _pvp = isPlayer _entity && {isPlayer _instigator};

    private _key = switch (true) do {
        case (_pvp && _friendly): {"$STR_WHF_initDeathMessages_pvp_friendly"};
        case (_pvp): {"$STR_WHF_initDeathMessages_pvp"};
        case (isPlayer _entity): {"$STR_WHF_initDeathMessages_default"};
        default {""};
    };

    if (_key isNotEqualTo "") then {
        private _params = [name _entity, name _instigator];
        [_key, _params] remoteExec ["WHF_fnc_localizedSystemChat", WHF_globalPlayerTarget];
    };

    nil
}];
