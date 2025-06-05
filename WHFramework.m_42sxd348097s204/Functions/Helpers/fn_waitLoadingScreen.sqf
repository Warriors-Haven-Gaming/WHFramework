/*
Function: WHF_fnc_waitLoadingScreen

Description:
    Wait for standard loading screen to end, i.e. one that has been started
    with BIS_fnc_startLoadingScreen. This does not detect loading screens
    started with startLoadingScreen directly.
    Function must be executed in scheduled environment.

Parameters:
    Number timeout:
        (Optional, default 30)
        The timeout after which the function returns false.
        This timeout is checked even while the game is paused.

Returns:
    Boolean

Author:
    thegamecracks

*/
params [["_timeout", 30]];
private _isDone = {isNil "BIS_fnc_startLoadingScreen_ids" || {count BIS_fnc_startLoadingScreen_ids < 1}};
if (call _isDone) exitWith {true};

_timeout = uiTime + _timeout;
waitUntil {uiSleep 0.125; call _isDone || {uiTime > _timeout}};
call _isDone
