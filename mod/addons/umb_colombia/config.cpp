class CfgPatches {
    class whf_umb_colombia {
        name = "Warriors Haven Framework (Colombia)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/colombia";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "UMB_Colombia",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_UMB_Colombia {
            directory = "z\whf\addons\umb_colombia\WHFramework_UMB_Colombia.UMB_Colombia";
        };
    };

    class MPMissions {
        class WHFramework_UMB_Colombia {
            directory = "z\whf\addons\umb_colombia\WHFramework_UMB_Colombia.UMB_Colombia";
        };
    };
};
