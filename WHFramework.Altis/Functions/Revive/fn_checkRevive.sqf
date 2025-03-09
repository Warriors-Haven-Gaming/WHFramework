/*
Function: WHF_fnc_checkRevive

Description:
    Check if a unit can perform a revive.

Parameters:
    Object caller:
        The unit performing the revive.
    Object target:
        The unit to be revived.
    Boolean full:
        (Boolean, default true)
        If false, only a partial check is performed which is faster
        and suitable for action conditions.

Returns:
    String
        If the caller is unable to revive the target, a string containing
        the reason is returned. Otherwise, an empty string is returned.


Author:
    thegamecracks

*/
params ["_caller", "_target", ["_full", true]];
if (!alive _caller) exitWith {localize "$STR_WHF_checkRevive_generic"};
if (!alive _target) exitWith {localize "$STR_WHF_checkRevive_generic"};
if !(lifeState _caller in ["HEALTHY", "INJURED"]) exitWith {localize "$STR_WHF_checkRevive_generic"};
if (lifeState _target isNotEqualTo "INCAPACITATED") exitWith {localize "$STR_WHF_checkRevive_generic"};
if (!isNull (_caller getVariable ["WHF_revive_target", objNull])) exitWith {localize "$STR_WHF_checkRevive_generic"};
if (!isNull (_target getVariable ["WHF_revive_caller", objNull])) exitWith {localize "$STR_WHF_checkRevive_generic"};
if (!isNull attachedTo _target) exitWith {localize "$STR_WHF_checkRevive_generic"};
if (!_full) exitWith {""};

if (WHF_revive_medic && {!(_caller getUnitTrait "medic")}) exitWith {
    localize "$STR_WHF_checkRevive_medic"
};

private _items = items _target + items _caller;
if (
    WHF_revive_medkit
    && {_items findIf {_x call BIS_fnc_itemType select 1 isEqualTo "Medikit"} < 0
}) exitWith {
    localize "$STR_WHF_checkRevive_medkit"
};

private _nFAKs = {_x call BIS_fnc_itemType select 1 isEqualTo "FirstAidKit"} count _items;
private _nMissing = WHF_revive_FAKs - _nFAKs;
if (_nMissing > 0) exitWith {format [localize "$STR_WHF_checkRevive_FAKs", _nMissing]};

""
