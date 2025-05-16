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
    Array | Config | String loadout:
        The loadout to apply. See setUnitLoadout for syntax.
        https://community.bistudio.com/wiki/setUnitLoadout

Returns:
    Boolean
        True if the unit's loadout could be set before timing out, false otherwise.

Author:
    thegamecracks

*/
params ["_unit", "_loadout"];

if (!isSwitchingWeapon _unit) exitWith {
    _unit setUnitLoadout _loadout;
    true
};

private _timeout = time + 5;
waitUntil {sleep 0.1; !isSwitchingWeapon _unit || {time > _timeout}};
_unit setUnitLoadout _loadout;
!isSwitchingWeapon _unit
