# Adding Custom Critters to FOClassic 7 (Server, Client & Mapper)

## 1. Extract & Place the Sprite Files (`.frm`)
1. **Extract from Fallout 1/2:** Use a DAT explorer (such as *DAT2 Explorer*) to extract all `.frm` / `.fr0` animation files matching your critter's 6-character prefix (e.g., `NMOVER*.FRM` for the Vault 13 Overseer) from `critter.dat` under `art\critters\`.
2. **Place in Client Data:** Copy all extracted `.frm` files into:
   ```text
   Client\data\art\critters\
   ```
   > **Note:** If your client packs critters into a `.zip` archive (such as `Client\data\new_critters.zip`), make sure no conflicting or broken files with the same prefix override your loose files.

---

## 2. Register the Critter Type in `CritterTypes.cfg`
FOClassic 7 maps numeric **`CrType` IDs** to 6-letter `.frm` prefixes using `CritterTypes.cfg`.

1. **Choose an unused ID:** Open `Server\data\CritterTypes.cfg` and find the next free ID after the standard human entries (e.g., `167`).
2. **Add the critter definition line:** Copy an existing entry with similar capabilities (for NPCs without run or weapon animations, disable `Run` and `Armor`):
   ```ini
   #          Name    Alias MH  3d  Walk  Run  Aim Armor Rotate  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z   Walk  Run   Walk steps Sound name
   @  167    nmover     11   0   0    0    0    1    1    0      1 1 1 0 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0      0    0   0  0  0  0    -
   ```
   * **`@`** activates the row so the engine loads it.
   * **`11` (Alias)** assigns standard human Aimed Shot body zones.
   * **`Walk` / `Run` / `Armor`** flags prevent the engine from looking for missing `.frm` animations.
3. **Sync all copies of `CritterTypes.cfg`:** Server, Client, and Mapper each read from their own `data\` folder. Always copy the updated `CritterTypes.cfg` to **all three locations**:
   * `Server\data\CritterTypes.cfg`
   * `Client\data\CritterTypes.cfg`
   * `Mapper\data\CritterTypes.cfg`

   **PowerShell Sync One-Liner:**
   ```powershell
   $src = ".\foclassic7\Server\data\CritterTypes.cfg"
   Copy-Item $src ".\Client\data\CritterTypes.cfg" -Force
   Copy-Item $src ".\Mapper\data\CritterTypes.cfg" -Force
   ```

---

## 3. Create the Critter Prototype (`.fopro`)
1. **Open your target `.fopro` file** inside `Server\proto\critters\` (e.g., `mob_dynamic.fopro`, which must be listed in `Server\proto\critters\proto.lst`).
2. **Add a new `[Critter proto]` entry** with a unique `Pid` and set both `ST_BASE_CRTYPE` and `ST_OVERRIDE_CRTYPE` to your new `CrType` ID (`167`):
   ```ini
   [Critter proto]
   Pid=1913
   ST_BASE_CRTYPE=167
   ST_OVERRIDE_CRTYPE=167
   ST_STRENGTH=5
   ST_PERCEPTION=5
   ST_ENDURANCE=5
   ST_CHARISMA=5
   ST_INTELLECT=5
   ST_AGILITY=5
   ST_LUCK=5
   ST_BODY_TYPE=0
   ST_DAMAGE_TYPE=1
   ST_GENDER=0
   ST_AGE=55
   ST_AI_ID=13
   MODE_NO_RUN=1
   MODE_NO_BARTER=1
   ```
   > **GUI Tool Tip:** If using *FOnline: Reloaded Critter Proto Editor*, click the green **`SAVE`** button at the bottom-right first to commit the row in memory, then click **`Save`** on the top-left toolbar to write changes to disk.
3. **Optional — Add Display Name:** Add the critter's name to `Server\text\engl\FOCRITTERS.MSG` (and `Client\text\engl\FOCRITTERS.MSG`) using `{Pid * 10}{}{Name}`:
   ```text
   {19130}{}{Vault Overseer}
   ```

---

## 4. Register the CrType in `mapper_crtypes.fos` (Prevent Auto-Reset)
In Reloaded/2238-based mappers, `Mapper\scripts\mapper_crtypes.fos` runs a background loop (`NormalizeCrtype`) that forces unarmored human critters (`BT_MEN` / `BT_WOMEN`) back to default base types unless their `CrType` ID is whitelisted.

1. Open **`Mapper\scripts\mapper_crtypes.fos`**.
2. Add your new `CrType` ID to `SetUnarmoredCrtypes()`:
   ```cpp
   void SetUnarmoredCrtypes()
   {
       UnarmoredTypesMale.insertLast(62);
       UnarmoredTypesMale.insertLast(64);
       UnarmoredTypesMale.insertLast(110);
       UnarmoredTypesMale.insertLast(104);
       UnarmoredTypesMale.insertLast(126);
       UnarmoredTypesMale.insertLast(119);
       UnarmoredTypesMale.insertLast(167); // Custom CrType ID
       UnarmoredTypesFemale.insertLast(61);
       UnarmoredTypesFemale.insertLast(63);
   }
   ```

---

## 5. Add the PID to Mapper's `tabs.cfg`
Because `Mapper\scripts\mapper_main.fos` clears default critter tabs and loads sub-tabs from `tabs.cfg`, new PIDs will not appear in the spawn bar until registered there.

1. Open **`Mapper\tabs.cfg`**.
2. Append your new `Pid` (`1913`) to an existing critter sub-tab's `Crits=` line, or create a new sub-tab under `MainTab=9` (`Humn`) or `MainTab=12` (`Othr`):
   ```ini
   [SubTab]
   MainTab=9
   Name=026 - overseer
   Crits=1913
   ```

---

## 6. Verification & Troubleshooting Checklist
When launching **`Mapper.exe`**, inspect **`Mapper\Mapper.log`** if the critter fails to appear:

* **`Load critters types... loaded<X>`:** Confirm this count increased by `1` after editing `CritterTypes.cfg`. If it did not increase, `Mapper\data\CritterTypes.cfg` is out of sync or missing the `@` prefix.
* **`Load critters prototypes... loaded<Y>`:** Confirm this count increased by `1` after editing `.fopro`. If not, verify the `.fopro` filename is listed in `proto.lst` and saved to disk.
* **Placing in Mapper:** Ensure **`Select`** (top-right of the bottom control bar) is toggled **OFF** (Draw/Add mode) and **`Critters`** under **`Show:`** (left side) is toggled **ON**.
