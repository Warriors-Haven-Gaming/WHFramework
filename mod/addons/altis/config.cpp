class CfgPatches {
    class whf_altis {
        name = "Warriors Haven Framework (Altis)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework";

        requiredVersion = 2.20;
        requiredAddons[] = {};
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_Altis {
            briefingName = "Warriors Haven Framework (Altis)";
            directory = "z\whf\addons\altis\WHFramework_Altis.Altis";
        };
    };

    class MPMissions {
        class WHFramework_Altis {
            briefingName = "Warriors Haven Framework";
            directory = "z\whf\addons\altis\WHFramework_Altis.Altis";
        };
    };
};
