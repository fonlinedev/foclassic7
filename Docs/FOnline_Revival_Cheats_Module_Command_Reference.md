# FOnline Revival --- Cheats Module Command Reference

This document describes the commands implemented by the supplied
`cheats.fos` module.

## Quick start

The cheat module must be enabled in `config/Cheats.cfg`:

``` ini
EnableCheats=1

DevEnable=1

AllowIDDQD=1

AllowIDKFA=1

AllowCoreCheats=1
```

Authenticate as an administrator/authorized user with the credentials
configured in `config/GetAccess.cfg`:

``` text
~getaccess <username> <password>
```

Cheat commands are entered in-game with a backtick (\`) before the
command:

``` text
`<command> [arguments]
```

For example:

``` text
`getvar 7328
```

The `getvar` command reads the local variable for the selected target
and is particularly useful for debugging quest state.

## Target selection

Most target-aware commands default to the player executing the command.
The dispatcher also supports these target switches:

-   `-p <player>` --- target a player by name; the source also accepts a
    numeric critter/player ID here.
-   `-n <npc_id>` --- target an NPC by its NPC identifier.

Example:

``` text
`getvar 7328 -p SomePlayer
```

> **Important:** Not every command accepts every switch. Target
> selection is handled centrally, while individual commands decide which
> additional arguments they support.

## Command reference

### Access, administration and diagnostics

#### `accesslist`

List or inspect the configured access/authorization information used by
the cheat system.

**Syntax:** `accesslist [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `accesslist ...`

#### `corecheats`

Configure or invoke core cheat functionality exposed by the core cheat
subsystem.

**Syntax:** `corecheats [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `corecheats ...`

#### `devenable`

Enable or change developer-mode access for the current cheat session.

**Syntax:** `devenable [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `devenable ...`

#### `devinfo`

Show developer/cheat diagnostic information.

**Syntax:** `devinfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `devinfo ...`

#### `gameinfo`

Display general server/game information.

**Syntax:** `gameinfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `gameinfo ...`

#### `listcommands`

List commands available to the current access level.

**Syntax:** `listcommands [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listcommands ...`

#### `listauthenticated`

List currently authenticated/authorized users. `la` is an alias.

**Syntax:** `listauthenticated [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listauthenticated ...`

#### `la`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `la [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `la ...`

#### `log`

Write or inspect cheat-related logging information, depending on
arguments.

**Syntax:** `log [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `log ...`

#### `numplayers`

Display the current number of online players.

**Syntax:** `numplayers [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `numplayers ...`

#### `test`

Run the module's test command.

**Syntax:** `test [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `test ...`

#### `zeroext`

Clear/reset the extended mode flags on the target.

**Syntax:** `zeroext [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `zeroext ...`

### Players, critters and targeting

#### `alts`

Inspect alternate characters/accounts associated with a player.

**Syntax:** `alts [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `alts ...`

#### `critterinfo`

Display detailed information about the selected critter. `crinfo` is an
alias.

**Syntax:** `critterinfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `critterinfo ...`

#### `crinfo`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `crinfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `crinfo ...`

#### `findchars`

Search for characters by the supported search criteria.

**Syntax:** `findchars [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `findchars ...`

#### `findnpc`

Find an NPC using the module's configured NPC names/identifiers.

**Syntax:** `findnpc [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `findnpc ...`

#### `getleader`

Show the leader associated with the target/team.

**Syntax:** `getleader [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getleader ...`

#### `getleadertime`

Show the relevant leader/timing information.

**Syntax:** `getleadertime [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getleadertime ...`

#### `getcolor`

Display/resolve a configured color value.

**Syntax:** `getcolor [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getcolor ...`

#### `getclaim`

Show the target's claim information.

**Syntax:** `getclaim [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getclaim ...`

#### `getclaimtime`

Show the target's claim timing information.

**Syntax:** `getclaimtime [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getclaimtime ...`

#### `id2name`

Convert a critter/player ID to a name.

**Syntax:** `id2name [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `id2name ...`

#### `name2id`

Convert a player/name to an ID.

**Syntax:** `name2id [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `name2id ...`

#### `inspect`

Inspect the target and display internal information available to the
command.

**Syntax:** `inspect [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `inspect ...`

#### `lastregistered`

Show the last registered character/entity tracked by the module.

**Syntax:** `lastregistered [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `lastregistered ...`

#### `lastspawned`

Show information about the last spawned entity.

**Syntax:** `lastspawned [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `lastspawned ...`

#### `listplayers`

List online players. `lp` is an alias.

**Syntax:** `listplayers [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listplayers ...`

#### `lp`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `lp [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `lp ...`

#### `listtracked`

List players currently tracked by the cheat system. `lt` is an alias.

**Syntax:** `listtracked [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listtracked ...`

#### `lt`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `lt [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `lt ...`

#### `trackplayer`

Start tracking a player.

**Syntax:** `trackplayer [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `trackplayer ...`

#### `stoptrackplayer`

Stop tracking a tracked player.

**Syntax:** `stoptrackplayer [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `stoptrackplayer ...`

#### `showhands`

Show the target's equipped/held hands/items.

**Syntax:** `showhands [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `showhands ...`

#### `showloc`

Show the target's location/visibility information.

**Syntax:** `showloc [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `showloc ...`

#### `hideloc`

Hide location information.

**Syntax:** `hideloc [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `hideloc ...`

#### `hidemap`

Hide the map/location from the relevant display.

**Syntax:** `hidemap [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `hidemap ...`

#### `tentinfo`

Display information about the target's tent.

**Syntax:** `tentinfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `tentinfo ...`

#### `team`

Inspect/manipulate team membership for the target.

**Syntax:** `team [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `team ...`

#### `summon`

Summon the target to the invoking player.

**Syntax:** `summon [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `summon ...`

#### `summonteam`

Summon the target's team.

**Syntax:** `summonteam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `summonteam ...`

#### `goto`

Move to the specified target/location.

**Syntax:** `goto [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `goto ...`

#### `gototeam`

Move to a team/target group.

**Syntax:** `gototeam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `gototeam ...`

#### `move`

Move the target according to the command's movement parameters.

**Syntax:** `move [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `move ...`

#### `teleport`

Teleport the target. `tp` is an alias.

**Syntax:** `teleport [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `teleport ...`

#### `tp`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `tp [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `tp ...`

#### `teleportteam`

Teleport the target's team.

**Syntax:** `teleportteam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `teleportteam ...`

#### `phase`

Shift/phase the target without team mode.

**Syntax:** `phase [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `phase ...`

#### `phaseteam`

Shift/phase the target's team.

**Syntax:** `phaseteam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `phaseteam ...`

### NPCs, followers and spawning

#### `addfollower`

Add an NPC as a follower of the target.

**Syntax:** `addfollower [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `addfollower ...`

#### `addmob`

Spawn/add a mob.

**Syntax:** `addmob [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `addmob ...`

#### `addnpc`

Spawn/add an NPC.

**Syntax:** `addnpc [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `addnpc ...`

#### `controlmobs`

Take/control mobs using the cheat subsystem.

**Syntax:** `controlmobs [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `controlmobs ...`

#### `controlnpc`

Take/control an NPC.

**Syntax:** `controlnpc [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `controlnpc ...`

#### `dismiss`

Dismiss/remove the target's follower.

**Syntax:** `dismiss [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `dismiss ...`

#### `dismissteam`

Dismiss/remove the target's team/followers.

**Syntax:** `dismissteam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `dismissteam ...`

#### `massspawn`

Spawn multiple entities according to the command parameters.

**Syntax:** `massspawn [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `massspawn ...`

#### `spawncar`

Spawn a car for/near the target.

**Syntax:** `spawncar [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `spawncar ...`

#### `spawnitem`

Spawn an item for/near the target.

**Syntax:** `spawnitem [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `spawnitem ...`

#### `spawnpoint`

Create/use a spawn point using the supplied parameters.

**Syntax:** `spawnpoint [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `spawnpoint ...`

#### `makeencounter`

Create a random/world encounter using the command parameters.

**Syntax:** `makeencounter [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `makeencounter ...`

#### `clone`

Clone the selected target/entity.

**Syntax:** `clone [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `clone ...`

#### `rotate`

Rotate the target/entity.

**Syntax:** `rotate [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `rotate ...`

### Items, inventory and economy

#### `addbankmoney`

Add money to the target's bank account.

**Syntax:** `addbankmoney [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `addbankmoney ...`

#### `removebankmoney`

Remove money from the target's bank account.

**Syntax:** `removebankmoney [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `removebankmoney ...`

#### `checkbank`

Inspect the current player's bank information.

**Syntax:** `checkbank [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `checkbank ...`

#### `checkbanks`

Inspect bank information for the supported bank accounts.

**Syntax:** `checkbanks [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `checkbanks ...`

#### `checkbankaccount`

Inspect a bank account.

**Syntax:** `checkbankaccount [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `checkbankaccount ...`

#### `checkbankaccounts`

Inspect multiple/all supported bank accounts.

**Syntax:** `checkbankaccounts [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `checkbankaccounts ...`

#### `countitems`

Count items matching the supplied criteria.

**Syntax:** `countitems [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `countitems ...`

#### `finditems`

Search for items.

**Syntax:** `finditems [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `finditems ...`

#### `getitems`

List or inspect the target's items.

**Syntax:** `getitems [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getitems ...`

#### `getitembonuses`

Show bonus data attached to an item.

**Syntax:** `getitembonuses [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getitembonuses ...`

#### `give`

Give/create the requested item or resource for the target.

**Syntax:** `give [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `give ...`

#### `givekey`

Give a key to the target.

**Syntax:** `givekey [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `givekey ...`

#### `itemflags`

Inspect, set, unset, or list item flags.

**Syntax:** `itemflags [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `itemflags ...`

#### `itemlight`

Inspect/change item lighting-related data.

**Syntax:** `itemlight [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `itemlight ...`

#### `itemproto`

Inspect item prototype information.

**Syntax:** `itemproto [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `itemproto ...`

#### `items`

List available item prototypes. `itemlist` is an alias.

**Syntax:** `items [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `items ...`

#### `itemlist`

Alias of `items`; lists available item prototypes.

**Syntax:** `itemlist [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `itemlist ...`

#### `pickitems`

Pick up/select items according to the command parameters.

**Syntax:** `pickitems [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `pickitems ...`

#### `removeitems`

Remove items matching the supplied criteria.

**Syntax:** `removeitems [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `removeitems ...`

#### `dropitems`

Drop/remove items from the target.

**Syntax:** `dropitems [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `dropitems ...`

#### `repair`

Repair the target's equipment/item according to the command parameters.

**Syntax:** `repair [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `repair ...`

#### `virtualmoney`

Inspect or modify virtual money using the command's parameters.

**Syntax:** `virtualmoney [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `virtualmoney ...`

#### `resetprices`

Reinitialize/reset economy prices.

**Syntax:** `resetprices [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `resetprices ...`

#### `lootdrop`

Inspect or manipulate map loot-drop configuration.

**Syntax:** `lootdrop [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `lootdrop ...`

### Variables, parameters and character modification

#### `getvar`

Read a local variable (LVAR) from the target.

**Syntax:** `getvar <var_number|var_name> [-p <player>] [-n <npc_id>]`

**Example form:** `getvar 7328`

#### `setvar`

Set a local variable (LVAR) on the target.

**Syntax:**
`setvar <var_number|var_name> <value> [-p <player>] [-n <npc_id>]`

**Example form:** `setvar 7328 1`

#### `getuvar`

Read a unique variable (UVAR) involving the target and nearby critters.

**Syntax:**
`getuvar <var_number|var_name> [value] [-r] [-p <player>] [-n <npc_id>]`

**Example form:** `getuvar <var_number> ...`

#### `setuvar`

Set a unique variable (UVAR).

**Syntax:**
`setuvar <var_number|var_name> [value] [-r] [-p <player>] [-n <npc_id>]`

**Example form:** `setuvar <var_number> ...`

#### `showvars`

Display variables for the target.

**Syntax:** `showvars [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `showvars ...`

#### `questvars`

List quest variables. `qvars` and `vars` are aliases.

**Syntax:** `questvars [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `questvars ...`

#### `qvars`

Alias of `questvars`.

**Syntax:** `qvars [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `qvars ...`

#### `vars`

Alias of `questvars`.

**Syntax:** `vars [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `vars ...`

#### `param`

Read/inspect a character parameter.

**Syntax:** `param [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `param ...`

#### `params`

List available character parameters. `paramlist` is an alias.

**Syntax:** `params [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `params ...`

#### `paramlist`

Alias of `params`; lists available character parameters.

**Syntax:** `paramlist [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `paramlist ...`

#### `modchar`

Modify character data using the command's supported parameters.

**Syntax:** `modchar [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `modchar ...`

#### `sethp`

Set the target's hit points.

**Syntax:** `sethp [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `sethp ...`

#### `setperk`

Set/modify a perk on the target.

**Syntax:** `setperk [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setperk ...`

#### `perkadjust`

Adjust perk-related data on the target.

**Syntax:** `perkadjust [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `perkadjust ...`

#### `profadjust`

Adjust profession-related data on the target.

**Syntax:** `profadjust [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `profadjust ...`

#### `gainskillxp`

Give skill XP to the target.

**Syntax:** `gainskillxp [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `gainskillxp ...`

#### `xp`

Give XP to the target.

**Syntax:** `xp [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `xp ...`

#### `xpteam`

Give XP to the target's team.

**Syntax:** `xpteam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `xpteam ...`

#### `setexpmod`

Set the experience modifier.

**Syntax:** `setexpmod [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setexpmod ...`

#### `karma`

Inspect/modify karma for the target.

**Syntax:** `karma [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `karma ...`

#### `karmateam`

Inspect/modify karma for the target's team.

**Syntax:** `karmateam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `karmateam ...`

#### `playerkarma`

Inspect player karma.

**Syntax:** `playerkarma [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `playerkarma ...`

#### `setreputation`

Set target reputation. `setrep` is an alias.

**Syntax:** `setreputation [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setreputation ...`

#### `setrep`

Alias of `setreputation`.

**Syntax:** `setrep [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setrep ...`

#### `resetreputations`

Reset reputation data for the target.

**Syntax:** `resetreputations [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `resetreputations ...`

#### `changefaction`

Change the target's faction.

**Syntax:** `changefaction [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `changefaction ...`

#### `setfaction`

Set the target's faction.

**Syntax:** `setfaction [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setfaction ...`

#### `changerank`

Change the target's faction rank.

**Syntax:** `changerank [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `changerank ...`

#### `factioninfo`

Display faction information.

**Syntax:** `factioninfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `factioninfo ...`

#### `factionnews`

Display faction news.

**Syntax:** `factionnews [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `factionnews ...`

#### `factiononline`

Display online faction information.

**Syntax:** `factiononline [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `factiononline ...`

#### `registerfaction`

Register/create a faction using the supplied parameters.

**Syntax:** `registerfaction [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `registerfaction ...`

#### `removefaction`

Remove a faction.

**Syntax:** `removefaction [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `removefaction ...`

#### `gaintowncontrol`

Give/control town ownership for the supported town system.

**Syntax:** `gaintowncontrol [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `gaintowncontrol ...`

### Combat, health and status

#### `damage`

Apply damage to the target.

**Syntax:** `damage [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `damage ...`

#### `deathincarnate`

Apply the module's death/incarnation effect to the target.

**Syntax:** `deathincarnate [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `deathincarnate ...`

#### `heal`

Heal the target.

**Syntax:** `heal [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `heal ...`

#### `healall`

Heal the target/all applicable targets according to the command
implementation.

**Syntax:** `healall [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `healall ...`

#### `irradiate`

Apply radiation to the target.

**Syntax:** `irradiate [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `irradiate ...`

#### `poison`

Apply poison to the target.

**Syntax:** `poison [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `poison ...`

#### `saferegen`

Perform the module's safe regeneration operation.

**Syntax:** `saferegen [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `saferegen ...`

#### `kill`

Kill the target.

**Syntax:** `kill [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `kill ...`

#### `killmobs`

Kill mobs in the supported scope.

**Syntax:** `killmobs [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `killmobs ...`

#### `criticalchance`

Inspect/modify the target's critical chance.

**Syntax:** `criticalchance [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `criticalchance ...`

#### `normaldeadly`

Toggle/apply normal/deadly combat behavior on the target.

**Syntax:** `normaldeadly [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `normaldeadly ...`

#### `suicide`

Kill the invoking player.

**Syntax:** `suicide [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `suicide ...`

#### `dropdrugs`

Remove/drop drug effects/items from the target.

**Syntax:** `dropdrugs [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `dropdrugs ...`

#### `clearinventory`

Clear the target's inventory.

**Syntax:** `clearinventory [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `clearinventory ...`

#### `respawn`

Respawn the target. `revive` is an alias.

**Syntax:** `respawn [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `respawn ...`

#### `revive`

Alias of `respawn`.

**Syntax:** `revive [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `revive ...`

#### `respawnall`

Respawn all applicable targets. `reviveall` is an alias.

**Syntax:** `respawnall [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `respawnall ...`

#### `reviveall`

Alias of `respawnall`.

**Syntax:** `reviveall [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `reviveall ...`

#### `respawnallplayers`

Respawn all players. `reviveallplayers` is an alias.

**Syntax:** `respawnallplayers [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `respawnallplayers ...`

#### `reviveallplayers`

Alias of `respawnallplayers`.

**Syntax:** `reviveallplayers [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `reviveallplayers ...`

#### `clearillegalflags`

Clear illegal item flags from the target.

**Syntax:** `clearillegalflags [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `clearillegalflags ...`

#### `clearallillegalflags`

Clear illegal flags globally/for the supported scope.

**Syntax:**
`clearallillegalflags [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `clearallillegalflags ...`

#### `clearenemystack`

Clear the target's enemy stack.

**Syntax:** `clearenemystack [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `clearenemystack ...`

#### `clearenemystacks`

Clear enemy stacks in the broader supported scope. `ces` is an alias.

**Syntax:** `clearenemystacks [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `clearenemystacks ...`

#### `ces`

Alias of `clearenemystacks`.

**Syntax:** `ces [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `ces ...`

#### `cleartimeouts`

Clear the target's timeouts. `cto` is an alias.

**Syntax:** `cleartimeouts [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `cleartimeouts ...`

#### `cto`

Alias of `cleartimeouts`.

**Syntax:** `cto [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `cto ...`

#### `dropalltimeouts`

Clear/drop all timeout data.

**Syntax:** `dropalltimeouts [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `dropalltimeouts ...`

#### `settimeout`

Set a timeout on the target. `sto` is an alias.

**Syntax:** `settimeout [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `settimeout ...`

#### `sto`

Alias of `settimeout`.

**Syntax:** `sto [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `sto ...`

### Maps, towns and world

#### `maps`

List maps. `maplist` is an alias.

**Syntax:** `maps [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `maps ...`

#### `maplist`

Alias of `maps`.

**Syntax:** `maplist [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `maplist ...`

#### `listmaps`

List maps.

**Syntax:** `listmaps [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listmaps ...`

#### `mapinfo`

Display information about the current/selected map.

**Syntax:** `mapinfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `mapinfo ...`

#### `createlocation`

Create a location using the supplied location/map parameters.

**Syntax:** `createlocation [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `createlocation ...`

#### `deletelocation`

Delete a location.

**Syntax:** `deletelocation [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `deletelocation ...`

#### `setmapdata`

Set map data fields.

**Syntax:** `setmapdata [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setmapdata ...`

#### `checktown`

Inspect town state/control information.

**Syntax:** `checktown [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `checktown ...`

#### `resettown`

Reset one town.

**Syntax:** `resettown [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `resettown ...`

#### `resettowns`

Reset multiple/all supported towns.

**Syntax:** `resettowns [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `resettowns ...`

#### `setlocvisibility`

Set location visibility.

**Syntax:** `setlocvisibility [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setlocvisibility ...`

#### `setrain`

Set rain/weather state.

**Syntax:** `setrain [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setrain ...`

#### `zone`

Manage/display zone information or zoning according to parameters.

**Syntax:** `zone [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `zone ...`

#### `zoneplayers`

Operate on players in a zone.

**Syntax:** `zoneplayers [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `zoneplayers ...`

#### `toglobal`

Move/transfer the target to the global/world scope.

**Syntax:** `toglobal [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `toglobal ...`

#### `teleporter`

Operate the configured teleporter system.

**Syntax:** `teleporter [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `teleporter ...`

### Map/gameplay toggles and effects

#### `disabledismantling`

Disable dismantling on the relevant map.

**Syntax:** `disabledismantling [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `disabledismantling ...`

#### `enabledismantling`

Enable dismantling on the relevant map.

**Syntax:** `enabledismantling [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `enabledismantling ...`

#### `disablegrids`

Disable map grids.

**Syntax:** `disablegrids [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `disablegrids ...`

#### `enablegrids`

Enable map grids.

**Syntax:** `enablegrids [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `enablegrids ...`

#### `disablepvp`

Disable PvP on the relevant map.

**Syntax:** `disablepvp [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `disablepvp ...`

#### `enablepvp`

Enable PvP on the relevant map.

**Syntax:** `enablepvp [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `enablepvp ...`

#### `disabletb`

Disable turn-based combat.

**Syntax:** `disabletb [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `disabletb ...`

#### `enabletb`

Enable turn-based combat.

**Syntax:** `enabletb [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `enabletb ...`

#### `disguise`

Apply/change the target's disguise.

**Syntax:** `disguise [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `disguise ...`

#### `disguiseinfo`

Show disguise information.

**Syntax:** `disguiseinfo [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `disguiseinfo ...`

#### `resetalldisguises`

Reset all disguises.

**Syntax:** `resetalldisguises [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `resetalldisguises ...`

#### `lock`

Lock the target/object supported by the command.

**Syntax:** `lock [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `lock ...`

#### `lockcar`

Lock a car.

**Syntax:** `lockcar [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `lockcar ...`

#### `unlockcar`

Unlock a car.

**Syntax:** `unlockcar [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `unlockcar ...`

#### `explode`

Create an explosion using the supplied parameters.

**Syntax:** `explode [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `explode ...`

#### `airstrike`

Trigger an airstrike at the specified location/target.

**Syntax:** `airstrike [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `airstrike ...`

#### `flash`

Send a flash-window style message/effect.

**Syntax:** `flash [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `flash ...`

#### `aura`

Apply/create an aura effect.

**Syntax:** `aura [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `aura ...`

#### `auracleanup`

Clean up aura effects.

**Syntax:** `auracleanup [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `auracleanup ...`

#### `setanim`

Set the target's animation.

**Syntax:** `setanim [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setanim ...`

#### `masssetanim`

Set animations for multiple targets.

**Syntax:** `masssetanim [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `masssetanim ...`

### Communication and presentation

#### `say`

Make the target/player speak normal text.

**Syntax:** `say [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `say ...`

#### `sayh`

Make the target/player speak with text displayed over the head.

**Syntax:** `sayh [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `sayh ...`

#### `shout`

Make the target/player shout.

**Syntax:** `shout [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `shout ...`

#### `shouth`

Make the target/player shout with text displayed over the head.

**Syntax:** `shouth [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `shouth ...`

#### `whisper`

Make the target/player whisper.

**Syntax:** `whisper [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `whisper ...`

#### `whisperh`

Make the target/player whisper with text displayed over the head.

**Syntax:** `whisperh [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `whisperh ...`

#### `append`

Send appended speech/text.

**Syntax:** `append [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `append ...`

#### `dialog`

Send dialog-style speech.

**Syntax:** `dialog [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `dialog ...`

#### `emote`

Send an emote.

**Syntax:** `emote [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `emote ...`

#### `emoteh`

Send an emote displayed over the head.

**Syntax:** `emoteh [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `emoteh ...`

#### `netmsg`

Send a network/system message.

**Syntax:** `netmsg [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `netmsg ...`

#### `bc`

Broadcast a message. `broadcast` is an alias.

**Syntax:** `bc [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `bc ...`

#### `broadcast`

Alias of `bc`; broadcast a message.

**Syntax:** `broadcast [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `broadcast ...`

#### `playmusic`

Play music using the supplied music identifier/parameters.

**Syntax:** `playmusic [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `playmusic ...`

#### `playsound`

Play a sound.

**Syntax:** `playsound [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `playsound ...`

#### `playspeech`

Play speech audio.

**Syntax:** `playspeech [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `playspeech ...`

### Events, faction and miscellaneous

#### `cleanup`

Run general cheat/world cleanup.

**Syntax:** `cleanup [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `cleanup ...`

#### `cleanitems`

Clean items according to the module's cleanup rules.

**Syntax:** `cleanitems [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `cleanitems ...`

#### `reservednickname`

Manage reserved nicknames.

**Syntax:** `reservednickname [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `reservednickname ...`

#### `deathmatch`

Start/configure the deathmatch functionality.

**Syntax:** `deathmatch [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `deathmatch ...`

#### `startevent`

Start the configured event system.

**Syntax:** `startevent [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `startevent ...`

#### `stopevent`

Stop the configured event system.

**Syntax:** `stopevent [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `stopevent ...`

#### `rundialog`

Run a dialog on the target.

**Syntax:** `rundialog [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `rundialog ...`

#### `condition`

Inspect/change a condition on the target.

**Syntax:** `condition [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `condition ...`

#### `blockers`

Inspect/configure blocker behavior.

**Syntax:** `blockers [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `blockers ...`

#### `antiblock`

Apply the anti-block operation.

**Syntax:** `antiblock [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `antiblock ...`

### Other / module commands

#### `foart`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `foart [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `foart ...`

#### `getrequests`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `getrequests [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `getrequests ...`

#### `gettime`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `gettime [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `gettime ...`

#### `iddqd`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `iddqd [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `iddqd ...`

#### `idkfa`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `idkfa [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `idkfa ...`

#### `killeradmin`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `killeradmin [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `killeradmin ...`

#### `listfactions`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `listfactions [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listfactions ...`

#### `listfollowers`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `listfollowers [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listfollowers ...`

#### `listtents`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `listtents [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `listtents ...`

#### `setlexem`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `setlexem [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `setlexem ...`

#### `shift`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `shift [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `shift ...`

#### `shiftteam`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `shiftteam [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `shiftteam ...`

#### `slap`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `slap [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `slap ...`

#### `massslap`

Execute the corresponding cheat operation implemented by the `cheats`
module.

**Syntax:** `massslap [arguments] [-p <player>] [-n <npc_id>]`

**Example form:** `massslap ...`

## Variable debugging examples

### Read an LVAR

``` text
`getvar 7328
```

The command accepts either a numeric variable ID or a variable name
known to `GetVarId()`.

### Set an LVAR

``` text
`setvar 7328 1
```

### Read a UVAR

``` text
`getuvar <var_number>
```

`getuvar` examines the unique-variable relationship for the target and
nearby critters; `-r` reverses the master/slave relationship used by the
implementation.

## Access and implementation notes

-   The dispatcher checks whether the executing player is allowed to use
    the requested command unless the module is compiled in debug mode.

-   The command lists in the source contain some legacy/commented
    entries. This document focuses on commands that are actually
    dispatched by the current `ExecCommand()` implementation.

-   `animate`, `foart`, `help`'s old direct handler, `riddle`, and
    `usedammo` have commented-out dispatcher branches in the supplied
    source and therefore are **not treated as active commands here**
    merely because some names appear in the command lists.

-   Command argument validation is implemented individually by each
    command. Where the source does not expose a simple universal syntax,
    this document uses `[arguments]` rather than inventing parameter
    names.

-   Aliases are implemented in the dispatcher and therefore behave as
    alternate names for their corresponding commands.

## Source

Generated from the supplied `cheats.fos` source file for the FOnline
Revival project.
