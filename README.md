# Warriors Haven Framework

Warriors Haven Framework is our attempt at building our own I&A gamemode from
the ground up, porting over features we've developed in our modified version of
[Quiksilver's Invade & Annex], and rewriting everything else to (hopefully)
improve stability and make it easier to develop new objectives and functionality.

![](/docs/images/cover.jpg)

## Summary

Warriors Haven Framework provides a reoccurring main objective and side objectives
procedurally generated across the map, using terrain features and marked locations
to take full advantage of the map's topography. The main objective aims for
infantry-focused combat, providing lightly armored vehicles and turrets that
players can dispatch with their firearms alone. However, players can also opt for
combined arms tactics, with dozens of ground and aerial vehicles to choose from.

Worried about playing this gamemode alone? Recruits are always available to fight
with you, capable of reviving and sustaining themselves in prolonged firefights.
When you get incapacitated without a medic nearby, use up your medical supplies
to revive yourself and get back into combat. If you're not keen on driving across
the map to reach the next objective, request a halo jump from anywhere and dive
down in a line of parachutes.

![](/docs/images/halo.jpg)

## Factions

The following vanilla factions are always available for OPFOR:
- CSAT
- CSAT (Pacific)
- Syndikat

Additional factions are supported with the following mods:
- [CUP Vehicles] and Units
  - National Party of Chernarus
  - Armed Forces of the Russian Federation
  - AFRF (Modern)
- [RHSAFRF]
  - Also... Armed Forces of the Russian Federation

[CUP Vehicles]: https://steamcommunity.com/sharedfiles/filedetails/?id=541888371
[RHSAFRF]: https://steamcommunity.com/sharedfiles/filedetails/?id=843425103

## How do I play?

You can find this mission published on the Steam Workshop:

- [Warriors Haven Framework (Altis)](https://steamcommunity.com/sharedfiles/filedetails/?id=3455424755), ID 3455424755
- [Warriors Haven Framework (Yulakia)](https://steamcommunity.com/sharedfiles/filedetails/?id=3455426168), ID 3455426168

Once subscribed, you can host the mission by going to Server Browser > Host Server,
and then select Warriors Haven Framework from the appropriate map.
You may choose to host LAN if you want to play alone.

For dedicated server hosters, you can either download the mission files from our
[Releases] page, or copy and rename the mission file from your workshop directory:
1. Navigate to `<Steam>/steamapps/workshop/content/107410/<itemID>`,
   where itemID corresponds to the workshop map you downloaded above.
2. Copy the `<numbers>_legacy.bin` file into your server's `MPMissions` directory.
3. Rename it to `WHFramework.<terrain>.pbo`, where terrain is the name
   of the map (`Altis` or `yulakia`).
4. In your server.cfg, use `WHFramework.<terrain>` as the template name,
   for example:

   ```cpp
   class Missions {
       class WHF {
           template = "WHFramework.Altis";
       };
   };
   ```

> [!WARNING]
> As of now, some objectives and compositions depend on [CUP Terrains - Core]
> and [CUP Vehicles] to spawn. Without these mods, WHF will be unable to generate
> those particular objectives.

[Releases]: https://github.com/Warriors-Haven-Gaming/WHFramework/releases
[CUP Terrains - Core]: https://steamcommunity.com/sharedfiles/filedetails/?id=583496184
[CUP Vehicles]: https://steamcommunity.com/sharedfiles/filedetails/?id=541888371

## CBA Compatibility

Community Based Addons, or CBA_A3, can optionally be installed for the server hoster
and players to customize the gamemode to their liking. Various settings are provided
for OPFOR skill levels, max recruits, vehicle Active Protection Systems, self-reviving,
number of objectives, and more.

## ACE Compatibility

Certain features like damage reduction and our revive system are disabled when
ACE is loaded. However, we don't normally test ACE with this gamemode, so you
may encounter issues with it.

# License

This project is written under the [MIT License].

[Quiksilver's Invade & Annex]: https://github.com/auQuiksilver/Apex-Framework
[MIT License]: /LICENSE
