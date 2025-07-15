class CfgPatches {
    class whf_drakovac {
        name = "Warriors Haven Framework (Drakovac)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/drakovac";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "drakovac",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_drakovac {
            directory = "z\whf\addons\drakovac\WHFramework_drakovac.drakovac";
        };
    };
    class MPMissions {
        class WHFramework_drakovac {
            directory = "z\whf\addons\drakovac\WHFramework_drakovac.drakovac";
        };
    };
};
