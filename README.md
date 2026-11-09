# Intravenous 2 · macOS CrossOver (notProton) fix + playthroughRecord cheat

Everything here was originally built on **2026-10-17**, lost to a file cleanup, and **fully rebuilt on 2026-11-09** against the current Steam install of *Intravenous 2* (App 2608270). The rebuild was driven purely by the installed game files — the shaders and scripts come straight out of `intravenous2.exe` (a fused LÖVE/LuaJIT package), so this works for the current version and can be re-run after updates.

| | |
|---|---|
| Game | Intravenous 2 (Windows build) on macOS Steam |
| Runner | [notProton](https://github.com/… `-` CrossOver 26.3.0.39832 wrapped as a Steam compatibility tool; per-game prefix at `~/Library/Application Support/Steam/steamapps/compatdata/2608270/pfx` |
| Engine | LÖVE 11.5 running on **LuaJIT 2.1** (game's `lua51.dll` *is* LuaJIT) |
| Problem | Game wouldn't launch / wouldn't survive level startup under CrossOver while every other game worked |

---

## Why the game didn't work under CrossOver

Three stacked problems — fixing one exposed the next. CrossOver runs Windows GL games normal D3D via DXVK; this game's engine path hits Apple OpenGL directly, which is why only this game broke.

1. **Wrong OpenGL context flags** — `love.dll` requests an OpenGL 3.3 *core* context **without** the *forward-compatible* flag. macOS only grants 3.2+ core contexts when that flag is set: Wine's log said `OS X only supports forward-compatible 3.2+ contexts` verbatim. LÖVE quietly fell back to GL 2.1 → `"GLSL 3 shaders are not supported"`.
2. **A shader that crashes Apple's GL driver** — once a modern context existed, compiling the skin-color shader `game/shaders/actor_hueshift.lua` crashed the driver. The crash was reproduced with native macOS LÖVE (outside Wine), so it's an Apple driver bug: two shader globals initialize by calling a function (`rgb2hsv`) at global scope. The fix precomputes them as `const` colors in a save-folder shader override.
3. **Shader code only Windows drivers accept** — LÖVE's built-in GLSL3 translation header still uses `texture2D` in GLSL 3.30 code, which that version removed. NVIDIA/AMD accept it; Apple's compiler rejects it. Fix: one injected `#define texture2D texture` line inside `love.dll`.

You never saw those errors directly: after each failure LÖVE restarts itself and the restart fails with `Failed to initialize filesystem: already initialized` — that second message hid the real cause.

### The fix (`fix/iv2-crossover-fix.sh`, installed copy `fix/apply.sh`)

1. **`love.dll` binary patch, 10 bytes** — `test dl,dl; mov edx,1; cmovne esi,edx` → `movzx esi,dl; or esi,2` (adds the `FORWARD_COMPATIBLE` context flag). The original is kept as `love.dll.original`. File size unchanged.
2. **`love.dll` header patch** — one `#define texture2D texture` line injected into LÖVE's shader-preamble block (free space reclaimed by dropping leading tabs of the following lines; file size unchanged).
3. **Save-folder shader override** — `game/shaders/actor_hueshift.lua` extracted from the exe, same-length edit of its own LuaJIT bytecode constants: the two `rgb2hsv` global initializers replaced with precomputed `const vec3` values (LÖVE loads save-folder files ahead of the packed game, so the 1.1 GB exe is untouched).

Verification: the rebuilt shader override is **byte-identical** to the working copy that survived in `~/Documents/Intravenous2-save-backup-20261017-204029/`.

## The playthroughRecord cheat (`cheats/`)

The developers left a hidden launch option: `main.lua` does `if table.find(arg, "--allweaponsunlocked") then UNLOCK_WEAPONS = true; UNLOCK_WEAPON_MODS = true end` — and `playthroughRecord:getWeaponUnlocked` returns true on `UNLOCK_WEAPONS`, `weapon_mod:getIsUnlocked` on `UNLOCK_WEAPON_MODS`. The cheat sets exactly those two globals, no game files touched.

Money: every purchase goes through `playthroughRecord:hasMoney` / `changeMoney` (`buyWeapon`, `buyWeaponMod` → `buyMod`, `buyAmmoType`). The cheat is a **save-folder overlay** replacing `game/playthrough_record.lua`:

- `cheats/playthrough_record.lua` — ~40 readable lines: sets both flags, rewraps `changeMoney` (balance refills to **9,999,999** after every spend), makes `hasMoney` always pass, optionally blocks Steam achievements.
- `cheats/playthrough_record_orig.lua` — **byte-exact copy** of the game's own packed module (sha256 `a3d31fb3a6134e5e644556aafd9600efdd2ee6b29381658f4185f16c79d37bbb`), which the overlay loads and extends. Because the overlay returns that same class table, every consumer of `require("game/playthrough_record")` stays consistent.

Achievements: `achievements:attemptSetAchievement` and the whole `platformAPI` bridge (`SetAchievement`/`SetStat`/`IndicateAchievementProgress`) are neutralized while the cheat is installed, since a refilled balance would otherwise trip `MONEYLAUNDERER`/`BMA`/`KINGPIN`.

### Install (current notProton layout)
```
sh fix/iv2-crossover-fix.sh          # patches love.dll + installs shader override
# cheat files copy to:
# ~/Library/Application Support/Steam/steamapps/compatdata/2608270/pfx/
#     drive_c/users/steamuser/AppData/Roaming/intravenous2/game/
```
For the old classic CrossOver-bottle Steam layout: `sh fix/iv2-crossover-fix.sh "/path/to/CrossOver/Bottles/<bottle>"`.

### Remove/restore
- Cheat off: delete `playthrough_record.lua` **and** `playthrough_record_orig.lua` from that `game/` folder (keep `game/shaders/` — that's the CrossOver fix, not the cheat).
- CrossOver fix off: restore `love.dll.original` over `love.dll` (or let Steam verify files after an update, which does it anyway — the script rejects unexpected `love.dll` versions instead of blind-patching).
- Saves: pre-install backups live in `~/Documents/Intravenous2-save-backup-*` (2026-10-17 and 2026-11-09).

### Offline test without launching the game
```
luajit iv2_cheat_harness.lua     # loads orig bytecode + overlay in a stubbed env
# ALL CHEAT HARNESS TESTS PASSED
```

## After a game update / file verification
Re-run `sh fix/iv2-crossover-fix.sh` — it re-extracts the shader from the current exe and re-patches `love.dll`; the pattern checks refuse to patch a changed binary, so nothing breaks silently.

## Evidence & analysis (`analysis/`)

- `analysis/extracted-lua/` — all 1632 Lua modules extracted from `intravenous2.exe` (LuaJIT bytecode).
- `analysis/decompiled/` — the modules that drove the decisions, decompiled from bytecode with unluac-rs 1.4.5: `playthrough_record.lua` (`changeMoney` clamp + `MONEY_ACHIEVEMENTS`, `getWeaponUnlocked` flag), `weapon_mod.lua` (mod flag), `achievements.lua` (the platformAPI funnel), `main.lua` (arg-parsing block incl. `--allweaponsunlocked`, the `-` error handler that masks real errors), `engine_init.lua` (module loading & global `game = {}`).
- `cheats/shaders/actor_hueshift.lua` — the fixed shader script that gets installed to the save folder by the fix script.

## Ownership note
See `NOTICE.md`. Not affiliated with the game's developer; all game content (code, shaders) belongs to them. This repo documents a repair workflow for the author's own purchased copy.
