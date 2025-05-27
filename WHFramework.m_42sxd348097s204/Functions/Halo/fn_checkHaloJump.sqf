/*
Function: WHF_fnc_checkHaloJump

Description:
    Check if the given position is safe to halo jump to.

Parameters:
    Object unit:
        The unit that will be halo jumping.
    PositionATL pos:
        The position to halo jump to.

Returns:
    String
        If the position is unsafe, a string containing the reason is returned.
        Otherwise, an empty string is returned.

Author:
    thegamecracks

*/
params ["_unit", "_pos"];

if ([[_pos], "WHF_noHaloJump"] call WHF_fnc_inAreaMarkers isNotEqualTo []) exitWith {
    localize "$STR_WHF_checkHaloJump_restricted"
};

private _vehicles = _pos nearEntities ["LandVehicle", WHF_halo_antiair_distance];
if (_vehicles findIf {[_x, _unit] call WHF_fnc_isEnemyAntiAir} >= 0) exitWith {
    localize "$STR_WHF_checkHaloJump_antiair"
};

""
