# FOnline Revival — Pip-Boy Quest Configuration Guide

This document describes the **confirmed working pattern** for exposing player quest variables in the FOnline/FOClassic Pip-Boy quest tracker.

The examples below are based on the successfully tested `quest_water_chip` and `q_shady_tandi` quests.

---

## 1. Overview

A Pip-Boy quest is built from three pieces that must agree with each other:

1. **The player variable definition** — defines the quest variable, its valid states, and enables Pip-Boy tracking.
2. **Game/dialog/script logic** — changes that variable as the player progresses through the quest.
3. **`FOQUEST.MSG` entries** — provides the Pip-Boy text corresponding to each state.

Changing `FOQUEST.MSG` alone does not progress a quest. The player's quest variable must actually be changed by dialog or script logic.

---

## 2. Quest Variable Definition

A working quest variable follows this pattern:

```text
$	VARIABLE_ID	1	VARIABLE_NAME	0	0	MAX_STATE	1
**********
   0 == inactive
   1 == active
   2 == next state
   ...
```

Example:

```text
$	7328	1	q_shady_tandi	0	0	7	1
**********
   0 == inactive
   1 == active
   2 == seth - raiders camp
   3 == found
   4 == escape
   5 == duel
   6 == quest done
   7 == quest failed
**********
```

### Important fields

For the tested quests, the important pattern is:

```text
...	0	0	MAX_STATE	1
```

`MAX_STATE` must include the highest state used by the quest.

For example, Tandi uses states `0` through `7`, so the maximum is `7`:

```text
...	0	0	7	1
```

The final `1` is important for the working Pip-Boy quest configuration. Earlier definitions ending in `0` did not behave as required; changing the tested quests to the working `... MAX_STATE 1` pattern allowed them to participate correctly in the quest system.

---

## 3. State 0 Is Inactive

Use state `0` as the state where the quest is not present in the Pip-Boy:

```text
0 == inactive
```

Do **not** create a normal progress entry for state 0.

The first visible quest state should normally be `1`.

For example:

```text
0 == inactive
1 == active
2 == objective updated
3 == quest done
4 == quest failed
```

This makes it easy to start/remove a quest by moving between `0` and a visible state.

---

## 4. FOQUEST.MSG ID Formula

`FOQUEST.MSG` calculates the message ID from the quest variable ID.

### Progress text

```text
VariableId * 1000 + State
```

For variable `7328`:

```text
State 1 -> 7328001
State 2 -> 7328002
State 3 -> 7328003
...
State 7 -> 7328007
```

### Quest title

```text
VariableId * 1000 + 101
```

For `7328`:

```text
7328101
```

### Quest information/type

```text
VariableId * 1000 + 102
```

For `7328`:

```text
7328102
```

Therefore the basic layout is:

```text
{VARIABLE_ID001}{}{State 1 text}
{VARIABLE_ID002}{}{State 2 text}
...
{VARIABLE_ID00N}{}{State N text}

{VARIABLE_ID101}{}{Location: Quest Name}
{VARIABLE_ID102}{}{QUEST:Quest Name}
```

---

## 5. Complete Working Example — Water Chip

Variable:

```text
$	7327	1	quest_water_chip	0	0	4	1
**********
   0 == inactive
   1 == active
   2 == vault 15 - explored
   3 == quest done
   4 == quest failed
```

Pip-Boy messages:

```text
#=========================================================================================================================
# 7327 / quest_water_chip
# Vault 13, Water Chip
#=========================================================================================================================
{7327001}{}{The Overseer of Vault 13 sent me out into the wasteland to find a replacement water chip before the Vault's water supply runs out.}
{7327002}{}{Vault 15 was my first lead, but after exploring its ruins I found no working water chip. I'll have to search elsewhere and find one before it's too late for Vault 13.}

{7327003}{}{HARD_COMPLETED:I found the water chip and restored the Vault 13 water treatment.
:: Quest Completed ::}

{7327004}{}{HARD_FAILED:I'm not welcome at Vault 13 anymore.

:: Quest Failed ::}

{7327101}{}{Vault 13: Find the Water Chip}
{7327102}{}{QUEST:Find the Water Chip}
```

The progression is therefore:

```text
quest_water_chip = 0  -> no Pip-Boy quest
quest_water_chip = 1  -> 7327001
quest_water_chip = 2  -> 7327002
quest_water_chip = 3  -> 7327003 (completed)
quest_water_chip = 4  -> 7327004 (failed)
```

---

## 6. Complex Working Example — Rescue Tandi

Variable:

```text
$	7328	1	q_shady_tandi	0	0	7	1
**********
   0 == inactive
   1 == active
   2 == seth - raiders camp
   3 == found
   4 == escape
   5 == duel
   6 == quest done
   7 == quest failed
**********
```

Pip-Boy messages:

