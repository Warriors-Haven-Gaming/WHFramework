/*
Function: WHF_fnc_findAPSLoop

Description:
    Periodically identify vehicles with APS to be simulated.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
private _vehicleAPSEnabled = {
    params ["_vehicle"];
    switch (WHF_aps_enabled) do {
        case 0: {false};
        case 1: {isPlayer effectiveCommander _vehicle};
        case 2: {
            private _commander = effectiveCommander _vehicle;
            isPlayer _commander || {!isNil {_commander getVariable "WHF_recruiter"}}
        };
        case 3: {true};
        default {false};
    }
};

while {true} do {
    sleep 5;
    if (WHF_aps_enabled isEqualTo 0) then {WHF_aps_vehicles = nil; continue};

    WHF_aps_vehicles =
        vehicles
        select {alive _x}
        select {simulationEnabled _x}
        select {_x getVariable ["WHF_aps_ammo", 0] > 0}
        select {alive effectiveCommander _x}
        select {_x call _vehicleAPSEnabled};
};
