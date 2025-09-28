/*
Function: WHF_fnc_canAssembleFPVDrone

Description:
    Check if the given unit can assemble an FPV drone.

Parameters:
    Object unit:
        The unit assembling the FPV drone.

Returns:
    Boolean

Author:
    thegamecracks

*/
params ["_unit"];
if (!WHF_drones_combat_enabled) exitWith {false};
if (
    WHF_drones_combat_uavOnly
    && {isPlayer _unit
    && {_unit getVariable ['WHF_role', ''] isNotEqualTo 'uav'}}
) exitWith {false};
if (_unit getVariable ["WHF_safezone_friendly", false] isEqualTo true) exitWith {false};
if ([backpack _unit] call WHF_fnc_getBackpackDrone isEqualTo '') exitWith {false};
// TODO: require explosive charge to assemble FPV drone
true
