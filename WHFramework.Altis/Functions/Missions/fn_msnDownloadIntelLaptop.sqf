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
        [_target] remoteExec ["WHF_fnc_msnDownloadIntelLaptopTimer"];
    },
    nil,
    11,
    true,
    true,
    "",
    "!(_target getVariable ['downloadStarted',false])"
];
