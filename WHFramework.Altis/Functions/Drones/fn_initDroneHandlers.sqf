/*
Function: WHF_fnc_initDroneHandlers

Description:
    Set up drone handlers on the player.

Author:
    thegamecracks

*/
player addEventHandler ["SlotItemChanged", {
    params ["_unit", "_name", "_slot", "_assigned"];
    if (_slot isNotEqualTo 612) exitWith {};
    if (!_assigned) exitWith {};

    _name call BIS_fnc_itemType params ["", "_type"];
    if (_type isNotEqualTo "UAVTerminal") exitWith {};

    private _disabled = _unit getVariable ["WHF_drones_disabled", []];
    {if (!alive _x) then {_disabled deleteAt _forEachIndex}} forEachReversed _disabled;
    {_unit disableUAVConnectability [_x, true]} forEach _disabled;
}];
