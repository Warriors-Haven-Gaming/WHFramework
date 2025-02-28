/*
Function: WHF_fnc_getVehicleTypes

Description:
    Returns an array of unit classnames for one or more given types.
    Note that classnames are not de-duplicated.
    If none of the types are valid, an empty array is returned.

Parameters:
    Array types:
        One or more group types to return. Each element should match one of the following keys:
            ["civilians", "base"]
            ["standard", "base"]

Returns:
    Array

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if !(_this isEqualType []) then {_this = [_this]};
if ({_x isEqualType ""} count _this > 0) then {_this = [_this]};
{_x pushBack WHF_factions_current} forEach (_this select {count _x isEqualTo 1});

private _resolvedTypes = _this apply {
    switch (_x) do {
        case ["civilians", "base"]: {["C_Van_01_fuel_F","C_Hatchback_01_F","C_Hatchback_01_sport_F","C_Offroad_02_unarmed_F","C_Offroad_01_F","C_Offroad_01_comms_F","C_Offroad_01_covered_F","C_Offroad_01_repair_F","C_Quadbike_01_F","C_SUV_01_F","C_Tractor_01_F","C_Van_01_transport_F","C_Van_01_box_F","C_Van_02_medevac_F","C_Van_02_vehicle_F","C_Van_02_service_F","C_Van_02_transport_F","C_Truck_02_fuel_F","C_Truck_02_box_F","C_Truck_02_transport_F","C_Truck_02_covered_F"]};
        case ["standard",  "base"]: {["I_G_Offroad_01_AT_F","I_G_Offroad_01_armed_F","I_C_Offroad_02_AT_F","I_C_Offroad_02_LMG_F"]};
        default {
            if (_x # 1 isEqualTo "base") then {[]}
            else {[_x # 0, "base"] call WHF_fnc_getVehicleTypes}
        };
    };
};
flatten _resolvedTypes
