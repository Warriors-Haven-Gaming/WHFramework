class CfgPatches {
    class whf_umb_armavir {
        name = "Warriors Haven Framework (Armavir)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/armavir";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "UMB_Armavir",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_UMB_Armavir {
            directory = "z\whf\addons\umb_armavir\WHFramework_UMB_Armavir.UMB_Armavir";
        };
    };

    class MPMissions {
        class WHFramework_UMB_Armavir {
            directory = "z\whf\addons\umb_armavir\WHFramework_UMB_Armavir.UMB_Armavir";
        };
    };
};
