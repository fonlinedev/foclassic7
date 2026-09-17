# FOnline Companion System

## Overview

The companion system creates generic NPC companions and allows them to appear on configured maps, be recruited by the player, and subsequently function as followers.

The system depends on two important parts:

1. **Companion configuration** — defines the basic companion settings, available NPC prototypes, equipment bags, companion types, and maps where companions can spawn.
2. **Map entires** — define the locations where companions are allowed to appear.

If a map is added to the companion system but does not contain the required entires, the companion may be created but the system will not be able to find a valid position for it.

---

# 1. Main Companion Configuration

The basic companion configuration is defined in:

```text
companion_h.fos
```

The file begins by including the map and bag definitions:

```cpp
#include "_maps.fos"
#include "_bags.fos"
```

These files provide the map and inventory-related definitions used by the companion system.

---

# 2. General Companion Settings

The following definitions establish the basic behavior of the companion system:

```cpp
#define COMPANIONS_UPDATE_INTERVAL    (REAL_MINUTE(1))
#define COMPANION_DIALOG_ID           (9310)
```

### `COMPANIONS_UPDATE_INTERVAL`

```cpp
#define COMPANIONS_UPDATE_INTERVAL    (REAL_MINUTE(1))
```

The companion update system runs at one-minute intervals.

This controls how frequently the companion management function is called.

### `COMPANION_DIALOG_ID`

```cpp
#define COMPANION_DIALOG_ID           (9310)
```

This is the dialogue ID used by recruited companions.

The dialogue associated with this ID must exist in the dialogue configuration.

---

# 3. Special Companion IDs

The configuration also contains IDs for specific predefined companions:

```cpp
#define IAN_PID              (32)
#define IAN_BAG_ID           (7)
#define TANDI_BAG_ID         (3)
```

These values identify the special companion prototypes and their associated equipment.

Ian uses:

```text
PID: 32
Bag: 7
```

Tandi uses:

```text
PID: 68
Bag: 3
```

The generic companion system is separate from these specific companions.

---

# 4. Companion Dialogue

The system has a separate dialogue ID used before the companion is recruited:

```cpp
#define COMPANION_DIALOG_PRE_ID       (9321)
```

This dialogue is used when interacting with an un recruited generic companion.

The normal recruited companion dialogue is:

```cpp
#define COMPANION_DIALOG_ID           (9310)
```

Therefore, the project should contain both relevant dialogue definitions.

---

# 5. Initial Companion Spawns

The number of companions initially created is defined by:

```cpp
#define COMPANION_INITIAL_SPAWNS      (35)
```

This means that the initial companion setup attempts to create **35 companions** when the initialization conditions are met.

The companions are subsequently managed by the companion update system.

---

# 6. Companion Types

The companion system defines several companion types:

```cpp
#define COMPANION_TYPE_MELEE          (0)
#define COMPANION_TYPE_SG             (1)
#define COMPANION_TYPE_BG             (2)
#define COMPANION_TYPE_ENERGY         (3)
#define COMPANION_TYPE_THROW         (4)
```

The currently defined types are:

| Type                    | Value | Description                |
| ----------------------- | ----: | -------------------------- |
| `COMPANION_TYPE_MELEE`  |     0 | Melee companion            |
| `COMPANION_TYPE_SG`     |     1 | Small Guns companion       |
| `COMPANION_TYPE_BG`     |     2 | Big Guns companion         |
| `COMPANION_TYPE_ENERGY` |     3 | Energy Weapons companion   |
| `COMPANION_TYPE_THROW`  |     4 | Throwing weapons companion |

The type determines which equipment bag and primary skill configuration is used when the generic companion is created.

---

# 7. Maps Where Companions Can Appear

The most important configuration for adding new companion locations is:

```cpp
uint[] companion_map_pids = { 1 };
```

This array contains the map PIDs on which generic companions can be placed.

For example:

```cpp
uint[] companion_map_pids = { 1, 2, 10 };
```

would allow those maps to be selected by the companion system.

## Important

Every map added to `companion_map_pids` must be configured with the appropriate companion entires.

The configuration itself explicitly states:

```cpp
// Add any new maps here, they should contain at least one entire of each type, see _entires.fos
```

Therefore, adding a map PID to this array is **not sufficient by itself**.

