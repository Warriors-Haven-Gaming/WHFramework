/*
Script: init.sqf

Description:
    Executed globally when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#init.sqf

Author:
    thegamecracks

*/
diag_log text format ["Initializing %1", briefingName];

[] call WHF_fnc_waitSyncCBA;

WHF_damageSafezoneLoop_script = spawn WHF_fnc_damageSafezoneLoop;
WHF_findAPSLoop_script = spawn WHF_fnc_findAPSLoop;
WHF_simulateAPSLoop_script = spawn WHF_fnc_simulateAPSLoop;

WHF_gcDeletionQueue = [];
WHF_gcUnhideQueue = [];
WHF_garbageCollector_script = spawn WHF_fnc_garbageCollectorLoop;
