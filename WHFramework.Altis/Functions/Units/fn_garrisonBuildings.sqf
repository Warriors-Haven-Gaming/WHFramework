/*
Function: WHF_fnc_garrisonBuildings

Description:
    Teleport units to random positions in the given buildings.
    This functions similarly to WHF_fnc_garrisonUnits, but an array
    of buildings is provided instead of an area.

Parameters:
    Array | Group units:
        An array or group of units to garrison.
        Units already garrisoned are ignored.
    Array buildings:
        The buildings to be garrisoned.
    Boolean delete:
        (Optional, default false)
        If true, any units that could not be garrisoned are deleted.

Returns:
    Array
        An array of units that could not be garrisoned.

Author:
    thegamecracks

*/
params ["_units", "_buildings", ["_delete", false]];

if (_units isEqualType grpNull) then {_units = units _units};
_units = _units select {_x checkAIFeature "PATH"};

_buildings = _buildings select {_x buildingPos 0 isNotEqualTo [0,0,0]};

private _positions = [];
{_positions append (_x buildingPos -1)} forEach _buildings;
_positions = _positions call BIS_fnc_arrayShuffle;

{
    if (_forEachIndex >= count _positions) then {
        if (_delete) then {deleteVehicle _x};
        continue;
    };

    _x setPos _positions # _forEachIndex;
    _x setUnitPos (["MIDDLE", "UP"] select (random 1 < 0.8));
    _x enableAIFeature ["COVER", false];
    _x enableAIFeature ["PATH", false];
} forEach _units;
