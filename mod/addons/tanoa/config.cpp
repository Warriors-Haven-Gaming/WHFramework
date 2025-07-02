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
    class Missions {
        class WHFramework_Tanoa {
            directory = "z\whf\addons\tanoa\WHFramework_Tanoa.Tanoa";
        };
    };
    class MPMissions {
        class WHFramework_Tanoa {
            directory = "z\whf\addons\tanoa\WHFramework_Tanoa.Tanoa";
        };
    };
};
