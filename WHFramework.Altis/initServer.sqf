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
};

WH_globalPlayerTarget = [0, -2] select isDedicated;
publicVariable "WH_globalPlayerTarget";

// WH_mainMissionLoop_script = [
//     [
//         "WH_fnc_msnMainClearZombies"
//     ],
//     WH_missions_main_min,
//     WH_missions_main_max
// ] spawn WH_fnc_missionLoop;
// WH_sideMissionLoop_script = [
//     [
//         "WH_fnc_msnAssistSoldiers",
//         "WH_fnc_msnClearDemons",
//         "WH_fnc_msnClearRaiders",
//         "WH_fnc_msnClearZombies",
//         "WH_fnc_msnDownloadIntel",
//         "WH_fnc_msnRescueCivilians"
//     ],
//     WH_missions_side_min,
//     WH_missions_side_max
// ] spawn WH_fnc_missionLoop;

// WH_gcDeletionQueue = [];
// WH_gcUnhideQueue = [];
// WH_garbageCollector_script = 0 spawn WH_fnc_garbageCollectorLoop;

// Why is this needed on dedicated server?
civilian setFriend [blufor, 1];
