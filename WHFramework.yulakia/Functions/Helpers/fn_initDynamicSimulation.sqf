/*
Function: WHF_fnc_initDynamicSimulation

Description:
    Locally configure the dynamic simulation system.

Author:
    thegamecracks

*/
enableDynamicSimulationSystem true;
"Group"        setDynamicSimulationDistance 500;
"Vehicle"      setDynamicSimulationDistance 350;
"Prop"         setDynamicSimulationDistance 50;
"EmptyVehicle" setDynamicSimulationDistance 250;
"IsMoving"     setDynamicSimulationDistanceCoef 2;
