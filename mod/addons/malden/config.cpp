class CfgPatches {
    class whf_malden {
        name = "Warriors Haven Framework (Malden)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/malden";

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
        class WHFramework_Malden {
            directory = "z\whf\addons\malden\WHFramework_Malden.Malden";
        };
    };

    class MPMissions {
        class WHFramework_Malden {
            directory = "z\whf\addons\malden\WHFramework_Malden.Malden";
        };
    };
};
