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
// For rounds like .408 and .50cal, heavily reduce their damage.
if (_diff > 1 && {_diff < 12}) exitWith {_diff * _scale ^ 4};
_diff * _scale
