class CfgPatches {
    class whf_alrayak {
        name = "Warriors Haven Framework (Al Rayak)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/alrayak";

        requiredVersion = 2.20;
        requiredAddons[] = {
            // "pja310",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_pja310 {
            directory = "z\whf\addons\pja310\WHFramework_pja310.pja310";
        };
    };

    class MPMissions {
        class WHFramework_pja310 {
            directory = "z\whf\addons\pja310\WHFramework_pja310.pja310";
        };
    };
};
