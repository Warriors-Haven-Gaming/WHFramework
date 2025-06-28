/*
Function: WHF_fnc_setUnitLoadout

Description:
    Wait until a unit's loadout can be set, and then set the unit's loadout.
    There is a hardcoded timeout of 5 seconds after which setUnitLoadout
    will always be called, which may mean the command might not succeed.
    Function must be executed in scheduled environment.

Parameters:
    Object unit:
        The unit whose loadout to switch.
    Array loadout:
        The loadout to apply. Can be a CBA extended loadout
        or a loadout returned by getUnitLoadout.

Returns:
    Boolean
        True if the unit's loadout could be set before timing out, false otherwise.

Author:
    thegamecracks

*/
params ["_unit", "_loadout"];

private _setLoadout = {
    if (!isNil "CBA_fnc_setLoadout") exitWith {
        [_unit, _loadout] call CBA_fnc_setLoadout;
        true
    };

    if (_loadout isNotEqualTo [] && {count _loadout < 10}) then {
        // Looks like a CBA extended loadout, extract the vanilla part from it
        _loadout = _loadout # 0;
    };
    _unit setUnitLoadout _loadout;
    true
};

if (!isSwitchingWeapon _unit) exitWith {call _setLoadout};

private _timeout = time + 5;
waitUntil {sleep 0.1; !isSwitchingWeapon _unit || {time > _timeout}};
if (!isSwitchingWeapon _unit) then {call _setLoadout} else {false}
