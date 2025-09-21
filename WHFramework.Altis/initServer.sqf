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

WHF_mainMissionLoop_script = [] spawn WHF_fnc_missionLoopMain;
WHF_sideMissionLoop_script = [] spawn WHF_fnc_missionLoopSide;

WHF_gcDeletionQueue = [];
WHF_gcUnhideQueue = [];
WHF_garbageCollector_script = 0 spawn WHF_fnc_garbageCollectorLoop;
WHF_timeMultiplierLoop_script = 0 spawn WHF_fnc_timeMultiplierLoop;
