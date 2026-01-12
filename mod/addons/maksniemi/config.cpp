class CfgPatches {
    class whf_malden {
        name = "Warriors Haven Framework (Maksniemi)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/maksniemi";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "vt4",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_Maksniemi {
            directory = "z\whf\addons\maksniemi\WHFramework_Maksniemi.Maksniemi";
        };
    };

    class MPMissions {
        class WHFramework_Maksniemi {
            directory = "z\whf\addons\maksniemi\WHFramework_Maksniemi.Maksniemi";
        };
    };
};
