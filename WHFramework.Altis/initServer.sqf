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
    // Will run before init.sqf and initPlayerLocal.sqf
    if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
        call compileScript ["XEH_preInit.sqf"];
    };
};

if (isMultiplayer) then {
    {deleteVehicle _x} forEach (playableUnits select {!isPlayer _x});
} else {
    {deleteVehicle _x} forEach (switchableUnits select {!isPlayer _x});
    if (markerColor "respawn_west" isNotEqualTo "") then {player setPosATL markerPos "respawn_west"};
};

call WHF_fnc_initChannels;

WHF_globalPlayerTarget = [0, -2] select isDedicated;
publicVariable "WHF_globalPlayerTarget";

// WHF_mainMissionLoop_script = [
//     [
//         "WHF_fnc_msnMainClearZombies"
//     ],
//     WHF_missions_main_min,
//     WHF_missions_main_max
// ] spawn WHF_fnc_missionLoop;
// WHF_sideMissionLoop_script = [
//     [
//         "WHF_fnc_msnAssistSoldiers",
//         "WHF_fnc_msnClearDemons",
//         "WHF_fnc_msnClearRaiders",
//         "WHF_fnc_msnClearZombies",
//         "WHF_fnc_msnDownloadIntel",
//         "WHF_fnc_msnRescueCivilians"
//     ],
//     WHF_missions_side_min,
//     WHF_missions_side_max
// ] spawn WHF_fnc_missionLoop;

// WHF_gcDeletionQueue = [];
// WHF_gcUnhideQueue = [];
// WHF_garbageCollector_script = 0 spawn WHF_fnc_garbageCollectorLoop;

// Why is this needed on dedicated server?
civilian setFriend [blufor, 1];
