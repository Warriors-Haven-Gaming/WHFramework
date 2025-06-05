/*
Function: WHF_fnc_reviveActionCancel

Description:
    Make a unit perform a revive on the given target.

Parameters:
    Object caller:
        The unit performing the revive.

Author:
    thegamecracks

*/
params ["_caller"];
_caller setVariable ["WHF_revive_target", nil];
