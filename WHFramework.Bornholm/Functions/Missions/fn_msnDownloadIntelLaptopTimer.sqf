/*
Function: WHF_fnc_msnDownloadIntelLaptopTimer

Description:
    Starts the laptop countdown.

Parameters:
    Object laptop:
        The intel laptop.

Author:
    thegamecracks

*/
params ["_laptop"];

// Just in case two clients start the same download...
if (_laptop getVariable ["WHF_downloadStarted", false]) exitWith {};
_laptop setVariable ["WHF_downloadStarted", true];

// If necessary, synchronize our progress with the server
private _interruptProgress = _laptop getVariable "WHF_downloadInterruptProgress";
if (!isNil "_interruptProgress") then {
    _laptop setVariable ["WHF_downloadProgress", _interruptProgress];
    _laptop setVariable ["WHF_downloadInterruptProgress", nil];
};

private _duration = _laptop getVariable ["WHF_downloadProgress", [0, 120]];
private _area = [getPosATL _laptop, 100, 100];
private _condition = [[_laptop], "WHF_fnc_msnDownloadIntelLaptopTimerCondition"];
private _hasElapsed = [_duration, nil, _area, _condition] call WHF_fnc_displayTimer;

if (!_hasElapsed) exitWith {
    if (isServer) then {
        private _duration = _laptop getVariable ["WHF_downloadProgress", [0, 120]];
        _laptop setVariable ["WHF_downloadInterruptProgress", _duration, true];

        // For clients that already think the timer elapsed, tell them otherwise
        _laptop setVariable ["WHF_downloadStarted", false, true];
        _laptop setVariable ["WHF_downloadEnded", false, true];
    };

    if (hasInterface && {focusOn inArea _area}) then {
        [blufor, "BLU"] sideChat localize "$STR_WHF_downloadIntelLaptop_interrupted";
    };

    _laptop setVariable ["WHF_downloadStarted", false];
};
_laptop setVariable ["WHF_downloadEnded", true];

if (hasInterface) then {
    if (focusOn inArea _area) then {
        [blufor, "BLU"] sideChat localize "$STR_WHF_downloadIntelLaptop_ended_inArea";
    } else {
        [blufor, "BLU"] sideChat localize "$STR_WHF_downloadIntelLaptop_ended";
    };
};
