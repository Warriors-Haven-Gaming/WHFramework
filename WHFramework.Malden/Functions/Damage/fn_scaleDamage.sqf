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
_diff = _diff * _scale;
if (_scale < 1) then {
    // For high-damage sources like HMG rounds, exponentially reduce their
    // damage so a unit can survive at least 2-3 hits.
    // Damage reference:
    //     82mm Mortar =>  200%
    //     .408/.50cal =>  800%
    //        GM6 Lynx => 1200%
    //          GBU-12 => 5100%
    //
    // The single-hit damage needed to incapacitate a unit can be calculated with:
    //     0.95 / _scale^3
    //
    // For example, 0.95 / 0.25^3 = 60.8, meaning a unit would need to take
    // 6080% damage in one hit to be immediately incapacitated.
    //
    // Scale reference:
    //     0.95 / 1.00^3 = 1
    //     0.95 / 0.90^3 = 1.30
    //     0.95 / 0.80^3 = 1.86
    //     0.95 / 0.70^3 = 2.77
    //     0.95 / 0.60^3 = 4.40
    //     0.95 / 0.50^3 = 7.6
    //     0.95 / 0.40^3 = 14.84
    //     0.95 / 0.30^3 = 35.19
    //     0.95 / 0.20^3 = 118.75
    //     0.95 / 0.10^3 = 950
    //     0.95 / 0.05^3 = 7600
    for "_i" from 1 to 3 do {
        if (_diff <= 0.45) then {break};
        _diff = _diff * _scale;
    };
};
_diff
