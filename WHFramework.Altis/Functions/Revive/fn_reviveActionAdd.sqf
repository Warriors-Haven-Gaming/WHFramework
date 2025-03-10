/*
Function: WHF_fnc_reviveActionAdd

Description:
    Add revive actions to a unit.

Parameters:
    Object unit:
        The unit to add revive actions to.

Author:
    thegamecracks

*/
params ["_unit"];

_unit removeAction (_unit getVariable ["WHF_revive_actionID", -1]);
private _actionID = _unit addAction [
    localize "$STR_A3_Revive",
    {
        params ["_target", "_caller"];
        [_caller, _target] call WHF_fnc_reviveAction;
    },
    nil,
    12,
    true,
    true,
    "",
    "[_this, _originalTarget, false] call WHF_fnc_checkRevive isEqualTo ''",
    3
];
_unit setVariable ["WHF_revive_actionID", _actionID];
