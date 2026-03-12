class CfgPatches {
    class whf_cup_chernarus_a3 {
        name = "Warriors Haven Framework (Chernarus 2020)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/chernarus-2020";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "CUP_Chernarus_A3_Config",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_cup_chernarus_A3 {
            directory = "z\whf\addons\cup_chernarus_a3\WHFramework_cup_chernarus_A3.cup_chernarus_A3";
        };
    };

    class MPMissions {
        class WHFramework_cup_chernarus_A3 {
            directory = "z\whf\addons\cup_chernarus_a3\WHFramework_cup_chernarus_A3.cup_chernarus_A3";
        };
    };
};