```text
#=========================================================================================================================
# 7328 / q_shady_tandi                  Quest giver: Aradesh
# Shady Sands, Rescue Tandi
#=========================================================================================================================
{7328001}{}{Aradesh told me that his daughter Tandi has gone missing. He fears something has happened to her and asked me to find her and bring her safely back to Shady Sands. I should ask around the village and look for any information about where she might have been taken.}

{7328002}{}{Seth told me that Tandi was taken by raiders and gave me directions to their camp. I should travel to the raiders' camp, find Tandi, and bring her safely back to Shady Sands.}

{7328003}{}{I've found Tandi alive at the raiders' camp, but she's being held prisoner. I need to find a way to free her and get her safely out of the camp.}

{7328004}{}{Tandi wants me to help her escape without alerting the raiders. I'll have to get her out of the camp quietly and avoid drawing their attention.}

{7328005}{}{I've agreed to fight Garl for Tandi's freedom. If I can defeat him in the duel, Tandi will be released and we can return to Shady Sands.}

{7328006}{}{HARD_COMPLETED:Tandi is free and has made it safely back to Shady Sands. Aradesh's daughter has been rescued from the raiders.
:: Quest Completed ::}

{7328007}{}{SOFT_FAILED:Tandi is dead. I failed to rescue Aradesh's daughter and bring her safely back to Shady Sands.
:: Quest Failed ::}

{7328101}{}{Shady Sands: Rescue Tandi}
{7328102}{}{QUEST:Rescue Tandi}
```

This demonstrates that branching progress is fine. States 4 and 5 represent different approaches, while both can later converge on state 6.

```text
                         +--> 4 Escape --+
0 -> 1 -> 2 -> 3 -------|                +--> 6 Completed
                         +--> 5 Duel -----+
                         |
                         +--------------------> 7 Failed
```

The Pip-Boy does not need to know how the branch was reached. It simply displays the message corresponding to the player's current variable value.

---

## 7. Updating the Quest from Dialogs

Dialog logic can directly modify the player variable.

For example, starting the Water Chip quest:

```text
Demand:
    Player: Var quest_water_chip == 0

Result:
    Player: Var quest_water_chip = 1
```

After the result executes, the quest variable is `1`, so the Pip-Boy resolves message:

```text
7327 * 1000 + 1 = 7327001
```

To advance it after exploring Vault 15:

```text
Player: Var quest_water_chip = 2
```

which resolves:

```text
7327 * 1000 + 2 = 7327002
```

The same principle applies whether the value is changed by a dialog result, map script, NPC script, quest script, or another server-side mechanism.

---

## 8. Completion and Failure Keywords

`FOQUEST.MSG` supports prefixes interpreted by the Quest Tracker.

Useful ones include:

```text
DONE:
HARD_COMPLETED:
SOFT_COMPLETED:
HARD_FAILED:
SOFT_FAILED:
HIDDEN:
NO_POPUP:
ONGOING:
```

### HARD_COMPLETED

Use when the quest is permanently completed:

```text
{7328006}{}{HARD_COMPLETED:Tandi is free and has made it safely back to Shady Sands.

:: Quest Completed ::}
```

### HARD_FAILED

Use when the quest has permanently failed:

```text
{7327004}{}{HARD_FAILED:I'm not welcome at Vault 13 anymore.

:: Quest Failed ::}
```

### SOFT_FAILED

Use when the tracker should treat the state as a soft/recoverable failure according to the quest system's semantics:

```text
{7328007}{}{SOFT_FAILED:Tandi is dead...

:: Quest Failed ::}
```

Choose the keyword according to the actual quest design rather than merely the wording shown to the player.

---

## 9. Quest Type

Entry `+102` describes the quest and can contain a Quest Tracker type prefix.

Normal quest:

```text
{7328102}{}{QUEST:Rescue Tandi}
```

Main/story quest:

```text
{XXXXX102}{}{STORY:Quest Name}
```

Repeatable job:

```text
{XXXXX102}{}{JOB:Job Name}
```

For normal Fallout quests being migrated into the Pip-Boy, `QUEST:` is normally appropriate unless the quest is specifically a main story quest or repeatable job.

---

## 10. Recommended Workflow for Adding a New Quest

### Step 1 — Identify the existing variable

Example:

```cpp
#define LVAR_q_shady_tandi (7328)
```

Do not invent a different ID for `FOQUEST.MSG`. The Pip-Boy messages must be based on the same variable ID.

### Step 2 — Document every meaningful state

Before writing messages, create a state table:

```text
0 = inactive
1 = quest accepted
2 = destination discovered
3 = NPC found
4 = escape route
5 = duel route
6 = completed
7 = failed
```

Prefer a simple continuous sequence where possible.

### Step 3 — Configure the variable for the complete range

