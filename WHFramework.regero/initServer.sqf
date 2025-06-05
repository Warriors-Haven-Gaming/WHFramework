/*
Script: initServer.sqf

Description:
    Executed only on server when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#initServer.sqf

Author:
    thegamecracks

*/
skipTime random 24;
enableSaving [false, false];

if (isMultiplayer) then {
    deleteVehicle (playableUnits select {!isPlayer _x});
} else {
    deleteVehicle (switchableUnits select {!isPlayer _x});
    [player] execVM "onPlayerRespawn.sqf";
};

if (isMultiplayer) then {["Initialize"] call BIS_fnc_dynamicGroups};
call WHF_fnc_initChannels;
call WHF_fnc_initGCHandlers;
call WHF_fnc_vehSpawnCatalogServer;

WHF_mainMissionLoop_script = [
    [
        "WHF_fnc_msnMainAnnexRegion"
    ],
    {if (WHF_missions_main_enabled) then {WHF_missions_main_min} else {0}},
    {if (WHF_missions_main_enabled) then {WHF_missions_main_max} else {0}}
] spawn WHF_fnc_missionLoop;
WHF_sideMissionLoop_script = [
    [
        "WHF_fnc_msnDefendAidSupplies",
        "WHF_fnc_msnDestroyAAA",
        "WHF_fnc_msnDestroyArmor",
        "WHF_fnc_msnDestroyArtillery",
        "WHF_fnc_msnDestroyBarracks",
        "WHF_fnc_msnDestroyRoadblock",
        "WHF_fnc_msnDownloadIntel",
        "WHF_fnc_msnSecureCaches"
    ],
    {if (WHF_missions_side_enabled) then {WHF_missions_side_min} else {0}},
    {if (WHF_missions_side_enabled) then {WHF_missions_side_max} else {0}}
] spawn WHF_fnc_missionLoop;

WHF_gcDeletionQueue = [];
WHF_gcUnhideQueue = [];
WHF_garbageCollector_script = 0 spawn WHF_fnc_garbageCollectorLoop;