The map must also contain the required entires.

---

# 8. Companion NPC Prototypes

The NPC prototypes used when creating generic companions are defined here:

```cpp
uint[] companion_pids = { 23, 24, 36, 37, 40, 41 };
```

These are the critter PIDs from which new generic companions are created.

When a new companion is spawned, one of these PIDs is selected.

To add additional companion NPC prototypes, add their PIDs to this array.

For example:

```cpp
uint[] companion_pids = { 23, 24, 36, 37, 40, 41, 50 };
```

The corresponding critter prototype must of course exist and be valid in the game's critter configuration.

---

# 9. Companion Equipment Bags

Different companion types use different equipment bags.

## Melee

```cpp
uint[] companion_bags_melee = { 150, 151, 152, };
```

The system randomly selects one of these bags for a melee companion.

## Small Guns

```cpp
uint[] companion_bags_sg = { 166, 167, 170, 171, 172, 212 };
```

These bags are used for Small Guns companions.

## Big Guns

```cpp
uint[] companion_bags_bg = { 1 };
```

## Energy Weapons

```cpp
uint[] companion_bags_energy = { 1 };
```

## Throwing

The throwing configuration currently uses:

```cpp
uint[] companion_bags_throw = { 1 };
```

There is also an alternative configuration commented out:

```cpp
//uint[] companion_bags_throw = { 210 };
```

The active configuration is therefore currently using bag `1`.

---

# 10. Map Entires

The companion placement system relies on map entires.

The relevant entire definitions are located in:

```text
_entires.fos
```

The basic companion placement entire is:

```cpp
#define ENTIRE_COMPANION (101)
```

This entire identifies locations where companions may stand.

The companion code searches the map for a free hex associated with the configured companion entire.

Conceptually:

```text
Map
│
├── ENTIRE_COMPANION
│       └── Companion spawn/stand location
│
├── Other map entires
│
└── Map objects
```

---

# 11. Why the Entires Are Required

When a companion is created, the system does not simply place it at an arbitrary coordinate.

It searches the map for a suitable configured companion location.

The relevant logic uses the companion entire definition and attempts to find a free hex.

This means that a newly added companion map must have at least one suitable companion entire.

If the map does not contain one, the system may be unable to find a valid position for the NPC.

This is therefore an important requirement when adding new companion maps.

---

# 12. Adding a New Companion Map

To add another map to the companion system, follow these steps.

### Step 1 — Add the map PID

Open:

```text
companion_h.fos
```

Find:

```cpp
uint[] companion_map_pids = { 1 };
```

Add the new map PID.

For example:

```cpp
uint[] companion_map_pids = { 1, 25 };
```

---

### Step 2 — Configure the map entires

Open the relevant map in the map editor.

Add the required companion entire(s).

The companion placement system expects the map to contain the appropriate companion entire definitions from:

```text
_entires.fos
```

At minimum, ensure that the map contains:

```text
ENTIRE_COMPANION
```

which is:

```text
101
```

---

### Step 3 — Place the entire in an appropriate location

Place the companion entire in a location where an NPC can safely stand.

Good locations include areas such as:

* bars,
* common areas,
* town interiors,
* designated NPC gathering locations.

Avoid placing it inside walls, blocked terrain, inaccessible areas, or locations where an NPC cannot safely move.

---

### Step 4 — Verify the map

After updating the map, verify that the entire is actually present in the map data.

The map PID must correspond to the PID added to:

```cpp
companion_map_pids
```

---

### Step 5 — Restart/reload as required

After changing the script or map data, restart or reload the relevant server data according to the project's normal development workflow.

---

# 13. Debugging Companion Creation

The companion system can be compiled with:

```cpp
#define DEBUG_COMPANION
```

When enabled, debug output can be used to confirm where companions are being created.

For example:

```cpp
#ifdef DEBUG_COMPANION
    DLog("Created companion with id " + cr.Id +
         " moving to map " + MapPid);
#endif
```

This is useful when a companion is apparently missing.

The debug output can confirm:

* the companion ID,
* the selected map,
* whether the creation code is being reached,
* and where the companion system is attempting to send the NPC.

---

# 14. Debugging Map Placement

If a companion is created but cannot be found, first check:

1. Which map PID was selected.
2. Whether that map contains `ENTIRE_COMPANION`.
3. Whether the entire is located somewhere accessible.
4. Whether a free hex can be found around the entire.
5. Whether the companion subsequently leaves the map through the normal companion update system.

A successful creation message does not necessarily mean that the NPC will remain in the same location.

The companion system also contains logic that updates companions periodically and can move them between locations.

---

# 15. Recruitment

Generic companions are recruited through the companion dialogue.

During testing, an issue was found in the generic recruitment function.

The generic recruitment path was attempting to remove the companion from the `Companions` array twice.

The first removal occurred in the main recruitment function:

```cpp
uint index = FindInArray(Companions, npc.Id);
if(index < Companions.length())
    Companions.removeAt(index);
```

The generic recruitment function then attempted another removal of the same companion.

This resulted in:

```text
Script exception: Index out of bounds
```

The fix was to remove the duplicate array-removal operation from the generic recruitment function.

The generic recruitment function should perform the follower setup without attempting to remove the NPC from `Companions` a second time.

---

# 16. Recommended Configuration Workflow

When introducing a new companion map, use this order:

```text
1. Create/update the map
          ↓
2. Add companion entires
          ↓
3. Confirm ENTIRE_COMPANION exists
          ↓
4. Add the map PID to companion_map_pids
          ↓
5. Confirm companion NPC PIDs exist
          ↓
6. Confirm equipment bags exist
          ↓
7. Compile/reload scripts
          ↓
8. Start the server
          ↓
9. Trigger companion creation
          ↓
10. Check DEBUG_COMPANION output
          ↓
11. Locate the NPC on the map
          ↓
12. Test recruitment
```

---

# 17. Current Basic Configuration

The current `companion_h.fos` configuration is:

```cpp
#define COMPANIONS_UPDATE_INTERVAL    (REAL_MINUTE(1))
#define COMPANION_DIALOG_ID           (9310)

#define IAN_PID              (32)
#define IAN_BAG_ID           (7)
#define TANDI_BAG_ID         (3)

#define COMPANION_DIALOG_PRE_ID       (9321)
#define COMPANION_INITIAL_SPAWNS      (35)

#define COMPANION_TYPE_MELEE          (0)
#define COMPANION_TYPE_SG             (1)
#define COMPANION_TYPE_BG             (2)
#define COMPANION_TYPE_ENERGY         (3)
#define COMPANION_TYPE_THROW          (4)

uint[] companion_map_pids = { 1 };

uint[] companion_pids = { 23, 24, 36, 37, 40, 41 };

uint[] companion_bags_melee = { 150, 151, 152 };
uint[] companion_bags_sg = { 166, 167, 170, 171, 172, 212 };
uint[] companion_bags_bg = { 1 };
uint[] companion_bags_energy = { 1 };
uint[] companion_bags_throw = { 1 };
```

This provides the basic configuration required by the current companion implementation.

---

# 18. Quick Checklist

Before adding a new map:

* [ ] Map exists and has the correct PID.
* [ ] Map PID is present in `companion_map_pids`.
* [ ] Map contains `ENTIRE_COMPANION`.
* [ ] Companion entire has a usable/free location.
* [ ] Required companion NPC prototypes exist.
* [ ] Required equipment bags exist.
* [ ] Companion dialogue exists.
* [ ] Scripts have been recompiled/reloaded.
* [ ] Server has been restarted/reloaded as required.
* [ ] Companion creation has been tested.
* [ ] Companion recruitment has been tested.

---

## Summary

The companion system is controlled primarily through `companion_h.fos`, while the actual companion placement locations are defined through map entires.

The most important relationship to remember is:

```text
companion_map_pids
        │
        ▼
     Map PID
        │
        ▼
Map must contain companion entires
        │
        ▼
ENTIRE_COMPANION
        │
        ▼
Free hex is selected
        │
        ▼
Companion NPC is placed
```

Therefore, **adding a map PID to `companion_map_pids` without adding the corresponding map entires is not enough**.

For reliable companion placement, configure both sides:

```text
companion_h.fos
    → Which maps can contain companions

Map / _entires.fos
    → Where companions can stand on those maps
```

Once both are configured, the companion system can create, place, update, and recruit the generic companion NPCs normally.