```text
$	7328	1	q_shady_tandi	0	0	7	1
```

### Step 4 — Add one FOQUEST progress entry per visible state

```text
{7328001}{}{...}
{7328002}{}{...}
{7328003}{}{...}
...
{7328007}{}{...}
```

Do not add `7328000` for the normal inactive state.

### Step 5 — Add title and quest info

```text
{7328101}{}{Shady Sands: Rescue Tandi}
{7328102}{}{QUEST:Rescue Tandi}
```

### Step 6 — Make game logic change the variable

Every meaningful quest transition must set the corresponding value.

```text
0 -> 1  quest starts
1 -> 2  Seth gives location
2 -> 3  Tandi found
3 -> 4  escape accepted
3 -> 5  duel accepted
4 -> 6  escape succeeds
5 -> 6  duel succeeds
* -> 7  Tandi dies / quest fails
```

### Step 7 — Test every state

Use a debug/admin dialog when practical to force each state individually. This is much faster than replaying the whole quest while developing the Pip-Boy integration.

Verify:

- state `0` does not display the quest;
- state `1` creates/displays the quest;
- every intermediate value shows the correct text;
- branching states display correctly;
- completed state receives the intended completion behavior;
- failed state receives the intended failure behavior;
- quest title and category are correct.

---

## 11. Debugging Checklist

If the variable changes correctly in dialogs but nothing appears in the Pip-Boy, check these in order:

1. **Variable ID** — the ID used by `FOQUEST.MSG` must be the actual quest variable ID.
2. **Variable configuration** — use the confirmed working `... 0 0 MAX_STATE 1` pattern.
3. **State range** — `MAX_STATE` must cover every state you assign.
4. **State value** — the quest must be greater than `0` to have a visible progress entry.
5. **Progress ID** — verify `VariableId * 1000 + State`.
6. **Title ID** — verify `VariableId * 1000 + 101`.
7. **Info ID** — verify `VariableId * 1000 + 102`.
8. **FOQUEST.MSG deployment** — make sure the running client is loading the modified file.
9. **Reload/restart** — reload the appropriate resources or restart the client/server when required by the current development setup.
10. **Test with a debug dialog** — force `0 -> 1 -> 2 -> ...` and verify each state independently.

A particularly useful diagnostic is to make two debug dialog options with opposite demands:

```text
Start:
    Demand: quest_var == 0
    Result: quest_var = 1

Reset:
    Demand: quest_var == 1
    Result: quest_var = 0
```

If the available dialog option changes, the variable itself is working. Any remaining problem is then in the Pip-Boy quest configuration/deployment rather than the dialog variable assignment.

---

## 12. Template for Future Quests

Copy this template when integrating another quest:

```text
# Variable definition
$	<VAR_ID>	1	<VAR_NAME>	0	0	<MAX_STATE>	1
**********
   0 == inactive
   1 == active
   2 == ...
   3 == ...
   <MAX_STATE> == completed/failed
**********
```

```text
#=========================================================================================================================
# <VAR_ID> / <VAR_NAME>                  Quest giver: <NPC>
# <Location>, <Quest Name>
#=========================================================================================================================
{<VAR_ID>001}{}{<State 1 text>}
{<VAR_ID>002}{}{<State 2 text>}
{<VAR_ID>003}{}{<State 3 text>}

{<VAR_ID>00N}{}{HARD_COMPLETED:<Completion text>

:: Quest Completed ::}

{<VAR_ID>00N>+1}{}{HARD_FAILED:<Failure text>

:: Quest Failed ::}

{<VAR_ID>101}{}{<Location>: <Quest Name>}
{<VAR_ID>102}{}{QUEST:<Quest Name>}
```

Replace the placeholders carefully; the numeric IDs must always be calculated from the actual variable ID.

---

## 13. Key Rule to Remember

The safest mental model is:

```text
PLAYER QUEST VARIABLE
        |
        | current value
        v
VariableId * 1000 + value
        |
        v
FOQUEST.MSG progress entry
        |
        v
PIP-BOY / QUEST TRACKER
```

For example:

```text
q_shady_tandi = 5

7328 * 1000 + 5
        =
     7328005
        |
        v
{7328005}{}{I've agreed to fight Garl for Tandi's freedom...}
```

If those pieces agree, the Pip-Boy can represent even relatively complex branching quests such as Rescue Tandi.

---

## Confirmed Reference Cases

At the time this guide was written, these patterns were tested successfully during the FOnline Revival work:

- `10801 / q_first_tent` — existing working reference quest.
- `7327 / quest_water_chip` — newly configured and verified in the Pip-Boy.
- `7328 / q_shady_tandi` — multi-state/branching quest successfully traversed through all configured states using the test NPC.

Use these as reference implementations when migrating additional Fallout quests to the Pip-Boy tracker.
