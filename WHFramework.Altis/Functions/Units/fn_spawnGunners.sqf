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

Examples:
    (begin example)
        private _unitTypes = [["standard", "csat"]];
        private _group = [opfor, _unitTypes, _turrets] call WHF_fnc_spawnGunners;
    (end)

Author:
    thegamecracks

*/
params ["_side", "_unitTypes", "_turrets"];

_turrets = _turrets select {
    alive _x
    && {local _x
    && {count allTurrets _x > 0}}
};

private _uavTurrets = _turrets select {unitIsUAV _x};
private _mannedTurrets = _turrets - _uavTurrets select {isNull gunner _x};

private _initTurrets = {
    // params ["_turrets", "_side"];
    {
        if !(_x isNil "WHF_gunner_init") exitWith {};
        private _turret = _x;
        _turret setFuel 0;
        _turret allowCrewInImmobile [true, true];
        _turret setVehicleRadar 1;

        _turret setVariable ["WHF_turret_side", _side];
        _turret addEventHandler ["Fired", {
            params ["_turret", "", "_muzzle"];
            private _side = _turret getVariable "WHF_turret_side";
            if (_turret ammo _muzzle > 0) exitWith {};
            if (isNil "_side") exitWith {};

            [_turret, _side] spawn {
                params ["_turret", "_side"];
                sleep (10 + random 20);
                private _gunner = gunner _turret;
                if (side group _gunner isNotEqualTo _side) exitWith {};
                if (isPlayer _gunner) exitWith {};
                _turret setVehicleAmmo 1;
                _turret setWeaponReloadingTime [_gunner, currentMuzzle _gunner, 0.15];
            };
        }];

        _x setVariable ["WHF_gunner_init", true];
    } forEach _turrets;
};

private _registerArtillery = {
    // params ["_mannedTurrets", "_mannedGroup"];
    if (_mannedTurrets findIf {_x call WHF_fnc_isArtilleryVehicle} < 0) exitWith {};
    if (isNil "lambs_wp_fnc_taskartilleryregister") exitWith {};

    // TODO: add scripts for automatic targeting in vanilla
    [_mannedGroup] call lambs_wp_fnc_taskartilleryregister;
};

private _pos = [-random 500, -random 500, 0];
private _mannedGroup = grpNull;
if (_mannedTurrets isNotEqualTo []) then {
    _mannedGroup = [_side, _unitTypes, count _mannedTurrets, _pos, 0, 0, false] call WHF_fnc_spawnUnits;
    {
        private _turret = _mannedTurrets # _forEachIndex;
        _mannedGroup addVehicle _turret;
        _x moveInGunner _turret;
        if (isNull objectParent _x) then {deleteVehicle _x};
    } forEach units _mannedGroup;
};

{_side createVehicleCrew _x} forEach _uavTurrets;

call _initTurrets;
call _registerArtillery; // TODO: can UAV artillery be registered?
_mannedGroup
