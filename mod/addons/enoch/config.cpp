class CfgPatches {
    class whf_enoch {
        name = "Warriors Haven Framework (Livonia)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/enoch";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_Enoch {
            directory = "z\whf\addons\enoch\WHFramework_Enoch.Enoch";
        };
    };
    class MPMissions {
        class WHFramework_Enoch {
            directory = "z\whf\addons\enoch\WHFramework_Enoch.Enoch";
        };
    };
};
