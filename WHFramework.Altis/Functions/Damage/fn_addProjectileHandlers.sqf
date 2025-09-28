/*
Function: WHF_fnc_addProjectileHandlers

Description:
    Set up player projectile handlers.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

WHF_hit_last = uiTime;
player addEventHandler ["FiredMan", {
    params ["", "", "", "", "", "", "_projectile"];

    private _hitHandler = {
        params ["", "_entity"];
        private _time = uiTime;
        if (_time - WHF_hit_last < 0.05) exitWith {};
        if (!alive _entity) exitWith {};
        if (side group _entity isEqualTo sideUnknown) exitWith {};

        if (WHF_hit_sounds) then {
            playSoundUI [getMissionPath "sounds\hit.ogg", 1, 0.9 + random 0.2, true];
        };

        WHF_hit_last = _time;
    };

    _projectile addEventHandler ["HitExplosion", _hitHandler];
    _projectile addEventHandler ["HitPart", _hitHandler];
}];

// FIXME: handle missile events on remote controlled units like UAVs
player addEventHandler ["GetInMan", {
    params ["", "", "_vehicle"];

    if (!isNil {_vehicle getVariable "WHF_addProjectileHandlers"}) exitWith {};

    private _missileID = _vehicle addEventHandler ["IncomingMissile", {
        params ["", "", "_source", "", "_missile"];
        WHF_projectiles_launches pushBack [time, _source, _missile];
    }];

    _vehicle setVariable ["WHF_addProjectileHandlers", [
        ["IncomingMissile", _missileID]
    ]];
}];

player addEventHandler ["GetOutMan", {
    params ["", "", "_vehicle"];

    private _handlers = _vehicle getVariable ["WHF_addProjectileHandlers", []];
    {_vehicle removeEventHandler _x} forEach _handlers;
    _vehicle setVariable ["WHF_addProjectileHandlers", nil];
}];
