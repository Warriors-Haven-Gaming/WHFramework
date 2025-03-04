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

private _emplacementCount = floor (_radius / 20);
[_emplacementCount, _center, _radius] call WHF_fnc_createEmplacements
    params ["_emplacementObjects", "_emplacementTerrain"];
_objects append flatten _emplacementObjects;
_terrain append flatten _emplacementTerrain;

private _mortarCount = floor (_radius / 350);
[opfor, _mortarCount, _center, _radius] call WHF_fnc_createMortars
    params ["_mortarObjects", "_mortarTerrain", "_mortarGroups"];

_objects append flatten _mortarObjects;
_terrain append flatten _mortarTerrain;
_groups append flatten _mortarGroups;

[_objects, _terrain, _groups]
