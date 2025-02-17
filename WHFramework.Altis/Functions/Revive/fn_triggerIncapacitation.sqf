/*
Function: WHF_fnc_triggerIncapacitation

Description:
    Handle a unit becoming incapacitated.
    Function must be ran in scheduled environment.

Author:
    thegamecracks

*/
params ["_unit"];
if (!isPlayer _unit) exitWith {};

systemChat format [localize "$STR_WHF_triggerIncapacitation_chat", name _unit];

// TODO: add revive actions
// TODO: handle JIP players

if (_unit isNotEqualTo player) exitWith {};
if (isRemoteExecuted) exitWith {};

_unit setCaptive true;
_unit setUnconscious true;

private _timeIncapacitated = time;
call WHF_fnc_selfReviveRemove;

while {true} do {
    sleep (1 + random 1);
    if (lifeState player isNotEqualTo "INCAPACITATED") exitWith {call WHF_fnc_selfReviveRemove};

    private _now = time;
    if (isNil "WHF_selfReviveID" && {time - _timeIncapacitated > WHF_selfRevive_minTime}) then {
        call WHF_fnc_selfReviveAdd;
    };

    private _vehicle = objectParent player;
    if (!isNull _vehicle && {!alive _vehicle}) then {player moveOut _vehicle};
};
