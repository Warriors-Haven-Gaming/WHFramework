/*
Script: init.sqf

Description:
    Executed globally when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#init.sqf

Author:
    thegamecracks

*/
diag_log text format ["Initializing %1", briefingName];

setMissionOptions createHashMapFromArray [
    ["IgnoreNoDamage", true],
    ["IgnoreFakeHeadHit", true],
    ["IgnoreUpsideDownDamage", true]
];

if (!isMultiplayer) then {
    // Will run before initPlayerLocal.sqf and initServer.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };

    call WHF_fnc_initEmplacementCatalog;
    call WHF_fnc_initDynamicSimulation;
    call WHF_fnc_initVehicleHandlers;
    WHF_usedPositions = [];

    // HACK: onPlayerRespawn.sqf can sometimes run before initServer.sqf
    WHF_globalPlayerTarget = 0;
};

if (isMultiplayer && {!isServer}) then {
    call WHF_fnc_initVehicleHandlers;
    WHF_usedPositions = [];
};

WHF_findAPSLoop_script = 0 spawn WHF_fnc_findAPSLoop;
WHF_simulateAPSLoop_script = 0 spawn WHF_fnc_simulateAPSLoop;
