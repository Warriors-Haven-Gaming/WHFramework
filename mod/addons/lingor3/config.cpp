class CfgPatches {
    class whf_lingor3 {
        name = "Warriors Haven Framework (Lingor)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/lingor";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "A3_Map_lingor3",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_lingor3 {
            directory = "z\whf\addons\lingor3\WHFramework_lingor3.lingor3";
        };
    };

    class MPMissions {
        class WHFramework_lingor3 {
            directory = "z\whf\addons\lingor3\WHFramework_lingor3.lingor3";
        };
    };
};
