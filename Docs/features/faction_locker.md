## Faction Lockers

### Purpose

Faction lockers restrict access based on the player's reputation with a faction. The default minimum reputation requirement is **300**.

If a player without sufficient reputation attempts to pick the locker or steal from it, the system warns the player and alerts nearby guards belonging to the configured faction, causing them to attack.

### Configuration

The locker requires a module and an initialization function.

In the Mapper, configure these fields:

| Field | Description |
|---|---|
| `ScriptName` | Name of the module handling the faction locker. |
| `FuncName` | Initialization function called for the locker. |
| `Value0` | Faction ID. |
| `Value1` | Minimum reputation required to access the locker. Default: `300`. |
| `Value2` | Dialog ID used for the warning. |
| `Value3` | Dialog string ID containing the warning text. |

### Access behaviour

1. The player interacts with the locker.
2. The system checks the player's reputation with the configured faction.
3. If the player meets the minimum reputation requirement, the locker can be accessed normally.
4. If the player attempts to pick or steal from the locker without sufficient reputation:
   - The warning message is displayed.
   - Nearby guards belonging to the configured faction are alerted.
   - Those guards attack the player.

### Example configuration

Suppose a locker belongs to a faction with ID `5`, requires `300` reputation, and uses dialog ID `200` with warning string ID `201`.

| Field | Example value |
|---|---:|
| `Value0` | `5` |
| `Value1` | `300` |
| `Value2` | `200` |
| `Value3` | `201` |

*These IDs are illustrative examples, not verified values from your project.*

---