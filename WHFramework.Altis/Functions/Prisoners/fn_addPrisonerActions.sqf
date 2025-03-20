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

private _condition = "
    captive _originalTarget
    && {lifeState _originalTarget in ['HEALTHY', 'INJURED']
    && {isNull attachedTo _originalTarget}}
";

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
    _condition + "
        && {isNil {_this getVariable 'WHF_escort'}}
    ",
    3
];
private _freeID = _unit addAction [
    localize "$STR_WHF_prisoner_free",
    {
        params ["_target", "_caller"];
        [_caller, _target] remoteExec ["WHF_fnc_freeUnit", _target];
    },
    nil,
    12,
    true,
    true,
    "",
    _condition,
    3
];
_unit setVariable ["WHF_prisoner_actionIDs", [_escortID, _freeID]];
