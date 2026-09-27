# FOClassic 7 — Armor Class Correction: 5×AG → 3×AG

## Purpose

This document records the correction made to the FOClassic 7 Armor Class (AC) calculation.

The intended normal behavior is:

> **Armor Class receives 3 × Agility (AG)** instead of 5 × Agility.

The correction was made on both the server and client sides so combat calculations and the displayed character AC use the same formula.

## 1. Original correction

The AC calculation is in:

`Server\extensions\parameters\parameters.cpp`

The normal AC calculation now contains:

```cpp
int val = cr.Params[ST_ARMOR_CLASS]
        + cr.Params[ST_ARMOR_CLASS_EXT]
        + 3 * getParam_Agility(cr, 0);
```

The important change was:

```cpp
5 * getParam_Agility(cr, 0)
```

to:

```cpp
3 * getParam_Agility(cr, 0)
```

The other parts of the calculation were left unchanged.

## 2. Full AC calculation

The relevant function is:

```cpp
int GetAC(CritterMutual& cr, bool head)
{
    int val = cr.Params[ST_ARMOR_CLASS]
            + cr.Params[ST_ARMOR_CLASS_EXT]
            + 3 * getParam_Agility(cr, 0);

    while(cr.Params[PE_LIVEWIRE])
    {
        const Item* weapon=cr.ItemSlotMain;
        if(weapon->IsWeapon() &&
           weapon->Proto->Weapon_Skill[0]!=SK_UNARMED &&
           weapon->Proto->Weapon_Skill[0]!=SK_THROWING &&
           FLAG(weapon->Proto->Flags,ITEM_FLAG_TWO_HANDS))
            break;

        weapon=cr.ItemSlotExt;
        if(weapon->IsWeapon() &&
           weapon->Proto->Weapon_Skill[0]!=SK_UNARMED &&
           weapon->Proto->Weapon_Skill[0]!=SK_THROWING &&
           FLAG(weapon->Proto->Flags,ITEM_FLAG_TWO_HANDS))
            break;

        val += 5 * getParam_Agility(cr, 0);
        break;
    }

    const Item* armor = head ? GetHeadArmor(cr) : cr.ItemSlotArmor;
    if(armor->GetId() && armor->IsArmor())
        val += armor->Proto->Armor_AC;

    return CLAMP(val, 0, 150);
}
```

### Important distinction

The normal AC contribution is now:

```cpp
3 * getParam_Agility(cr, 0)
```

The separate `PE_LIVEWIRE` bonus remains:

```cpp
val += 5 * getParam_Agility(cr, 0);
```

That special Livewire-specific bonus was **not** changed.

Therefore:

- Normal AC: **3 × AG**
- Existing Livewire-specific bonus: **+5 × AG** when its conditions apply
- Armor AC is still added
- Final AC remains clamped to 0–150

## 3. Server parameter binding

`Server\scripts\config.fos` contains:

```cpp
SetParameterGetBehaviour(ST_ARMOR_CLASS, dllName + "getParam_Ac");
```

So `ST_ARMOR_CLASS` uses the exported `getParam_Ac` function from the parameter DLL.

## 4. Why changing only the server DLL was insufficient

A client diagnostic showed:

```text
AC=0 AG=10
```

in the raw parameters received from the server.

However, the game displayed AC 50.

Therefore the displayed value was not simply the raw `Params[ST_ARMOR_CLASS]` value.

The client UI uses:

```cpp
Chosen->GetParam(ST_ARMOR_CLASS)
```

in:

`Source\ClientInterface.cpp`

The client implementation is:

`Source\CritterCl.cpp`

```cpp
int CritterCl::GetParam(uint index)
{
#ifdef FOCLASSIC_CLIENT
    if(ParamsGetScript[index] &&
       Script::PrepareContext(ParamsGetScript[index], _FUNC_, GetInfo()))
    {
        Script::SetArgObject(this);
        Script::SetArgUInt(
            index - (ParametersOffset[index] ? ParametersMin[index] : 0)
        );

        if(Script::RunPrepared())
            return Script::GetReturnedUInt();
    }
#endif

    return Params[index];
}
```

