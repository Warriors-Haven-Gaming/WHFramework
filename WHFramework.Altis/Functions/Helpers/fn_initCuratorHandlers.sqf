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
