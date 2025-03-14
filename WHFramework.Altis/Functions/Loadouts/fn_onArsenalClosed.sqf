/*
Function: WHF_fnc_onArsenalClosed

Description:
    Handle the arsenal being closed.

Author:
    thegamecracks

*/
if (isNil "WHF_loadout_center") exitWith {};
if !(WHF_loadout_center isKindOf "Man") exitWith {};

private _role = WHF_loadout_center getVariable "WHF_role";
if (isNil "_role") exitWith {};

private _loadout = getUnitLoadout WHF_loadout_center;
[_loadout, _role] call WHF_fnc_setLastLoadout;
saveMissionProfileNamespace;

private _uid = WHF_loadout_center getVariable ["WHF_recruiter", ""];
if (_uid isEqualTo getPlayerUID player) then {
    WHF_loadout_center setVariable ["WHF_recruitLoadout", _loadout];
};
