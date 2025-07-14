/*
Function: WHF_fnc_inAreaMission

Description:
    Check if the given objects or positions are in a mission area marker.

Parameters:
    Array | Object positions:
        The objects or positions to check.

Returns:
    Array
        An array of positions that are in a mission.

Author:
    thegamecracks

*/
params ["_positions"];
[_positions, "WHF_msn"] call WHF_fnc_inAreaMarkers
