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

    {
        private _uid = _x getVariable "WHF_drones_owner";
        if (isNil "_uid") then {continue};

        private _locked = !(_uid in ["", getPlayerUID _unit]);
        if (_locked) then {
            _unit disableUAVConnectability [_x, false];
        } else {
            _unit enableUAVConnectability [_x, false];
        };
    } forEach allUnitsUAV;
}];
player addEventHandler ["WeaponAssembled", {
    params ["_unit", "_drone"];
    if (!WHF_drones_owned) exitWith {};
    if (!unitIsUAV _drone) exitWith {};
    if (!isNil {_drone getVariable "WHF_drones_owner"}) exitWith {};
    [_drone, getPlayerUID _unit] remoteExec ["WHF_fnc_lockDroneByUID"];
}];
