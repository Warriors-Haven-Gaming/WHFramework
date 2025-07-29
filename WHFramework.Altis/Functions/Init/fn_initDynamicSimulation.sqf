/*
Function: WHF_fnc_initDynamicSimulation

Description:
    Locally configure the dynamic simulation system.

Author:
    thegamecracks

*/
enableDynamicSimulationSystem true;
"Group"        setDynamicSimulationDistance 750;
"Vehicle"      setDynamicSimulationDistance 750;
"Prop"         setDynamicSimulationDistance 50;
"EmptyVehicle" setDynamicSimulationDistance 250;
"IsMoving"     setDynamicSimulationDistanceCoef 2.5;

// FIXME: weird place to define this
setMissionOptions createHashMapFromArray [
    ["IgnoreNoDamage", true],
    ["IgnoreFakeHeadHit", true],
    ["IgnoreUpsideDownDamage", true],
    ["AIThinkOnlyLocal", true]
];