This means the client can calculate a parameter through a registered getter instead of returning the raw network value.

## 5. Parameter getter registration

The C++ bridge is:

```cpp
bool FOClient::SScriptFunc::Global_SetParameterGetBehaviour(
    uint index,
    ScriptString& func_name
)
{
    if(index >= MAX_PARAMS)
        SCRIPT_ERROR_R0("Invalid index arg.");

    CritterCl::ParamsGetScript[index] = 0;

    if(func_name.length() > 0)
    {
        int bind_id = Script::Bind(
            func_name.c_str(),
            "int %s(CritterCl&,uint)",
            false
        );

        if(bind_id <= 0)
            SCRIPT_ERROR_R0("Function not found.");

        CritterCl::ParamsGetScript[index] = bind_id;
    }

    return true;
}
```

`SetParameterGetBehaviour()` therefore connects the parameter index to the DLL function.

## 6. Client and server share the same parameter source

The key file is:

`Server\extensions\client_parameters\parameters_client.cpp`

Its contents are:

```cpp
// this is done just to have a different file name, to avoid screw-ups during concurrent compilation
#include "../parameters/parameters.cpp"
```

This means `client_parameters.dll` compiles the same `parameters.cpp` used by the normal parameters extension.

There are therefore two relevant builds:

- Server `parameters.dll`
- Client `client_parameters.dll`

Both must be rebuilt when a shared parameter calculation is changed.

## 7. DLLs involved

Runtime server DLL:

```text
Server\scripts\parameters.dll
```

Runtime client parameter DLL:

```text
Server\scripts\client_parameters.dll
```

The client-specific build is produced from:

```text
Server\extensions\client_parameters\parameters_client.cpp
```

and uses the shared:

```text
Server\extensions\parameters\parameters.cpp
```

## 8. Rebuilding only the required projects

The extension solution is:

```text
Server\extensions\extensions.sln
```

Only the individual projects need to be rebuilt.

Server parameter project:

```bat
msbuild extensions.sln /t:parameters /p:Configuration=Release /p:Platform=Win32
```

Client parameter project:

```bat
msbuild extensions.sln /t:client_parameters /p:Configuration=Release /p:Platform=Win32
```

If `msbuild` is not available directly, use the installed Visual Studio MSBuild executable.

## 9. Updating the runtime DLLs

After rebuilding the server parameter project:

```bat
copy /Y Release\parameters.dll ..\scripts\parameters.dll
```

After rebuilding the client parameter project:

```bat
copy /Y Release\client_parameters.dll ..\scripts\client_parameters.dll
```

The copies under:

```text
Server\scripts\
```

are the runtime copies used by the server setup.

## 10. Verification

Before rebuilding `client_parameters.dll`, a character with:

```text
AG = 6
```

displayed:

```text
AC = 30
```

That corresponds to the old formula:

```text
5 × 6 = 30
```

After rebuilding and installing the updated `client_parameters.dll`, the same AG value displayed:

```text
AC = 18
```

which corresponds to:

```text
3 × 6 = 18
```

This confirmed that the client-side displayed AC was also using the corrected 3×AG formula.

## 11. Final formula

For a character without armor or other applicable modifiers:

```text
AC = Base AC + AC Extended Modifier + (3 × AG)
```

Example:

```text
AG = 6
Base AC = 0
AC Extended Modifier = 0

AC = 0 + 0 + (3 × 6)
AC = 18
```

Armor and the existing special modifiers continue to be applied by the existing calculation.

## 12. Maintenance note

Because:

```cpp
#include "../parameters/parameters.cpp"
```

is used by `client_parameters`, a future change to `parameters.cpp` may require rebuilding both:

```text
parameters
client_parameters
```

and updating both runtime DLLs in:

```text
Server\scripts\
```

This prevents the server and client from using different versions of the same parameter calculation.

## Final state

**Normal Armor Class agility contribution is fixed at 3×AG.**

The server and client parameter DLLs have both been rebuilt from the corrected `parameters.cpp`.

Verified result:

```text
AG 6 → AC 18
```

This is the configuration to keep.
