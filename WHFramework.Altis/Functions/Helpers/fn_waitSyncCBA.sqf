/*
Function: WHF_fnc_waitSyncCBA

Description:
    Wait for CBA settings to synchronize. In multiplayer, there is usually
    a short delay before CBA settings are initialized, during which settings
    that need init code like parseSimpleArray remain strings.
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
_timeout = uiTime + _timeout;
waitUntil {
    time > _timeout
    || {!isNil "WHF_loadout_blacklist" // any setting with parseSimpleArray works
    && {!(WHF_loadout_blacklist isEqualType "")}}
};
