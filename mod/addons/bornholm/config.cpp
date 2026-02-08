class CfgPatches {
    class whf_bornholm {
        name = "Warriors Haven Framework (Bornholm)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/bornholm";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "Bornholm",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_Bornholm {
            directory = "z\whf\addons\bornholm\WHFramework_Bornholm.Bornholm";
        };
    };

    class MPMissions {
        class WHFramework_Bornholm {
            directory = "z\whf\addons\bornholm\WHFramework_Bornholm.Bornholm";
        };
    };
};
