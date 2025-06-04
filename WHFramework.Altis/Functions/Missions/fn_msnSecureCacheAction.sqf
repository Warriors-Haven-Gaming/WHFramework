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
// TODO: replace with hold action
_cache addAction [
    localize "$STR_WHF_secureCache_title",
    {
        params ["_cache", "_caller"];

        _caller playActionNow "PutDown";
        playSoundUI [selectRandom [
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_01.wss",
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_02.wss",
            "a3\missions_f_oldman\data\sound\intel_body\1sec\intel_body_1sec_03.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_01.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_02.wss",
            "a3\missions_f_oldman\data\sound\intel_body\2sec\intel_body_2sec_03.wss"
        ]];

        _cache setVariable ["WHF_cache_secured", true, true];
        // TODO: add sideChat notification
    },
    nil,
    12,
    true,
    true,
    "",
    "
        _originalTarget getVariable ['WHF_cache_secured', false] isNotEqualTo true
        && {side group _this isEqualTo blufor}
    ",
    3
];
