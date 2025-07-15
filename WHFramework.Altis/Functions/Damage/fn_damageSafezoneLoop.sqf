/*
Function: WHF_fnc_damageSafezoneLoop

Description:
    Periodically assign safezone immunity to local entities.

Author:
    thegamecracks

*/
// TODO: support custom safezone markers
// TODO: maybe support dynamic safezones?
private _friendlySafezones =
    allMapMarkers
    select {_x find "respawn" isEqualTo 0}
    apply {[markerPos [_x, true], 500, 500, 0, false, 200]};

private _allSafezones = [
    [_friendlySafezones, "WHF_safezone_friendly"]
];

while {true} do {
    sleep (1 + random 1);

    // FIXME: preferably we'd cover all units in safezone like recruits,
    //        but iterating through allUnits/entities is fairly slow
    //        (~0.36ms for 1k entities)
    private _entities =
        [player] + vehicles
        select {local _x && {alive _x && {simulationEnabled _x}}};

    {
        _x params ["_areas", "_var"];

        private _protected = flatten (_areas apply {_entities inAreaArray _x});
        _protected = _protected arrayIntersect _protected;

        isNil {
            {_x setVariable [_var, false]} forEach _entities;
            {_x setVariable [_var, true]} forEach _protected;
        };
    } forEach _allSafezones;
};
