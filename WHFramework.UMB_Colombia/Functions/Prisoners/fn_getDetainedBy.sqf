/*
Function: WHF_fnc_getDetainedBy

Description:
    Return the last unit that detained the target, if any.

Parameters:
    Object target:
        The unit that was detained.

Returns:
    Object

Author:
    thegamecracks

*/
params ["_target"];
_target getVariable ["WHF_detain_caller", objNull]
