/*
Function: WHF_fnc_getShipTypes

Description:
    Returns an array of unit classnames for one or more given types.
    If none of the types are valid, an empty array is returned.

Parameters:
    Array types:
        One or more group types to return.

Returns:
    Array

Author:
    thegamecracks

*/
if (isNil "_this") exitWith {[]};
if !(_this isEqualType []) then {throw format [
    "Expected [[type, faction], ...] array, got %1",
    _this
]};

private _factions = call WHF_fnc_allFactions;
{
    if !(_x isEqualType [] || {count _x < 2}) then {throw format [
        "Expected [type, faction] at index %1, got %2",
        _forEachIndex,
        _x
    ]};

    _x params ["_type", "_faction"];
    // If this throws an exception, you probably did something like this:
    //     ["standard", "base"] call WHF_fnc_getVehicleTypes;
    // When specifying both the vehicle type and faction, it must be its own
    // element in another array:
    //     [["standard", "base"]] call WHF_fnc_getVehicleTypes;
    // If you're not sure where this occurred, run Arma with the -debug flag
    // and you should receive a traceback indicating which scripts led to this
    // ambiguous input.
    if (_type in _factions) then {throw format [
        "Misuse of faction name '%1' as vehicle type at index %2",
        _type,
        _forEachIndex
    ]};
} forEach _this;

private _resolvedTypes = _this apply {
    switch (_x) do {
        case ["civilians", "base"]: {["C_Boat_Civil_01_F","C_Boat_Transport_02_F","C_Scooter_Transport_01_F"]};
        case ["light",     "base"]: {["I_C_Boat_Transport_01_F","I_C_Boat_Transport_02_F"]};
        case ["heavy",     "base"]: {[]};
        case ["light",     "csat"]: {["O_Boat_Transport_01_F"]};
        case ["heavy",     "csat"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "csat_pacific"]: {["O_T_Boat_Transport_01_F"]};
        case ["heavy",     "csat_pacific"]: {["O_T_Boat_Armed_01_hmg_F"]};
        case ["light",     "aaf"]: {["I_Boat_Transport_01_F"]};
        case ["heavy",     "aaf"]: {["I_Boat_Armed_01_minigun_F"]};
        case ["light",     "ldf"]: {["I_Boat_Transport_01_F"]};
        case ["heavy",     "ldf"]: {["I_Boat_Armed_01_minigun_F"]};
        case ["light",     "ws_sfia"]: {["O_Boat_Transport_01_F"]};
        case ["heavy",     "ws_sfia"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "ws_tura"]: {["O_Boat_Transport_01_F"]};
        case ["heavy",     "ws_tura"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "rhsafrf"]: {["O_Boat_Transport_01_F"]};
        case ["heavy",     "rhsafrf"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "cup_afrf"]: {["CUP_O_PBX_RU"]};
        case ["heavy",     "cup_afrf"]: {[]};
        case ["light",     "cup_afrf_modern"]: {["CUP_O_PBX_RU"]};
        case ["heavy",     "cup_afrf_modern"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "cup_npc"]: {["O_Boat_Transport_01_F"]};
        case ["heavy",     "cup_npc"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "cup_tk"]: {["O_Boat_Transport_01_F"]};
        case ["heavy",     "cup_tk"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "cup_tk_ins"]: {["O_Boat_Transport_01_F"]};
        case ["heavy",     "cup_tk_ins"]: {["O_Boat_Armed_01_hmg_F"]};
        case ["light",     "gendarmerie"]: {["C_Boat_Civil_01_police_F"]};
        case ["heavy",     "gendarmerie"]: {[]};
        case ["light",     "nato"]: {["B_Boat_Transport_01_F"]};
        case ["heavy",     "nato"]: {["B_Boat_Armed_01_minigun_F"]};
        case ["light",     "nato_pacific"]: {["B_T_Boat_Transport_01_F"]};
        case ["heavy",     "nato_pacific"]: {["B_T_Boat_Armed_01_minigun_F"]};
        case ["light",     "ef_mjtf_desert"]: {["EF_B_Boat_Transport_01_MJTF_Des"]};
        case ["heavy",     "ef_mjtf_desert"]: {["EF_B_CombatBoat_AT_MJTF_Des","EF_B_CombatBoat_HMG_MJTF_Des","EF_B_Boat_Armed_01_minigun_MJTF_Des"]};
        case ["light",     "ef_mjtf_woodland"]: {["EF_B_Boat_Transport_01_MJTF_Wdl"]};
        case ["heavy",     "ef_mjtf_woodland"]: {["EF_B_CombatBoat_AT_MJTF_Wdl","EF_B_CombatBoat_HMG_MJTF_Wdl","EF_B_Boat_Armed_01_minigun_MJTF_Wdl"]};
        case ["light",     "ws_ion"]: {["B_Boat_Transport_01_F"]};
        case ["heavy",     "ws_ion"]: {["B_Boat_Armed_01_minigun_F"]};
        case ["light",     "ws_una"]: {["B_Boat_Transport_01_F"]};
        case ["heavy",     "ws_una"]: {["B_Boat_Armed_01_minigun_F"]};
        case ["light",     "cup_usa_woodland"]: {["CUP_B_Zodiac_USMC"]};
        case ["heavy",     "cup_usa_woodland"]: {["CUP_B_RHIB_USMC","CUP_B_RHIB2Turret_USMC"]};
        case ["light",     "cup_usmc_woodland"]: {["CUP_B_Zodiac_USMC"]};
        case ["heavy",     "cup_usmc_woodland"]: {["CUP_B_RHIB_USMC","CUP_B_RHIB2Turret_USMC"]};
        default {
            // Unlike the other type functions, we don't want fallbacks
            // since some factions are intended to have limited ships.
            []
        };
    };
};
_resolvedTypes = flatten _resolvedTypes;
_resolvedTypes = _resolvedTypes arrayIntersect _resolvedTypes;
_resolvedTypes
