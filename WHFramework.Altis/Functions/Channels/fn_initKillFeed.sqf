/*
Function: WHF_fnc_initKillFeed

Description:
    Set up kill feed handlers.
    Function must be executed on server.

Author:
    thegamecracks

*/
// Client-side vehicle kill feed
if (hasInterface) then {addMissionEventHandler ["EntityKilled", {
    params ["_entity", "_source", "_instigator"];
    if (!WHF_killFeed_vehicle_enabled) exitWith {};

    if (isNull _source) exitWith {};
    if (_entity isEqualTo _source) exitWith {};
    if (!isNil {_entity getVariable "WHF_killFeed_disabled"}) exitWith {};

    if !(_entity isKindOf "AllVehicles") exitWith {};
    if (_entity isKindOf "CAManBase") exitWith {};
    if (sizeOf typeOf _entity < 7.5) exitWith {}; // skip quadbikes, quadcopters, etc.

    if (isNull _instigator) then {_instigator = UAVControl vehicle _source # 0};
    if (isNull _instigator) then {_instigator = _source};
    if (!isPlayer _instigator) exitWith {};

    private _sideEntity = side group _entity;
    private _sideInstigator = side group _instigator;
    if (_sideEntity isEqualTo sideUnknown) exitWith {};
    if !([_sideInstigator, _sideEntity] call BIS_fnc_sideIsEnemy) exitWith {};

    // FIXME: is there a simpler way to produce a numeric seed from an object?
    private _seed = 0;
    {_seed = _seed + _x} forEach toArray netId _entity;
    private _selectSeeded = {
        params ["_arr", "_offset"];
        _arr select floor (_seed + _offset random (count _arr - 0.0001))
    };

    private _messages = switch (true) do {
        case (_entity isKindOf "Air" && {!isTouchingGround _entity}): {[
            "$STR_WHF_killFeed_vehicle_air_1",
            "$STR_WHF_killFeed_vehicle_air_2",
            "$STR_WHF_killFeed_vehicle_air_3",
            "$STR_WHF_killFeed_vehicle_air_4"
        ]};
        default {[
            "$STR_WHF_killFeed_vehicle_1",
            "$STR_WHF_killFeed_vehicle_2",
            "$STR_WHF_killFeed_vehicle_3",
            "$STR_WHF_killFeed_vehicle_4",
            "$STR_WHF_killFeed_vehicle_5"
        ]};
    };
    private _vehicle = vehicle _source;
    private _entityName = [configOf _entity] call BIS_fnc_displayName;
    private _sourceName = switch (true) do {
        case !(_vehicle isKindOf "CAManBase"): {
            format [
                localize "$STR_WHF_killFeed_vehicle_source",
                name _instigator,
                [configOf _vehicle] call BIS_fnc_displayName
            ]
        };
        default {name _instigator};
    };

    private _message = [_messages, 0] call _selectSeeded;
    _message = format [localize _message, _entityName, _sourceName];
    [_sideInstigator, "BLU"] sideChat _message;

    nil
}]};

if (!isServer) exitWith {};
if (difficultyOption "deathMessages" isNotEqualTo 0) exitWith {
    diag_log text format [
        "%1: deathMessages difficulty option enabled, skipping custom messages",
        _fnc_scriptName
    ];
};

// Server-side unit kill feed (probably could be client-side)
addMissionEventHandler ["EntityKilled", {
    params ["_entity", "_source", "_instigator"];
    if (isNull _source) exitWith {};
    if (_entity isEqualTo _source) exitWith {}; // Likely force respawned
    if (!isNil {_entity getVariable "WHF_killFeed_disabled"}) exitWith {};
    if !(_entity isKindOf "CAManBase") exitWith {};

    private _side = side group _entity;
    if (_side isEqualTo sideUnknown) exitWith {};

    if (isNull _instigator) then {_instigator = UAVControl vehicle _source # 0};
    if (isNull _instigator) then {_instigator = _source};

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
