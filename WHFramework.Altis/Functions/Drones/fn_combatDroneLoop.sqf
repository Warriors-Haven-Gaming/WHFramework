/*
Function: WHF_fnc_combatDroneLoop

Description:
    Periodically check if any AI UAV operators should assemble combat drones.
    Must be executed in scheduled environment.

Author:
    thegamecracks

*/
private _detectDistance = 500;

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
            && {[_unit] call WHF_fnc_canAssembleFPVDrone
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
    [_unit] call WHF_fnc_assembleFPVDrone;
};
