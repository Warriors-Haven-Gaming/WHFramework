/*
Function: WHF_fnc_signalFlareReveal

Description:
    Reveal each target to the given allies.

Parameters:
    Array targets:
        An array of targets to be revealed by the signal flare.
    Array allies:
        An array of units receiving the target information.
        Only units local to the client will be affected.

Author:
    thegamecracks

*/
params ["_targets", "_allies"];

{
    private _ally = _x;
    if (!local _ally) then {continue};
    {_ally reveal _x} forEach _targets;
} forEach _allies;
