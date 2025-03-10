/*
Function: WHF_fnc_addPrisonerActions

Description:
    Add actions to a prisoner.

Parameters:
    Object unit:
        The unit to add actions to.

Author:
    thegamecracks

*/
params ["_unit"];
if (!alive _unit && {isRemoteExecutedJIP}) exitWith {remoteExec ["", remoteExecutedJIPID]};
if (!isNil {_unit getVariable "WHF_prisoner_actionIDs"}) exitWith {};

private _escortID = _unit addAction [
    localize "$STR_WHF_prisoner_escort",
    {
        params ["_target", "_caller"];
        [_caller, _target] call WHF_fnc_escortUnit;
    },
    nil,
    12,
    true,
    true,
    "",
    "
    isNil {_this getVariable 'WHF_escort'}
    && {captive _originalTarget
    && {lifeState _originalTarget in ['HEALTHY', 'INJURED']
    && {isNull attachedTo _originalTarget}}}
    ",
    3
];
_unit setVariable ["WHF_prisoner_actionIDs", [_escortID]];
