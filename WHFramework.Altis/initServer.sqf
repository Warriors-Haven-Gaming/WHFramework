/*
Script: initServer.sqf

Description:
    Executed only on server when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#initServer.sqf

Author:
    thegamecracks

*/
WHF_globalPlayerTarget = [0, -2] select isDedicated;
publicVariable "WHF_globalPlayerTarget";

skipTime random 24;
enableSaving [false, false];

if (isMultiplayer) then {
    // Will run before init.sqf and initPlayerLocal.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };

    call WHF_fnc_initEmplacementCatalog;
    call WHF_fnc_initDynamicSimulation;
};

if (isMultiplayer) then {
    {deleteVehicle _x} forEach (playableUnits select {!isPlayer _x});
} else {
    {deleteVehicle _x} forEach (switchableUnits select {!isPlayer _x});
    [player] execVM "onPlayerRespawn.sqf";
};

if (isMultiplayer) then {["Initialize"] call BIS_fnc_dynamicGroups};
call WHF_fnc_initChannels;
call WHF_fnc_initCuratorHandlers;
call WHF_fnc_initGCHandlers;
call WHF_fnc_vehSpawnCatalogServer;

WHF_mainMissionLoop_script = [
    [
        "WHF_fnc_msnMainAnnexRegion"
    ],
    1,
    1
] spawn WHF_fnc_missionLoop;
WHF_sideMissionLoop_script = [
    [
        "WHF_fnc_msnDownloadIntel",
        "WHF_fnc_msnDestroyAAA"
    ],
    1,
    3
] spawn WHF_fnc_missionLoop;

WHF_gcDeletionQueue = [];
WHF_gcUnhideQueue = [];
WHF_garbageCollector_script = 0 spawn WHF_fnc_garbageCollectorLoop;

{blufor      setFriend _x} forEach [[blufor, 1], [opfor, 0], [independent, 0], [civilian, 1]];
{opfor       setFriend _x} forEach [[blufor, 0], [opfor, 1], [independent, 1], [civilian, 1]];
{independent setFriend _x} forEach [[blufor, 0], [opfor, 1], [independent, 1], [civilian, 1]];
{civilian    setFriend _x} forEach [[blufor, 1], [opfor, 1], [independent, 1], [civilian, 1]];
