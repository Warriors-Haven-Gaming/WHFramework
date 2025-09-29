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

    private _systemChat = {
        params ["_key", "_params"];
        [_key, _params] remoteExec ["WHF_fnc_localizedSystemChat", WHF_globalPlayerTarget];
    };

    switch (true) do {
        case (_entity isEqualTo _instigator): {};
        case (isPlayer _entity && {isPlayer _instigator}): {
            private _isFriendly = side group _entity isEqualTo side group _instigator;
            if (_isFriendly) then {
                private _key = "$STR_WHF_initDeathMessages_pvp_friendly";
                [_key, [name _entity, name _instigator]] call _systemChat;
            } else {
                private _key = "$STR_WHF_initDeathMessages_pvp";
                [_key, [name _entity, name _instigator]] call _systemChat;
            };
        };
        case (isPlayer _entity): {
            ["$STR_WHF_initDeathMessages_default", [name _entity]] call _systemChat;
        };
    };
    nil
}];
