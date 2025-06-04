/*
Function: WHF_fnc_msnSecureCacheAction

Description:
    Add an action to the cache.

Parameters:
    Object cache:
        The cache to initialize.

Author:
    thegamecracks

*/
params ["_cache"];
[
    _cache,
    localize "$STR_WHF_secureCache_action",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
    "
    _this distance _target < 3
    && {_originalTarget getVariable ['WHF_cache_secured', false] isNotEqualTo true
    && {side group _this isEqualTo blufor}}
    ",
    "true",
    {
        params ["", "_caller"];
        _caller playActionNow "PutDown";
        playSoundUI [selectRandom [
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_01.wss",
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss",
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_03.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_01.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_02.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_03.wss"
        ]];
    },
    {},
    {
        params ["_cache", "_caller"];
        _cache setVariable ["WHF_cache_secured", true, true];
        // TODO: add sideChat notification
    },
    {},
    [],
    1,
    12
] call BIS_fnc_holdActionAdd;
