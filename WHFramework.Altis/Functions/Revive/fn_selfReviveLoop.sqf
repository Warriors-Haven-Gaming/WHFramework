/*
Function: WH_fnc_selfReviveLoop

Description:
    Periodically checks if the user can self-revive.
    Function must be ran on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};

private _timeIncapacitated = -1;
private _reviveActionID = -1;

private _addReviveAction = {
    if (_reviveActionID >= 0) exitWith {};

    // Vanilla revive disables switching actions so we need to re-enable them
    // (see BIS_fnc_reviveOnState)
    {inGameUISetEventHandler [_x, ""]} forEach ["PrevAction", "NextAction"];

    _reviveActionID = [
        player,
        format ["<t color='#00FF00'>%1</t>", localize "$STR_WH_selfReviveLoop_action"],
        "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
        "\A3\Ui_f\data\IGUI\Cfg\HoldActions\holdAction_revive_ca.paa",
        "lifeState _target isEqualTo 'INCAPACITATED'",
        "[_target, _caller, _actionId, _arguments] call WH_fnc_selfReviveConditionProgress",
        {},
        {},
        WH_fnc_selfReviveCompleted,
        {},
        [],
        WH_selfRevive_duration,
        1001, // slightly higher priority than vanilla Force Respawn action
        false,
        true,
        true
    ] call BIS_fnc_holdActionAdd;
};

while {true} do {
    sleep (1 + random 1);
    if (lifeState player isEqualTo "INCAPACITATED") then {
        private _now = time;
        if (_timeIncapacitated < 0) then {_timeIncapacitated = _now};
        if (_reviveActionID < 0 && {_now - _timeIncapacitated > WH_selfRevive_minTime}) then {
            call _addReviveAction;
        };
        private _vehicle = objectParent player;
        if (!isNull _vehicle && {!alive _vehicle}) then {player moveOut _vehicle};
        if (damage player > 0.5) then {player setDamage 0};
    } else {
        _timeIncapacitated = -1;
        if (_reviveActionID >= 0) then {
            [player, _reviveActionID] call BIS_fnc_holdActionRemove;
            _reviveActionID = -1;
        };
        if (!isNil {player getVariable "WH_incapacitatedInvincibility"}) then {
            player allowDamage true;
            player setVariable ["WH_incapacitatedInvincibility", nil];
        };
    };
};
