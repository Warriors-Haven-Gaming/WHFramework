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

_unit removeAction (_unit getVariable ["WHF_revive_actionID_player", -1]);
_unit removeAction (_unit getVariable ["WHF_revive_actionID_remote", -1]);

private _playerID = _unit addAction [
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
    toString {
        isPlayer _this
        && {[_this, _originalTarget, false] call WHF_fnc_checkRevive isEqualTo ""}
    },
    3
];
private _remoteID = _unit addAction [
    format ["%1 %2", localize "$STR_A3_Revive", name _unit],
    {
        params ["_target", "_caller"];
        [_caller, _target] call WHF_fnc_reviveAction;
    },
    nil,
    12,
    true,
    true,
    "",
    toString {
        !isPlayer _this
        && {[_this, _originalTarget] call WHF_fnc_checkRevive isEqualTo ""}
    },
    50
];

_unit setVariable ["WHF_revive_actionID_player", _playerID];
_unit setVariable ["WHF_revive_actionID_remote", _remoteID];
