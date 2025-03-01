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
if (_laptop getVariable ["downloadStarted", false]) exitWith {};
_laptop setVariable ["downloadStarted", true];

// If necessary, synchronize our progress with the server
private _interruptProgress = _laptop getVariable "downloadInterruptProgress";
if (!isNil "_interruptProgress") then {
    _laptop setVariable ["downloadProgress", _interruptProgress];
    _laptop setVariable ["downloadInterruptProgress", nil];
};

private _duration = _laptop getVariable ["downloadProgress", [0, 30]];
private _area = [getPosATL _laptop, 100, 100, 0, false];
private _condition = [[_laptop], "WHF_fnc_msnDownloadIntelLaptopTimerCondition"];
private _hasElapsed = [_duration, nil, _area, _condition] call WHF_fnc_displayTimer;

if (!_hasElapsed) exitWith {
    if (isServer) then {
        private _duration = _laptop getVariable ["downloadProgress", [0, 30]];
        _laptop setVariable ["downloadInterruptProgress", _duration, true];

        // For clients that already think the timer elapsed, tell them otherwise
        _laptop setVariable ["downloadStarted", false, true];
        _laptop setVariable ["downloadEnded", false, true];
    };

    if (hasInterface && {focusOn inArea _area}) then {
        [blufor, "HQ"] sideChat localize "$STR_WHF_downloadIntelLaptop_interrupted";
    };

    _laptop setVariable ["downloadStarted", false];
};
_laptop setVariable ["downloadEnded", true];

if (hasInterface) then {
    if (focusOn inArea _area) then {
        [blufor, "HQ"] sideChat localize "$STR_WHF_downloadIntelLaptop_ended_inArea";
    } else {
        [blufor, "HQ"] sideChat localize "$STR_WHF_downloadIntelLaptop_ended";
    };
};
