Mission Template Features

This template is built to help mission makers create content for www.TacticalGamer.com

The TacticalGamer.com logos and name are trademarks and not to be used outside of our servers. 

INIT.SQF
Scripted ACE Arsenal Option
Asset Markers
Toggle Civilian Occupation System
Mission Timer (required)
Set Refuel Vics (if using FARP)

INITPLAYER.SQF
Scripted Class Based BIS Arsenal
Control of ACE Interaction Items
  - Reset TFR Frequncies
  - View Distance
  - Get Radio Objects
Set Backpack Radio model for mission
Toggle Teleport to SL
Toggle Pathfinder Zeus Access
Toggle Player Map Marker System
Set per Player Respawn Tickets
FARP Easy Repair Settings
Toggle Restoring Loadout as at Death Upon Respawn
Handling respawnOnStart options

FUNCTIONS
           Client Functions
  - getShortRadio
  - getLongRadio
  - teleportToSL
  - reprogramRadios
  - squadUI (player map markers)
  - ammo (class based arsenal)
  - farpAction

           Server Functions
  - vehicleRespawn (add code to init of vic)
  - assetMarkers
  - ambientFlyBy
  - zeusAddAction (Pathfinder access)
  - civilianKilled
  - TGAceArsenal
  - missionTimer
  - ifAllPlayerDead (will end mission if all players are dead and have no respawns left)

EXAMPLE MISSION
Includes Required Addon Settings
Basic Player Organization and Loadouts
Examples of both Scripted Arsenal Options
Example of Support Vehicle Options
Pre-made FARP
Briefing Template (briefing.sqf)
TG Info In-Game Billboards
TG Info Briefing (full primer ect...)
TG Info Map Markers
Commented description.ext options