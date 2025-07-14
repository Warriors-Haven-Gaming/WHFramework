/*
Function: WHF_fnc_inAreaDeadzone

Description:
    Check if the given objects or positions are in a deadzone area marker.

Parameters:
    Array | Location | Object positions:
        The objects, locations, or positions to check.

Returns:
    Array
        An array of positions that are in a deadzone.

Author:
    thegamecracks

*/
params ["_positions"];
[_positions, "WHF_deadzone"] call WHF_fnc_inAreaMarkers
