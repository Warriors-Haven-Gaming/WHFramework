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

The following vanilla factions are always available for opposing forces:
- CSAT
- CSAT (Pacific)
- AAF
- LDF
- Syndikat
- NATO \*
- NATO (Pacific) \*

Additional factions are supported with the following CDLC and mods:
- Expeditionary Forces
  - MJTF (Desert)
  - MJTF (Woodland)
- Western Sahara
  - ION Services
  - SFIA
  - Tura
  - UNA
- [CUP Vehicles] and Units
  - National Party of Chernarus
  - Armed Forces of the Russian Federation
  - AFRF (Modern)
  - Takistani Army
  - Takistani Militia
  - US Army (Woodland) \*
  - USMC (Woodland) \*
- [RHSAFRF]
  - Also... Armed Forces of the Russian Federation

\* To fight against BLUFOR factions, you must enable them in the gamemode's [CBA Settings](#cba-settings).
   These factions are converted to the OPFOR side when spawned.

[CUP Vehicles]: https://steamcommunity.com/sharedfiles/filedetails/?id=541888371
[RHSAFRF]: https://steamcommunity.com/sharedfiles/filedetails/?id=843425103

## How do I play?

You can find this gamemode published on the Steam Workshop:
[Warriors Haven Framework](https://steamcommunity.com/sharedfiles/filedetails/?id=3514182772)

Once subscribed, you can start the gamemode from Scenarios in the main menu,
or host it by going to Server Browser > Host Server and selecting Warriors Haven Framework
from the appropriate map. You may choose to host LAN if you want to play alone.

For dedicated server hosters, you can also host the gamemode directly from
the mission files on our [Releases] page. This allows players to join without
installing our mod, which is particularly helpful with our vanilla ports like
Altis and Tanoa.

Dedicated server hosters may also consider using our suggested [BattlEye filters]
to improve security. See this [DayZ BattlEye Guide] for more information.

[Releases]: https://github.com/Warriors-Haven-Gaming/WHFramework/releases/latest
[BattlEye filters]: https://github.com/Warriors-Haven-Gaming/WHFramework/tree/main/BattlEye
[DayZ BattlEye Guide]: https://opendayz.net/threads/a-guide-to-battleye-filters.21066/

## CBA Settings

Installing [CBA_A3] allows server hosters and players to customize the gamemode
to their liking in the Configure Addons menu. Various settings are provided for
OPFOR factions, skill levels, max recruits, vehicle Active Protection Systems,
self-reviving, number of objectives, and more. Without CBA_A3, the default settings
are always used.

[CBA_A3]: https://steamcommunity.com/sharedfiles/filedetails/?id=450814997

## ACE Compatibility

Certain features like damage reduction and our revive system are disabled when
ACE is loaded. However, we don't normally test ACE with this gamemode, so you
may encounter issues with it.

# License

This project is written under the [MIT License].

[Quiksilver's Invade & Annex]: https://github.com/auQuiksilver/Apex-Framework
[MIT License]: /LICENSE
