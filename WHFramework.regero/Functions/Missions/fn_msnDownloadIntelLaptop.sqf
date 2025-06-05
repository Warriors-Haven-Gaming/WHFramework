/*
Function: WHF_fnc_msnDownloadIntelLaptop

Description:
    Initializes the intel laptop.

Parameters:
    Object laptop:
        The laptop to initialize.

Author:
    thegamecracks

*/
params ["_laptop"];
_laptop addAction [
    localize "$STR_WHF_downloadIntelLaptop_action",
    {
        params ["_target", "_caller"];
        _caller sideChat localize "$STR_WHF_downloadIntelLaptop_start";
        playSound3D [
            selectRandom [
                "a3\missions_f_oldman\data\sound\intel_laptop\1sec\intel_laptop_1sec_01.wss",
                "a3\missions_f_oldman\data\sound\intel_laptop\1sec\intel_laptop_1sec_02.wss",
                "a3\missions_f_oldman\data\sound\intel_laptop\1sec\intel_laptop_1sec_03.wss"
            ],
            objNull,
            true,
            getPosASL _target,
            1,
            1,
            0,
            0,
            true
        ];
        [_target] remoteExec ["WHF_fnc_msnDownloadIntelLaptopTimer"];
    },
    nil,
    12,
    true,
    true,
    "",
    "!(_target getVariable ['WHF_downloadStarted',false])"
];
