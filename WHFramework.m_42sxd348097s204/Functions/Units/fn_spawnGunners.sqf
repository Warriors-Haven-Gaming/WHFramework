/*
Function: WHF_fnc_spawnGunners

Description:
    Spawn gunners for the given turrets.

Parameters:
    Side side:
        The group's side.
    Array unitTypes:
        One or more group types to spawn units from.
        See WHF_fnc_getUnitTypes for allowed values.
    Array turrets:
        An array of turrets to spawn gunners for.
        All turrets must be local.

Returns:
    Group
        The group that was spawned in.

Author:
    thegamecracks

*/
params ["_side", "_unitTypes", "_turrets"];

_turrets = _turrets select {
    alive _x
    && {local _x
    && {count allTurrets _x > 0
    && {isNull gunner _x}}}
};
if (count _turrets < 1) exitWith {grpNull};

private _initTurrets = {
    // params ["_turrets", "_side"];
    {
        if (!isNil {_x getVariable "WHF_gunner_init"}) exitWith {};
        private _turret = _x;
        _turret setFuel 0;
        _turret allowCrewInImmobile [true, true];
        _turret setVehicleRadar 1;

        _turret setVariable ["WHF_turret_side", _side];
        _turret addEventHandler ["Fired", {
            params ["_turret"];
            private _side = _turret getVariable "WHF_turret_side";
            if (someAmmo _turret) exitWith {};
            if (isNil "_side") exitWith {};

            [_turret, _side] spawn {
                params ["_turret", "_side"];
                sleep (10 + random 20);
                if (side group gunner _turret isNotEqualTo _side) exitWith {};
                if (isPlayer gunner _turret) exitWith {};
                _turret setVehicleAmmo 1;
            };
        }];

        _x setVariable ["WHF_gunner_init", true];
    } forEach _turrets;
};

private _registerArtillery = {
    // params ["_turrets", "_group"];
    if (_turrets findIf {_x call WHF_fnc_isArtilleryVehicle} < 0) exitWith {};
    if (isNil "lambs_wp_fnc_taskartilleryregister") exitWith {};

    // TODO: add scripts for automatic targeting in vanilla
    [_group] call lambs_wp_fnc_taskartilleryregister;
};

private _pos = [-random 500, -random 500, 0];
private _group = [_side, _unitTypes, count _turrets, _pos, 0, 0, false] call WHF_fnc_spawnUnits;
{
    private _turret = _turrets # _forEachIndex;
    _group addVehicle _turret;
    _x moveInGunner _turret;
    if (isNull objectParent _x) then {deleteVehicle _x};
} forEach units _group;

call _initTurrets;
call _registerArtillery;
_group
