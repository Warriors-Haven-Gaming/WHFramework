/*
Function: WHF_fnc_combatDroneLoop

Description:
    Periodically check if any AI UAV operators should assemble combat drones.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
private _detectDistance = 500;

while {true} do {
    sleep (5 + random 5);

    private _operatorsOnAlert =
        allUnits
        select {local _x}
        select {simulationEnabled _x}
        select {!isPlayer _x}
        select {lifeState _x in ["HEALTHY", "INJURED"]}
        select {isNull objectParent _x}
        select {!captive _x}
        select {eyePos _x select 2 >= 0}
        select {_x targets [true, _detectDistance, [], 30] isNotEqualTo []}
        select {[_x] call WHF_fnc_canAssembleFPVDrone}
        select {!lineIntersects [getPosASL _x, getPosASL _x vectorAdd [0, 0, 50], _x]};
    if (count _operatorsOnAlert < 1) then {continue};

    private _unit = selectRandom _operatorsOnAlert;
    [_unit] call WHF_fnc_assembleFPVDrone;
};
