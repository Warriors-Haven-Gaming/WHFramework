# Creating Ports

This guide loosely covers how to create a Warriors Haven Framework port
for any given map.

- [Creating Ports](#creating-ports)
  - [1. Creating the scenario](#1-creating-the-scenario)
  - [2. Loading a premade WHF gamemode](#2-loading-a-premade-whf-gamemode)
  - [3. Copying gamemode files](#3-copying-gamemode-files)
  - [4. Copying player roles](#4-copying-player-roles)
  - [5. Setting up player respawns](#5-setting-up-player-respawns)
  - [6. Adding arsenals](#6-adding-arsenals)
  - [7. Adding respawning vehicles](#7-adding-respawning-vehicles)
  - [8. Adding vehicle locks](#8-adding-vehicle-locks)
  - [9. Adding service stations](#9-adding-service-stations)
  - [10. Adding recruit flag poles](#10-adding-recruit-flag-poles)
  - [11. Adding vehicle spawners](#11-adding-vehicle-spawners)
  - [12. (Optional) Setting default loadouts](#12-optional-setting-default-loadouts)
  - [13. (Optional) Adding time skip actions](#13-optional-adding-time-skip-actions)
  - [13. Other tips](#13-other-tips)

## 1. Creating the scenario

The first step you should do is open the map you plan on porting to.
Immediately after opening, save the scenario in MPMissions under a name
of your choosing, like `WHFrameworkMyName`. We prefer disabling binarization
for version control, but you can keep this enabled.

After creating your scenario, you need to find your scenario files.
This should be somewhere in your profile's mpmissions directory, for example,
`C:\Users\myname\Documents\Arma 3 - Other Profiles\myname\mpmissions` on Windows.

## 2. Loading a premade WHF gamemode

Now, you should download a copy of this project's source code and get it into
Eden Editor. Our main branch will contain `WHFramework.Altis`, the gamemode files
for our Altis map.

Copy `WHFramework.Altis` into your mpmissions directory. Afterwards, you should
be able to see WHFramework for Altis in the Eden Editor.

## 3. Copying gamemode files

To start porting the gamemode, you need to transfer the gamemode files into your
first scenario directory. To do this, copy and paste every file inside `WHFramework.Altis`
into your scenario directory **EXCEPT** for mission.sqm, which you should leave behind.

## 4. Copying player roles

With the gamemode files copied, you should next copy the player roles over.
Open WHFramework for Altis in Eden Editor. On the left, you should see a layer
containing the player units. Select all groups in that layer and the units
in each group, then [Ctrl+C] to copy them.

Now, open your own scenario, find a discreet location, and [Ctrl+V] to paste
the player units.

You'll notice that the group names have changed. Preferably these should be fixed,
so double click on each group and edit their `Callsign`. If you're not sure what
their group name should be, double click one of their units and look for
`Role Description`, which should say something like "AT Specialist@Anti-Tank".
The part after the @ symbol, i.e. "Anti-Tank", should be the group name.
Repeat this for each group until all groups are named.

Additionally, if you have `CBA_A3` loaded, you can find a `Lobby Manager`
action in the Tools menu on top. Click on this, or press [Ctrl+L], and
you'll be able to order the slots that show up in the multiplayer lobby.
Riflemen and other infantry roles should typically be placed first.

Once you're done, save the scenario.

## 5. Setting up player respawns

Respawn markers are used to determine where to respawn players. You can copy
the Main Operating Base marker from Altis, or manually create a marker with
the variable name, `respawn_west`. You can [Shift+Click] and drag the marker
to orient it, if you want players to face a certain direction when spawning.

Role-specific respawns can also be created by suffixing the marker with the ID
of the role, for example, `respawn_west_arty`. Here are the role IDs we've defined:
- `arty`
- `at`
- `autorifleman`
- `engineer`
- `jtac`
- `medic`
- `pilot_cas`
- `pilot_transport`
- `rifleman`
- `sniper`
- `uav`

## 6. Adding arsenals

To convert an object into an arsenal, usually a Supply box,
you should add the following line to the object's Init field:

```sqf
[this] call WHF_fnc_initArsenal;
```

The given object must have Simple Object and Local Only disabled
for the action to appear. Do **NOT** use the default Arsenal checkbox,
as this will not function the same as our gamemode arsenals.

## 7. Adding respawning vehicles

To make a vehicle automatically respawn, you should add this to the vehicle's
Init field:

```sqf
[this] call WHF_fnc_addRespawnVehicle;
```

This works for regular vehicles and autonomous drones, which will spawn under
the BLUFOR side. As of now, the vehicle respawn system does not save pylon/weapon
loadouts and custom textures or selections like camo nets. Do **NOT** combine
this with the vanilla Vehicle Respawn module.

## 8. Adding vehicle locks

To add role-specific locks to a vehicle, you should add this to the vehicle's
Init field:

```sqf
this setVariable ["WHF_vehicleLock_driver", ["role", ["pilot_transport"]]];
```

Arguments:
- `"WHF_vehicleLock_driver"` specifies the seat that this vehicle lock applies to.
  It can be one of `"WHF_vehicleLock_driver"`, `"WHF_vehicleLock_gunner"`, or `"WHF_vehicleLock_cargo"`.
- `["pilot_transport"]` is a list of role IDs that are allowed to access the given seat.

Multiple locks can be defined for each seat. If the vehicle can respawn, this line
**MUST** appear above `WHF_fnc_addRespawnVehicle` for the vehicle lock to persist.
Note that in singleplayer, vehicle locks have no effect. This must be tested in
a multiplayer game, which you can start in Eden Editor by selecting Play >
Play in Multiplayer (MP).

## 9. Adding service stations

A service station can be added by placing any of the following objects,
no Init field required:
- Repair depot (Civilian)
- Repair depot (Green)
- Repair depot (Tan)

The given object must have Simple Object and Local Only disabled
for the action to appear.

## 10. Adding recruit flag poles

To allow players to request recruits from an object, usually a flag pole,
you should add the following line to the object's Init field:

```sqf
[this, [0,5,0]] call WHF_fnc_initSpawnRecruitAction;
```

Arguments:
- `[0,5,0]` is the **relative** position to spawn the recruit,
  i.e. 5 metres in front of where the object is pointed.

The given object must have Simple Object and Local Only disabled
for the action to appear.

## 11. Adding vehicle spawners

To allow players to request vehicels from an object, usually a laptop,
you should add the following line to the object's Init field:

```sqf
[this, [0,0,0], 180, []] call WHF_fnc_vehSpawnInit;
```

Arguments:
- `[0,0,0]` is the **absolute** position to spawn the vehicle.
- `180` is the direction the vehicle should be facing.
- `[]` is an optional list of categories that are allowed to be spawned from
  the object, for example, `["Cars", "APCs"]`. See near the bottom of
  [fn_vehSpawnCatalog.sqf] for all available categories.

[fn_vehSpawnCatalog.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/VehicleSpawner/fn_vehSpawnCatalog.sqf

The given object must have Simple Object and Local Only disabled
for the action to appear.

## 12. (Optional) Setting default loadouts

Default loadouts can be defined in two ways:
1. Editing the loadouts of player units directly
2. Defining them in [fn_getLastLoadout.sqf]

[fn_getLastLoadout.sqf]: https://github.com/Warriors-Haven-Gaming/WHFramework/blob/main/WHFramework.Altis/Functions/Loadouts/fn_getLastLoadout.sqf

We recommend option 2 since it takes priority over editor-defined loadouts,
and works more consistently with our Load Last Loadout action. In the same
or a separate scenario, you can spawn in a unit, edit their loadout, then
play as that unit and open the debug console. Run the following code to copy
your loadout:

```sqf
copyToClipboard str getUnitLoadout player;
```

Then in the corresponding role of fn_getLastLoadout.sqf, replace `[]`
with the text that you copied. Repeat this for each role. You may skip
adding a loadout for the `default {[]}` clause.

## 13. (Optional) Adding time skip actions

To allow players to skip time on demand, you should add the following line
to an object's Init field:

```sqf
[this] call WHF_fnc_initSkipTimeAction;
```

The given object must have Simple Object and Local Only disabled
for the action to appear.

As of now, these actions do not provide a system for players to vote
on time skip requests. We do **NOT** recommend adding this action in
public servers.

## 13. Other tips

When building your scenario, here are a few more tips we recommend following
to make sure the base works as expected:

1. Enable simulation on all buildings that have doors or latches.

   This prevents those doors from lagging when being opened/closed in multiplayer.

2. Enable simulation on all flag poles and lights.

   Without simulation, these objects will not work correctly.

3. Disable Simple Object and Local Only on all objects with actions,
   like vehicle spawners and repair depots.

   If enabled, these objects will not work correctly. Simulation can be disabled.

3. Disable simulation/damage and enable Simple Object on all other non-interactable props.
