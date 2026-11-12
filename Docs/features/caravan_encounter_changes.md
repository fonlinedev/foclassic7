# FOClassic7 Caravan and Encounter Changes

## Purpose

This note documents the caravan-route configuration being prepared and
the encounter-combat behavior discussed for the FOClassic7 server.

**Status:** Configuration proposal / implementation notes. Treat the
route IDs and combat-mode changes as needing an in-game verification
pass before considering them final.

------------------------------------------------------------------------

## 1. Caravan routes

### Station list

The proposed station list uses these station indexes:

  ------------------------------------------------------------------------
                         Index Station               PID / note
  ---------------------------- --------------------- ---------------------
                             0 Hub                   `221`

                             1 Junktown              `70`

                             2 Shady Sands           `3`

                             3 Boneyard / Adytum     `280` --- confirm
                                                     this is the intended
                                                     Boneyard stop

                             4 Necropolis            `141` --- confirm
                                                     this is the correct
                                                     caravan station/map
                                                     PID

                             5 Brotherhood           `85` --- confirm
                                                     against
                                                     `Locations.cfg`;
                                                     exact station PID was
                                                     not verified
  ------------------------------------------------------------------------

The station index is the position in the first line of the caravan
configuration, not the PID itself.

### Forward route segments

The proposed configuration defines five forward segments:

``` ini
221 70 3 280 141 85 # Hub, Junktown, Shady Sands, Boneyard/Adytum, Necropolis, Brotherhood
5 # route segments
0 1 # Hub -> Junktown
1 2 # Junktown -> Shady Sands
0 3 # Hub -> Boneyard/Adytum
3 4 # Boneyard/Adytum -> Necropolis
1 5 # Junktown -> Brotherhood
```

This layout assumes the caravan system generates reverse routes after
the forward routes. Under that assumption, reverse route IDs are `5`
through `9`, corresponding in order to the five forward segments.

### Caravan route sequences

The following route sequences are proposed, using route IDs rather than
station indexes.

**Crimson Caravan --- Hub, Junktown, Shady Sands, then return**

``` ini
Crimson Caravan#
0 1 6 5 # Hub -> Junktown -> Shady Sands -> Junktown -> Hub
950 950
0 30 11001 11002 25
589 394
589 504
48 503 49 501 49 502
```

**Far Go Traders --- Hub, Junktown, Brotherhood, then return**

``` ini
Far Go Traders#
0 4 9 5 # Hub -> Junktown -> Brotherhood -> Junktown -> Hub
950 950
0 30 11001 11002 25
589 394
589 504
48 503 49 501 49 502
```

**Gun Runners --- Hub, Boneyard/Adytum, Necropolis, then return**

``` ini
Gun Runners#
2 3 8 7 # Hub -> Boneyard/Adytum -> Necropolis -> Boneyard/Adytum -> Hub
950 950
0 30 11001 11002 25
589 394
589 504
48 503 49 501 49 502
```

The NPC, leader, guard, bag, timing, dialog, and faction values above
were carried over from the existing example. They have not been
independently validated for each caravan faction. Replace them with
faction-specific values if the server configuration requires them.

### Route-ID assumption to verify

The working two-station test used:

``` ini
221 70
1
0 1
```

with the caravan route sequence `0 1`, which successfully produced
travel between Hub and Junktown. The proposed multi-route sequences rely
on the same interpretation: the reverse routes are appended after all
forward routes. Verify the five-segment route numbering in-game,
especially the return legs.

------------------------------------------------------------------------

## 2. Caravan encounter behavior

### Existing logic discussed

In `worldmap.fos`, `FindEncounter()` contained a special condition for
player caravans. The relevant logic was described as allowing a caravan
to bypass the usual random encounter roll when the current zone has a
positive encounter chance:

``` cpp
bool playerCaravan = valid(car) && _IsCaravanCar(car.GetProtoId());

if ((playerCaravan && int(zone.GetChance()) > 0) ||
    ((roll <= 5 || roll <= int(zone.GetChance()) / (empty ? 2 : 1)) && roll < 95))
```

This note records the observed behavior from the code discussion; it
does not establish that the encounter frequency is balanced or correct
for every zone.

### Intended combat-mode rule

The desired behavior is:

-   **Caravan encounters:** real-time combat.
-   **All non-caravan encounters:** turn-based combat.

The proposed logic was:

``` cpp
Critter@ leader = group[0];
bool isCaravanEncounter = valid(car) && _IsCaravanCar(car.GetProtoId());

// Caravan encounters are real-time; all other encounters are turn-based.
for(uint i = 0, j = loc.GetMapCount(); i < j; i++)
    loc.GetMapByIndex(i).SetTurnBasedAvailability(!isCaravanEncounter);

fe.TurnBased = !isCaravanEncounter;

if(isCaravanEncounter)
    combatMode = COMBAT_MODE_REAL_TIME;
else
    combatMode = COMBAT_MODE_TURN_BASED;
```

**Important:** This is the proposed change discussed, not a verified
final patch. In the reviewed function, `combatMode` was not visibly
consumed later in that function. If caravan encounters still start in
turn-based mode, trace the encounter-start/combat-start path and confirm
which value actually controls the combat mode. Also verify that
`SetTurnBasedAvailability()` and `fe.TurnBased` are set at the correct
point in the encounter lifecycle.

------------------------------------------------------------------------

## 3. Validation checklist

-   [ ] Confirm the Boneyard/Adytum, Necropolis, and Brotherhood station
    PIDs against `Locations.cfg`.
-   [ ] Confirm the caravan config parser's reverse-route generation and
    route-ID ordering.
-   [ ] Test Crimson Caravan: Hub → Junktown → Shady Sands → Junktown →
    Hub.
-   [ ] Test Far Go Traders: Hub → Junktown → Brotherhood → Junktown →
    Hub.
-   [ ] Test Gun Runners: Hub → Boneyard/Adytum → Necropolis →
    Boneyard/Adytum → Hub.
-   [ ] Confirm each caravan spawns the intended faction NPCs and
    guards.
-   [ ] Confirm caravan encounters start in real-time combat.
-   [ ] Confirm non-caravan encounters remain turn-based.
-   [ ] Test encounter behavior in zones with different encounter-chance
    values.

## 4. Files / code areas referenced

-   Caravan configuration file (route/station list and caravan blocks;
    exact filename not established in this note).
-   `worldmap.fos` --- `FindEncounter()` and the encounter
    invitation/combat-mode setup.
-   `Locations.cfg` --- verify station map/PID assignments before
    finalizing the route list.
