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
