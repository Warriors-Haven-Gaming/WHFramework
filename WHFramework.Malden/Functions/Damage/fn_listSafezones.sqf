/*
Function: WHF_fnc_listSafezones

Description:
    Return all safezones defined in the current map.

Returns:
    Array in format [variable, areas],
        where variable is a string denoting the safezone type,
        and areas is a subarray containing [center, a, b] and/or marker names.

Author:
    thegamecracks

*/
private _respawnSafezones =
    allMapMarkers
    select {_x find "respawn" isEqualTo 0}
    apply {[
        markerPos [_x, true],
        WHF_safezone_respawn_radius,
        WHF_safezone_respawn_radius
    ]};

private _customSafezones =
    allMapMarkers
    select {_x find "WHF_safezone" isEqualTo 0};

[
    ["WHF_safezone_friendly", _respawnSafezones + _customSafezones]
]
