/*
Function: WHF_fnc_filterUnitLoadout

Description:
    Filter a unit loadout according to settings.

Parameters:
    Array | Object loadout:
        The loadout to filter. Can be the result of getUnitLoadout,
        or a unit to call getUnitLoadout on.

Returns:
    Array

Author:
    thegamecracks

*/
params ["_loadout"];
if (_loadout isEqualType []) then {_loadout = +_loadout};
if (_loadout isEqualType objNull) then {_loadout = _loadout call WHF_fnc_getUnitLoadout};
if (WHF_loadout_blacklist isEqualTo []) exitWith {_loadout};

private _blacklist = WHF_loadout_blacklist createHashMapFromArray [];
private _filterRecursive = {
    {
        if (_x isEqualType []) then {_x call _filterRecursive; continue};
        if !(_x isEqualType "") then {continue};
        if (toLowerANSI _x in _blacklist) then {_this set [_forEachIndex, ""]};
    } forEach _this;
};

_loadout call _filterRecursive;
_loadout
