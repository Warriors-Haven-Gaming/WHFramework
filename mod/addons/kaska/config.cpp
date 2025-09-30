class CfgPatches {
    class whf_kaska {
        name = "Warriors Haven Framework (Kaska)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/kaska";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "kaska",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_kaska {
            directory = "z\whf\addons\kaska\WHFramework_kaska.kaska";
        };
    };

    class MPMissions {
        class WHFramework_kaska {
            directory = "z\whf\addons\kaska\WHFramework_kaska.kaska";
        };
    };
};
