# Faction
- Faction ID: `csat`
- Faction Name: `CSAT (Pacific)`
- Required Addons: `[]`

# Registering Your Faction
The following files need to be modified to register your new faction:
1. [fn_allFactions.sqf] (Faction ID)
2. [fn_isFactionSupported.sqf] (Faction ID and Required Addons)
3. [XEH_preInit.sqf] (Faction ID)
4. [stringtable.xml] (Faction Name)
5. [fn_getUnitTypes.sqf] (Faction ID and Classnames)
6. [fn_getVehicleTypes.sqf] (Faction ID and Classnames)
7. [fn_getShipTypes.sqf] (Faction ID and Classnames)
8. [fn_getAircraftTypes.sqf] (Faction ID and Classnames)

[fn_allFactions.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Factions/fn_allFactions.sqf
[fn_isFactionSupported.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Factions/fn_isFactionSupported.sqf
[XEH_preInit.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/XEH_preInit.sqf
[stringtable.xml]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/stringtable.xml
[fn_getUnitTypes.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Units/fn_getUnitTypes.sqf
[fn_getVehicleTypes.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Units/fn_getVehicleTypes.sqf
[fn_getShipTypes.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Units/fn_getShipTypes.sqf
[fn_getAircraftTypes.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Units/fn_getAircraftTypes.sqf

# Copying Classnames
To copy the classnames for each category, spawn in the types you want in Eden Editor,
select them, right click, and use the `Log > Log Classes as String to Clipboard` action.

# Copying Required Addons
To copy the required addons, pick one unit and vehicle type and paste them into
the following command:

```sqf
configSourceAddonList (configFile >> "CfgVehicles" >> "unit_or_vehicle_type") # 0
```

Paste again into the Debug Console and press "Local Exec" to execute it.
The result should be an addon name that your faction depends on.
Add it to the Faction ID entry you created in [fn_isFactionSupported.sqf].
If your faction includes assets from multiple mods, be sure to include
at least one addon name from each mod.





# Unit Types
This section covers infantry types used for patrols, garrisons, and vehicle crew.
These types are added to [fn_getUnitTypes.sqf].

## Standard
Majority of infantry types go here, including unguided AT, squad leaders,
UAV operators, marksmen, grenadiers, and light units. If faction has no UAV operators,
consider adding a vanilla UAV operator to grant that faction FPV drone capabilities,
if it makes sense in context of their setting. All garrisons use standard infantry types.

```sqf
"O_T_Soldier_A_F"
"O_T_Soldier_AAR_F"
"O_T_Soldier_AR_F"
"O_T_Medic_F"
"O_T_Engineer_F"
"O_T_Soldier_Exp_F"
"O_T_Soldier_GL_F"
"O_T_Soldier_M_F"
"O_T_Soldier_Repair_F"
"O_T_Soldier_F"
"O_T_Soldier_LAT_F"
"O_T_Soldier_SL_F"
"O_T_Soldier_TL_F"
"O_T_Soldier_UAV_F"
```

## AA
Units dedicated to guided anti-air, including assistant missile specialists.
Unguided AT can be copied from the standard category if no guided AA exists.
If no one fits this category, leave empty.

```sqf
"O_T_Soldier_AAA_F"
"O_T_Soldier_AA_F"
```

## AT
Units dedicated to guided anti-tank, including assistant missile specialists.
Unguided AT can be copied from the standard category if no guided AT exists.
If no one fits this category, leave empty.

```sqf
"O_T_Soldier_AHAT_F"
"O_T_Soldier_AAT_F"
"O_T_Soldier_AT_F"
"O_T_Soldier_HAT_F"
```

## Officer
Units dedicated to commanding, like "Officer" and "Commander". Units may be unarmed.
Appears only in specific objectives like Eliminate Commander in Annex Region.
Loadouts should be unique to help players visually identify them.

```sqf
"O_T_officer_F"
```

## Crew
Units dedicated to vehicle crew. Not currently used in objectives, but is
preferable to add any here in case of future missions. One unit type is sufficient.
If no one fits this category, a subset of units from the standard category can be reused.

```sqf
"O_T_Crew_F"
```

## Divers
Units specialized for underwater operations. Not currently used in objectives, but is
preferable to add any here in case of future missions. One unit type is sufficient.
If no one fits this category, a subset of units from the standard category can be reused.
Most factions don't have this, in which case a vanilla diver type can be used.

```sqf
"O_diver_F"
"O_diver_exp_F"
"O_diver_TL_F"
```

## Recons
Units with lighter loadouts and usually suppressed weaponry. Spawns with higher
skill than standard units. Loadouts should be unique so these groups can be visually distinguished.
If no one fits this category, a subset of units from the standard category can be reused.

```sqf
"O_T_Recon_Exp_F"
"O_T_Recon_JTAC_F"
"O_T_Recon_M_F"
"O_T_Recon_Medic_F"
"O_T_Recon_F"
"O_T_Recon_LAT_F"
"O_T_Recon_TL_F"
```

## Elites
Units dedicated to special operations, such as CSAT Viper teams. Spawns with even
higher skill than recon units. Because of this, loadouts should be unique to
help players visually identify them. If no spec ops-like units are available,
sleeve-less or uniquely-colored clothing can be used. Avoid unit reuse from
other categories.

```sqf
"O_V_Soldier_Exp_ghex_F"
"O_V_Soldier_jtac_ghex_F"
"O_V_Soldier_m_ghex_F"
"O_V_Soldier_ghex_F"
"O_V_Soldier_Medic_ghex_F"
"O_V_Soldier_lat_ghex_F"
"O_V_Soldier_TL_ghex_F"
```

## Snipers
Units with sniper rifles and usually camouflaged uniforms. Spawns with the
highest skill of all units. Because of this, loadouts should be unique to
help players visually identify them. If no units with sniper rifles are available,
consider removing marksman units from the standard category and placing them here.
Avoid unit reuse from other categories.

```sqf
"O_ghillie_lsh_F"
"O_ghillie_sard_F"
"O_T_Sniper_F"
"O_T_ghillie_tna_F"
```

## Helicopter Pilots
Units suited for flying that faction's rotary aircraft. One unit type is sufficient.
If no one fits this category, a subset of units from the standard category can be reused.

```sqf
"O_T_Helicrew_F"
"O_T_Helipilot_F"
```

## Jet Pilots
Units suited for flying that faction's fixed wing aircraft. One unit type is sufficient.
If the faction provides fighter jets, look for units with flight suits and oxygen masks.
If no one fits this category, helicopter pilots can be reused.

```sqf
"O_T_Pilot_F"
```





# Land Vehicle Types
This section covers vehicles driven on land, such as cars, trucks, and armor.
These types are added to [fn_getVehicleTypes.sqf].

## Standard
Common, usually light vehicles such as LSVs, pickup trucks, vans, jeeps,
and quad bikes. Vehicles may be weaponized.

```sqf
"O_T_LSV_02_AT_F"
"O_T_LSV_02_armed_F"
```

## Supply
Vehicles that provide repair, fuel, ammo, and medical services, or otherwise
appear to be holding cargo. If no vehicles fit this category, a subset of vehicles
from the standard category can be reused.

```sqf
"O_T_Truck_03_ammo_ghex_F"
"O_T_Truck_03_fuel_ghex_F"
"O_T_Truck_03_medical_ghex_F"
"O_T_Truck_03_repair_ghex_F"
```

## MRAPs
Vehicles with more armor than standard vehicles. Vehicles may be weaponized.
Should not be tracked. If no vehicles fit this category, a subset of vehicles
from the standard category can be reused.

```sqf
"O_T_MRAP_02_ghex_F"
"O_T_MRAP_02_gmg_ghex_F"
"O_T_MRAP_02_hmg_ghex_F"
```

## APCs
Larger, armored vehicles designed for carrying infantry. Vehicles may be weaponized,
but autocannons and other heavy weaponry should be classified as IFVs. May be tracked.
May be amphibious. If no vehicles fit this category, any truck, van, or car with
passenger seats may be used here.

```sqf
"O_T_APC_Wheeled_02_rcws_v2_ghex_F"
```

## IFVs
Vehicles designed for engaging infantry and potentially other vehicles.
Tank destroyers can be classified here. Vehicles may be tracked. May contain
additional passenger seats. If no vehicles fit this category, leave empty.

```sqf
"O_T_APC_Tracked_02_cannon_ghex_F"
```

## MBTs
Tracked, armored vehicles capable of destroying other armored vehicles.
Vehicles may contain additional passenger seats, usually exterior ones.
If no vehicles fit this category, leave empty.

```sqf
"O_T_MBT_02_cannon_ghex_F"
"O_T_MBT_04_cannon_F"
"O_T_MBT_04_command_F"
```

## AA
Mobile vehicles capable of engaging aerial targets, including autocannon
trucks and SAM launchers. If no vehicles fit this category, leave empty.

```sqf
"O_T_APC_Tracked_02_AA_ghex_F"
```





# Ships
This section covers vehicles that exclusively move over water. Amphibious
vehicles may work, but are usually used in land vehicle types only.
Submersibles are not supported.
These types are added to [fn_getShipTypes.sqf].

## Light
Smaller ships with few seats, such as inflatable boats and scooters.
If faction does not contain any ships, vanilla ships can be used if it
makes sense in context of their setting. Otherwise, leave empty.

```sqf
"O_T_Boat_Transport_01_F"
```

## Heavy
Larger ships with more seats and weaponry, such as speedboats.
If no ships fit this category, leave empty.

```sqf
"O_T_Boat_Armed_01_hmg_F"
```





# Aircraft Types
This section covers vehicles designed to fly, including helicopters and planes.
These types are added to [fn_getAircraftTypes.sqf].

## Attack Helicopters
Small to medium sized helicopters with fixed boresight weaponry.
If no aircraft fit this category, leave empty.

```sqf
"O_Heli_Light_02_dynamicLoadout_F"
```

## Gunships
Medium to large sized helicopters with a dedicated gunner seat and gimbal
weapon system. Usually includes boresight weaponry, but is not required.
If no aircraft fit this category, leave empty.

```sqf
"O_Heli_Attack_02_dynamicLoadout_F"
```

## Light Helicopters
Small helicopters with passenger seats. Aircraft may be weaponized.
If no aircraft fit this category, leave empty.

```sqf
"O_Heli_Light_02_unarmed_F"
```

## Medium Helicopters
Medium sized helicopters with passenger seats. Aircraft may be weaponized.
If no aircraft fit this category, leave empty.

```sqf
"O_Heli_Transport_04_covered_F"
```

## Combat Air Patrol
Fixed wing aircraft with loadouts suited for CAP.
Unarmed aircraft and autonomous drones may work, but is not advised.
If no aircraft fit this category, leave empty.

```sqf
"O_Plane_Fighter_02_F"
```

## Close Air Support
Fixed wing aircraft with loadouts suited for CAS. VTOLs can be classified here.
Unarmed aircraft and autonomous drones may work, but is not advised.
Aircraft with side weaponry such as the Armed Blackfish may work, but is not advised.
If no aircraft fit this category, leave empty.

```sqf
"O_Plane_CAS_02_dynamicLoadout_F"
```
