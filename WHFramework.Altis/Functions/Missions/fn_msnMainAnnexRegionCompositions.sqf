/*
Function: WHF_fnc_msnMainAnnexRegionCompositions

Description:
    Generate compositions within the mission area.

Parameters:
    Position2D center:
        The center of the mission area.
    Number radius:
        The radius of the mission area.

Returns:
    Array
        An array containing three elements:
            1. An array of objects that were created.
            2. An array of terrain objects that were hidden.
            3. An array of groups that were created.

Author:
    thegamecracks

*/
params ["_center", "_radius"];

private _objects = [];
private _terrain = [];
private _groups = [];

private _fortCount = floor (_radius / 20);
private _fortTypes = ["camp", 0.5, "hq", 0.2, "outpost", 0.2, "tower", 0.1];
[opfor, _fortCount, _center, _radius, _fortTypes, _objects] call WHF_fnc_createEmplacements
    params ["_fortObjects", "_fortTerrain", "_fortGroups"];
_objects append flatten _fortObjects;
_terrain append flatten _fortTerrain;
_groups append flatten _fortGroups;

private _mortarCount = floor (_radius / 350);
private _mortarTypes = ["mortar", 1];
[opfor, _mortarCount, _center, _radius, _mortarTypes, _objects] call WHF_fnc_createEmplacements
    params ["_mortarObjects", "_mortarTerrain", "_mortarGroups"];

_objects append flatten _mortarObjects;
_terrain append flatten _mortarTerrain;
_groups append flatten _mortarGroups;

[_objects, _terrain, _groups]
