class CfgPatches {
    class whf_regero {
        name = "Warriors Haven Framework (Regero)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/regero";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "cba_xeh",
            "CUP_Buildings_Config",
            "CUP_WheeledVehicles_Dingo",
            "F35C_cfg",
            "FA_EMB312",
            "Peral_F16",
            "QAV_AbramsX",
            "QAV_Ripsaw",
            "regero",
            "Valor_Plane_F",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_Regero {
            briefingName = "Warriors Haven Framework (Regero)";
            directory = "z\whf\addons\regero\WHFramework_Regero.Regero";
        };
    };

    class MPMissions {
        class WHFramework_Regero {
            briefingName = "Warriors Haven Framework";
            directory = "z\whf\addons\regero\WHFramework_Regero.Regero";
        };
    };
};
