if (!isClass (configFile >> "CfgPatches" >> "cba_xeh")) then {
    call compileScript ["XEH_preInit.sqf"];
};

if (isServer) then {
    WHF_globalPlayerTarget = [0, -2] select isDedicated;
    publicVariable "WHF_globalPlayerTarget";
};
