/*
Function: WHF_fnc_initArsenalLoadoutHandlers

Description:
    Sets up a handler to save the player's loadout upon exiting the arsenal.

Author:
    thegamecracks

*/
[missionNamespace, "arsenalPreOpen", {
    params ["", "_center"];
    [_center] call WHF_fnc_onArsenalOpened;
}] call BIS_fnc_addScriptedEventHandler;

[missionNamespace, "arsenalClosed", WHF_fnc_onArsenalClosed] call BIS_fnc_addScriptedEventHandler;

if (isClass (configFile >> "CfgPatches" >> "ace_arsenal")) then {
    ["ace_arsenal_displayOpened", {
        [ace_arsenal_center] call WHF_fnc_onArsenalOpened;
    }] call CBA_fnc_addEventHandler;

    ["ace_arsenal_displayClosed", WHF_fnc_onArsenalClosed] call CBA_fnc_addEventHandler;
};
