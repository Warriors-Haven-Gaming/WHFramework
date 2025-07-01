class CfgPatches {
    class whf_tanoa {
        name = "Warriors Haven Framework (Tanoa)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/tanoa";

        requiredVersion = 2.20;
        requiredAddons[] = {};
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class MPMissions {
        class WHFrameworkTanoa {
            briefingName = "Warriors Haven Framework";
            directory = "z\whf\addons\tanoa\WHFramework_Tanoa.Tanoa";
        };
    };
};
