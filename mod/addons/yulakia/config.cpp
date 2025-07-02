class CfgPatches {
    class whf_yulakia {
        name = "Warriors Haven Framework (Yulakia)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/yulakia";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "cba_xeh",
            "CUP_Buildings_Config",
            "CUP_Creatures_Military_Taki",
            "CUP_WheeledVehicles_Hilux",
            "F35C_cfg",
            "FA_EMB312",
            "GX_Skyshield",
            "ibr_yulakia_objects",
            "Peral_F16",
            "QAV_AbramsX",
            "QAV_Ripsaw",
            "skilava_props_set_01",
            "TCGM_Girls",
            "Valor_Plane_F",
            "whf_main",
            "yulakia",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_Yulakia {
            directory = "z\whf\addons\yulakia\WHFramework_Yulakia.Yulakia";
        };
    };

    class MPMissions {
        class WHFramework_Yulakia {
            directory = "z\whf\addons\yulakia\WHFramework_Yulakia.Yulakia";
        };
    };
};
