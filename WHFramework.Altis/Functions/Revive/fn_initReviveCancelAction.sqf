/*
Function: WHF_fnc_initReviveCancelAction

Description:
    Add an action to cancel a revive in progress.

Parameters:
    Object unit:
        The unit to add revive actions to.

Author:
    thegamecracks

*/
player removeAction (player getVariable ["WHF_revive_cancelID", -1]);
private _cancelID = player addAction [
    localize "$STR_DISP_CANCEL",
    {
        params ["", "_caller"];
        [_caller] call WHF_fnc_reviveActionCancel;
    },
    nil,
    6,
    true,
    true,
    "",
    "[_this] call WHF_fnc_unitIsReviving"
];
player setVariable ["WHF_revive_cancelID", _cancelID];
