/*
Function: WHF_fnc_initCuratorHandlers

Description:
    Set up curator handlers.

Author:
    thegamecracks

*/
private _objects = allMissionObjects "";
{_x addCuratorEditableObjects [_objects, true]} forEach allCurators;

addMissionEventHandler ["EntityCreated", {
    params ["_entity"];
    {_x addCuratorEditableObjects [[_entity], true]} forEach allCurators;
}];

addMissionEventHandler ["EntityRespawned", {
    params ["_new", "_old"];
    private _logic = getAssignedCuratorLogic _old;
    if (!isNull _logic) then {
        unassignCurator _logic;
        _new assignCurator _logic;
    };
}];
