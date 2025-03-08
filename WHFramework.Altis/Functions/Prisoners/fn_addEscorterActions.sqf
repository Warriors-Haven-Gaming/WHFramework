/*
Function: WHF_fnc_addEscorterActions

Description:
    Add actions to an escorter.

Parameters:
    Object unit:
        The unit to add actions to.

Author:
    thegamecracks

*/
params ["_unit"];

{_unit removeAction _x} forEach (_unit getVariable ["WHF_escort_actionIDs", []]);

private _releaseID = _unit addAction [
    localize "$STR_WHF_prisoner_release",
    {
        params ["", "_unit"];
        detach (_unit getVariable "WHF_escort");
        _unit setVariable ["WHF_escort", nil];
    },
    nil,
    11,
    true,
    true,
    "",
    "
    !isNil {_this getVariable 'WHF_escort'}
    && {attachedTo (_this getVariable 'WHF_escort') isEqualTo _this
    && {lifeState (_this getVariable 'WHF_escort') in ['HEALTHY', 'INJURED']}}
    "
];

// TODO: add Load/Unload actions

_unit setVariable ["WHF_escort_actionIDs", [_releaseID]];
