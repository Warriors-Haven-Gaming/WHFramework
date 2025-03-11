/*
Function: WHF_fnc_initArsenalLoadoutHandlers

Description:
    Sets up a handler to save the player's loadout upon exiting the arsenal.

Author:
    thegamecracks

*/
[missionNamespace, "arsenalClosed", {
    [getUnitLoadout player] call WHF_fnc_setLastLoadout;
    saveMissionProfileNamespace;
}] call BIS_fnc_addScriptedEventHandler;

if (isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
    ["ace_arsenal_displayClosed", {
        [getUnitLoadout player] call WHF_fnc_setLastLoadout;
        saveMissionProfileNamespace;
    }] call CBA_fnc_addEventHandler;
};
