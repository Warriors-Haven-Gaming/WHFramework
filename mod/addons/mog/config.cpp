class CfgPatches {
    class whf_mog {
        name = "Warriors Haven Framework (Mogadishu)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/mogadishu";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "3den_Objects",
            "Air_F_lxWS",
            "Alexscreens",
            "Bro_Structures",
            "cba_xeh",
            "Characters_f_lxWS",
            "CUP_Buildings_Config",
            "CSAT_Eyewear",
            "EF_VanillaVehicles",
            "equipment",
            "GX_OBJECTS",
            "K9_Module",
            "Max_WAW",
            "Mog",
            "MULTIPLAY_Uniform",
            "QAV_AbramsX",
            "QAV_Ripsaw",
            "rev_sonnys_furniture",
            "RF_Props_Flags",
            "Static_Radios",
            "TCGM_Girls",
            "TCGM_MultiPlay_Girls",
            "TRYK_Shemaghs",
            "UMI_Inventory",
            "unit_config",
            "US_ESS_Glasses_tryk",
            "Valor_Plane_F",
            "whf_main",
            "women",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_Mog {
            directory = "z\whf\addons\mog\WHFramework_Mog.Mog";
        };
    };

    class MPMissions {
        class WHFramework_Mog {
            directory = "z\whf\addons\mog\WHFramework_Mog.Mog";
        };
    };
};
