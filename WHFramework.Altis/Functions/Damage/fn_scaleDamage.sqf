/*
Function: WHF_fnc_scaleDamage

Description:
    Adjust a given damage difference with the given scaling.

Parameters:
    Number diff:
        The damage difference to be applied.
    Number scale:
        The damage scaling to apply in the range [0, 1].

Author:
    thegamecracks

*/
params ["_diff", "_scale"];
_diff * _scale
