/*
Function: WHF_fnc_initTerrainSafezone

Description:
    Disable damage on terrain objects inside safezones.
    Function must be executed on server in scheduled environment.

Author:
    thegamecracks

*/
if (!isServer) exitWith {};
// if (!WHF_safezone_enabled) exitWith {};
if !(WHF_safezone_terrain_types isEqualType []) exitWith {}; // CBA setting hasn't initialized

// This function takes ~13ms on Altis port, so try not to call it repeatedly
private _time = uiTime;
private _timeout = 3;
private _last = missionNamespace getVariable ["WHF_initTerrainSafezone_last", _time - _timeout];
if (_time - _last < _timeout) exitWith {};
WHF_initTerrainSafezone_last = _time;

private _types = WHF_safezone_terrain_types;
{
    _x params ["", "_areas"];
    {
        _x params ["_center", "_a", "_b"];
        if (_center isEqualType "") then {
            private _size = markerSize _center;
            _center = markerPos _center;
            _a = _size # 0;
            _b = _size # 1;
        };

        private _radius = _a max _b;
        private _allTerrain =
            nearestTerrainObjects [_center, [], _radius, false]
            inAreaArray _x;
        private _protectedTerrain =
            nearestTerrainObjects [_center, _types, _radius, false]
            inAreaArray _x;

        {_x allowDamage true} forEach _allTerrain;
        {_x allowDamage false} forEach _protectedTerrain;

    } forEach _areas;
} forEach call WHF_fnc_listSafezones;
