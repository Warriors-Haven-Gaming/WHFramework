/*
Script: init.sqf

Description:
    Executed globally when mission is started.
    https://community.bistudio.com/wiki/Event_Scripts#init.sqf

Author:
    thegamecracks

*/
diag_log text format ["Initializing %1", briefingName];

WHF_findAPSLoop_script = 0 spawn WHF_fnc_findAPSLoop;
WHF_simulateAPSLoop_script = 0 spawn WHF_fnc_simulateAPSLoop;
