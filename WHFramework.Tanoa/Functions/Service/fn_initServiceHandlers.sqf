/*
Function: WHF_fnc_initServiceHandlers

Description:
    Set up service mission event handlers.

Author:
    thegamecracks

*/
if (!isNil "WHF_initServiceHandlers") exitWith {};
WHF_initServiceHandlers = true;

if (isServer) then {
    private _depots =
        vehicles
        select {!simulationEnabled _x}
        select {_x isKindOf "Land_RepairDepot_01_base_F"};

    {_x setRepairCargo 0} forEach _depots;
};
