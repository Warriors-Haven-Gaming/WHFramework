/*
Function: WHF_fnc_setSpeaker

Description:
    Set a unit's speaker.
    This supports JIP execution, and will automatically remove itself
    from JIP queue if the unit is deleted.

Parameters:
    Object unit:
        The unit to set their speaker.
    String speaker:
        The speaker to use.

Author:
    thegamecracks

*/
params ["_unit", "_speaker"];
if (!alive _unit && {isRemoteExecutedJIP}) then {remoteExec ["", remoteExecutedJIPID]};
_unit setSpeaker _speaker;
