/*
Function: WHF_fnc_initKillFeed

Description:
    Set up kill feed handlers.
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
    if (!isNil {_entity getVariable "WHF_killFeed_disabled"}) exitWith {};

    private _side = side group _entity;
    if (_side isEqualTo sideUnknown) exitWith {};

    private _civilian = _side isEqualTo civilian;
    private _friendly = _side isEqualTo side group _instigator;
    private _prisoner = !isNull (_entity call WHF_fnc_getDetainedBy);
    private _pvp = isPlayer _entity && {isPlayer _instigator};

    // Priority messages, will bypass cooldown
    private _priority = switch (true) do {
        case (_pvp && _friendly): {"$STR_WHF_killFeed_pvp_friendly"};
        case (_pvp): {"$STR_WHF_killFeed_pvp"};
        case (isPlayer _entity): {"$STR_WHF_killFeed_default"};
        default {""};
    };

    private _normal = switch (true) do {
        case (_priority isNotEqualTo ""): {""};
        case (_prisoner && {isPlayer _instigator}): {"$STR_WHF_killFeed_prisoner"};
        case (_civilian && {isPlayer _instigator}): {"$STR_WHF_killFeed_civilian"};
        default {""};
    };

    private _killFeedCooldown = {
        private _time = time;
        private _delay = 0.5;
        private _cooldown = missionNamespace getVariable ["WHF_killFeed_cooldown", 0];
        if (_time < _cooldown) exitWith {true};
        WHF_killFeed_cooldown = _time + _delay;
        false
    };
    if (_normal isNotEqualTo "" && _killFeedCooldown) then {_normal = ""};

    private _key = [_priority, _normal] select (_priority isEqualTo "");
    if (_key isNotEqualTo "") then {
        private _params = [name _entity, name _instigator];
        [_key, _params] remoteExec ["WHF_fnc_localizedSystemChat", WHF_globalPlayerTarget];
    };

    nil
}];
