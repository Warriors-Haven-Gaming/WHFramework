/*
Function: WHF_fnc_setSideRelations

Description:
    Set side relations for the mission.
    Function must be executed in preInit environment to avoid being restricted
    by CfgDisabledCommands.

Author:
    thegamecracks

*/

{blufor      setFriend _x} forEach [[blufor, 1], [opfor, 0], [independent, 0], [civilian, 1]];
{opfor       setFriend _x} forEach [[blufor, 0], [opfor, 1], [independent, 1], [civilian, 1]];
{independent setFriend _x} forEach [[blufor, 0], [opfor, 1], [independent, 1], [civilian, 1]];
{civilian    setFriend _x} forEach [[blufor, 1], [opfor, 1], [independent, 1], [civilian, 1]];
