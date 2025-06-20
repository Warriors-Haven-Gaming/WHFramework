/*
Script: init.sqf

Description:
    Executed globally when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#init.sqf

Author:
    thegamecracks

*/
diag_log text format ["Initializing %1", briefingName];

if (!isMultiplayer) then {
    // Will run before initPlayerLocal.sqf and initServer.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };

    // HACK: onPlayerRespawn.sqf can sometimes run before initServer.sqf
    WHF_globalPlayerTarget = 0;
};

WHF_findAPSLoop_script = 0 spawn WHF_fnc_findAPSLoop;
WHF_simulateAPSLoop_script = 0 spawn WHF_fnc_simulateAPSLoop;
