# Default Loadouts
- Loadout Collection ID: `main`
- Required Mods: `None`

Before creating loadouts in-game, ensure that all equipment mods being loaded
are known requirements to avoid including items from unintended mods.
Arsenal Search by POLPOX may be useful for sorting items by stats.

# Copying Loadouts
To start building loadouts, open Tutorials > Virtual Arsenal from the main menu.
Create your loadout there, then click Try to continue out of the arsenal.
Press Escape to see the Debug Console, and paste the following command:

```sqf
copyToClipboard str getUnitLoadout player;
```

Press "Local Exec" to execute it and you should have your loadout's contents
in your clipboard, ready to be pasted. The result should be a long piece of text
like this:

```sqf
[["arifle_MX_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",5]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",9,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["HandGrenade",2,1]]],["B_Carryall_cbr",[["FirstAidKit",30],["30Rnd_65x39_caseless_mag",8,30]]],"H_HelmetB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]
```

Loadouts can be pasted in [fn_getLastLoadout.sqf] to become default loadouts.

[fn_getLastLoadout.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Loadouts/fn_getLastLoadout.sqf

# Loadout Collection IDs
For every different set of loadouts, the default loadout collection ID in
[XEH_preInit.sqf] should be changed so that the player's last saved loadouts
are backed up and are able to receive the default loadouts.

```sqf
[
    "WHF_loadout_collection",
    "EDITBOX",
    ["STR_WHF_settings_loadouts_collection", "STR_WHF_settings_loadouts_collection_tooltip"],
    ["STR_WHF_settings", "STR_WHF_settings_loadouts"],
    "main", // <-- Change this text here
    false,
    {},
    false
] call WHF_fnc_addSetting;
```

[XEH_preInit.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/XEH_preInit.sqf

# Roles

## Rifleman
Recommendations:
- Scoped Rifle and Sidearm
- (Optional) Disposable AT launcher
- Two fragmentations, two smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- 24-36 FAKs
- Binoculars, Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## Autorifleman
Recommendations:
- Scoped LMG and Sidearm
- Two fragmentations, two smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- 24-30 FAKs
- Binoculars, Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## AT Specialist
Recommendations:
- Carbine and Sidearm
- Reusable AT launcher
- Two smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- At least 12 FAKs
- Binoculars, Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## AA Specialist
Recommendations:
- Carbine and Sidearm
- Reusable or disposable AA launcher
- Two smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- At least 12 FAKs
- Binoculars, Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## Medic
Recommendations:
- Rifle and Sidearm
- Four smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- 30+ FAKs
- Medikit
- Binoculars, Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## Engineer
Recommendations:
- Carbine and Sidearm
- Two fragmentations, two smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- At least 12 FAKs
- Toolkit, Mine Detector, any Explosive Charges
- Binoculars, Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## Sniper
Recommendations:
- Scoped Sniper Rifle and Suppressed Sidearm with additional magazines
- Ghillie Suit
- Four smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- 18-30 FAKs
- Rangefinder
- Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## JTAC
Recommendations:
- Scoped (Marksman) Rifle and Sidearm
- Four smoke grenades, two green chemlights
- Carryall Backpack or equivalent load
- 18-30 FAKs
- Laser Designator
- Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## Artillery Gunner
Recommendations:
- Carbine and Sidearm
- Four smoke grenades, two green chemlights
- Mortar Tube Backpack
- 6-12 FAKs
- UAV Terminal
- Binoculars, Map, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## UAV Operator
Recommendations:
- Rifle and Sidearm
- Four smoke grenades, two green chemlights
- AR-2 Darter Backpack or equivalent
- 6-12 FAKs
- UAV Terminal
- Binoculars, Map, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## Transport Pilot and Rotary Fighter Pilot
Recommendations:
- Submachinegun and Sidearm
- Four smoke grenades, two green chemlights
- Light vest, no backpack
- 12 FAKs
- Binoculars, Map, GPS, Radio, Compass, Watch, and NVGs

```sqf
PASTE HERE
```

## Fixed Wing Fighter Pilot
Recommendations:
- Sidearm
- One smoke grenade, two green chemlights
- Light vest (optional), no backpack
- 4 FAKs
- Pilot helmet with fullscreen NV capability
- Binoculars, Map, GPS, Radio, Compass, Watch

```sqf
PASTE HERE
```
