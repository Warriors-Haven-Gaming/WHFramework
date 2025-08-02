class CfgPatches {
    class whf_mehland {
        name = "Warriors Haven Framework (Mehland)";
        author = "thegamecracks";
        url = "https://github.com/Warriors-Haven-Gaming/WHFramework/tree/mehland";

        requiredVersion = 2.20;
        requiredAddons[] = {
            "EF_AH99",
            "EF_Data_Compat_RF",
            "EF_Hunter",
            "EF_VanillaVehicles",
            "mehland",
            "QAV_AbramsX",
            "RF_Air_Heli_Light_03",
            "RF_Air_heli_medium_ec",
            "RF_Vehicles_Pickup_01",
            "Valor_Plane_F",
            "whf_main",
        };
        skipWhenMissingDependencies = 1;

        units[] = {};
    };
};

class CfgMissions {
    class Missions {
        class WHFramework_mehland {
            directory = "z\whf\addons\mehland\WHFramework_mehland.mehland";
        };
    };

    class MPMissions {
        class WHFramework_mehland {
            directory = "z\whf\addons\mehland\WHFramework_mehland.mehland";
        };
    };
};
