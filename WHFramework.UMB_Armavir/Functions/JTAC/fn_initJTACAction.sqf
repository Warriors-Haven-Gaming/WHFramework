/*
Function: WHF_fnc_initJTACAction

Description:
    Add JTAC actions to the player.
    Function must be executed on client.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isNil "WHF_jtac_holdIDs") then {
    {_x call BIS_fnc_holdActionRemove} forEach WHF_jtac_holdIDs;
};

private _reportID = [
    player,
    localize "$STR_WHF_initJTACAction_report",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\attack_ca.paa",
    "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\attack_ca.paa",
    toString {[_this, cursorObject] call WHF_fnc_canReportJTACTarget},
    toString {
        if (isNil "WHF_jtac_lastReport") exitWith {true};
        private _diff = WHF_jtac_lastReport + WHF_jtac_tasks_cooldown - time;
        if (_diff > 0) exitWith {
            private _message = localize "$STR_WHF_initJTACAction_cooldown";
            50 cutText [format [_message, _diff toFixed 1], 'PLAIN', 0.5];
            false
        };
        true
    },
    {},
    {},
    {
        params ["", "_caller"];
        private _target = cursorObject;
        if !([_caller, _target] call WHF_fnc_canReportJTACTarget) exitWith {};

        playSoundUI ["beep_target"];
        [_caller, _target] remoteExec ["WHF_fnc_reportJTACTarget", 2];
        WHF_jtac_lastReport = time;
    },
    {},
    [],
    0.5,
    12,
    false,
    false,
    true
] call BIS_fnc_holdActionAdd;

WHF_jtac_holdIDs = [[player, _reportID]];
