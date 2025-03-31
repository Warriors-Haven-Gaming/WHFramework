/*
Function: WHF_fnc_objectsGrabber

Description:
    Convert objects in an area to an array compatible with WHF_fnc_objectsMapper.

Parameters:
    PositionATL center:
        The center of the area. Objects are placed according to this.
    Number radius:
        The radius of the area.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_center", "_radius"];

private _allDynamic = allMissionObjects "All";
private _objects =
    nearestObjects [_center, ["All"], _radius]
    select {_x in _allDynamic}
    select {
        private _sim = getText (configFile >> "CfgVehicles" >> typeOf _x >> "simulation");
        _sim isNotEqualTo "soldier"
    };

private _centerASL = AGLToASL _center;
_objects apply {[typeOf _x, getPosASL _x vectorDiff _centerASL, getDir _x]}

// _outputArray = [_type, [_dX, _dY, _dZ], _azimuth, _fuel, _damage, _orientation, _varName, _init, true, _dZ > 0.5];
// ASL = _dZ > 0.5
