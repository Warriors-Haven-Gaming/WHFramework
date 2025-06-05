/*
Function: WHF_fnc_combatDroneLoop

Description:
    Periodically check if any AI UAV operators should assemble combat drones.
    Must be executed in scheduled environment.

Author:
    thegamecracks

*/
private _detectDistance = 500;

private _getBackpackDrone = {
    params ["_backpack"];
    private _type = getTextRaw (configFile >> "CfgVehicles" >> _backpack >> "assembleInfo" >> "assembleTo");
    if !(_type isKindOf "Helicopter") exitWith {""};
    _type
};

while {true} do {
    sleep (5 + random 5);

    private _operatorsOnAlert =
        allUnits
        select {
            private _unit = _x;
            local _unit
            && {simulationEnabled _unit
            && {!isPlayer _unit
            && {lifeState _unit in ["HEALTHY", "INJURED"]
            && {isNull objectParent _unit
            && {!captive _unit
            && {eyePos _unit select 2 >= 0
            && {[backpack _unit] call _getBackpackDrone isNotEqualTo ""
            && {
                _unit targets [true, _detectDistance, [], 30]
                findIf {[side group _unit, side group _x] call BIS_fnc_sideIsEnemy} >= 0
            && {
                private _pos = getPosASL _unit;
                !lineIntersects [_pos, _pos vectorAdd [0, 0, 50], _unit]
            }}}}}}}}}
        };
    if (count _operatorsOnAlert < 1) then {continue};

    private _unit = selectRandom _operatorsOnAlert;
    _unit playActionNow "PutDown";
    sleep 1.5;

    private _drone = [backpack _unit] call _getBackpackDrone;
    private _pos = _unit getRelPos [1, 0] vectorAdd [0, 0, getPosATL _unit # 2];
    _drone = createVehicle [_drone, _pos, [], 0, "CAN_COLLIDE"];
    private _group = side group _unit createVehicleCrew _drone;
    if (isNull _group) then {continue};

    removeBackpack _unit;
    private _targets = _unit targets [true, _detectDistance, [], 30];
    {_group reveal _x} forEach _targets;

    [_drone, _unit] spawn WHF_fnc_FPVDroneLoop;

    [_drone] remoteExec ["WHF_fnc_queueGCDeletion", 2];
};
