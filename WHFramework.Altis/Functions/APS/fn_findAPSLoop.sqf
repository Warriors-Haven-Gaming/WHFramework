/*
Function: WHF_fnc_findAPSLoop

Description:
    Periodically identify vehicles with APS to be simulated.
    Function must be executed in scheduled environment.

Author:
    thegamecracks

*/
while {true} do {
    sleep 5;
    if (!WHF_aps_enabled) then {WHF_aps_vehicles = nil; continue};

    WHF_aps_vehicles = vehicles select {
        local _x
        && {alive _x
        && {_x getVariable ["WHF_aps_ammo", 0] > 0
        && {alive effectiveCommander _x
        && {WHF_aps_enabled_ai || {isPlayer effectiveCommander _x}}}}}
    };
};
