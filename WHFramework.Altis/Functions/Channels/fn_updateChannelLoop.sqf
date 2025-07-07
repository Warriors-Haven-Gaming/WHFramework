/*
Function: WHF_fnc_updateChannelLoop

Description:
    Periodically updates the player's channel access.
    Function must be ran in scheduled environment.

Examples:
    (begin example)
        0 spawn WHF_fnc_updateChannelLoop;
    (end)

Author:
    thegamecracks

*/
private _isPilot = {
    private _role = player getVariable ["WHF_role", ""];
    if ("pilot" in _role) exitWith {true};

    private _vehicle = objectParent player;
    _vehicle isKindOf "Air"
    && {currentPilot _vehicle isEqualTo player
    && {!(_vehicle isKindOf "ParachuteBase")}}
};

while {true} do {
    sleep 5;
    if (isNull player) then {continue};

    if (call _isPilot) then {
        WHF_channelID_aircraft radioChannelAdd [player];
    } else {
        WHF_channelID_aircraft radioChannelRemove [player];
    };
};
