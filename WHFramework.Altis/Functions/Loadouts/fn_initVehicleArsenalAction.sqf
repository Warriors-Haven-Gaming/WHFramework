/*
Function: WHF_fnc_initVehicleArsenalAction

Description:
    Add an action to edit a vehicle's inventory near an arsenal.

Author:
    thegamecracks

*/
if (!hasInterface) exitWith {};
if (!isNil "WHF_vehicleArsenal_actionID") then {
    WHF_vehicleArsenal_actionID call BIS_fnc_holdActionRemove;
};

private _actionID = [
    player,
    localize "$STR_WHF_initVehicleArsenalAction",
    "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
    "\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_loadVehicle_ca.paa",
    "
    call {
        getCursorObjectParams params ['_vehicle', '', '_distance'];
        _distance < 3
        && {alive _vehicle
        && {local _vehicle
        && {maxLoad _vehicle > 0
        && {vectorMagnitude velocity _vehicle < 1.39
        && {['LandVehicle', 'ReammoBox_F', 'Air', 'Ship'] findIf {_vehicle isKindOf _x} >= 0
        && {
            private _arsenalText = localize '$STR_A3_Arsenal';
            actionIDs _vehicle findIf {
                _vehicle actionParams _x select 0 isEqualTo _arsenalText
            } < 0
        && {[getPosATL _vehicle, 50] call WHF_fnc_isNearArsenal}}}}}}}
    }
    ",
    "true",
    {
        params ["", "_caller"];
        _caller call WHF_fnc_lowerWeapon;
    },
    {},
    {
        // TODO: add a vehicle inventory editor
        50 cutText ["Vehicle Arsenal not implemented", "PLAIN", 0.5];
    },
    {},
    [],
    1,
    12,
    false
] call BIS_fnc_holdActionAdd;

WHF_vehicleArsenal_actionID = [player, _actionID];
