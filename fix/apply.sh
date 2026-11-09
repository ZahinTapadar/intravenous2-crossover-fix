#!/bin/sh
# Intravenous 2 (LÖVE 11.5) fix for CrossOver-based runners on macOS.
# Works with notProton (native Steam + ~/Library/Application Support/notproton
# runners) and with classic CrossOver bottles (pass the bottle path as arg 1).
# Usage: sh iv2-crossover-fix.sh ["path/to/crossOver/bottle"]
# Re-run after a Steam update or "Verify integrity of game files".
set -e
BOTTLE="${1:-}"
if [ -n "$BOTTLE" ]; then
	GAME="$BOTTLE/drive_c/Program Files (x86)/Steam/steamapps/common/Intravenous 2"
	SAVE="$BOTTLE/drive_c/users/crossover/AppData/Roaming/intravenous2"
else
	GAME="$HOME/Library/Application Support/Steam/steamapps/common/Intravenous 2"
	SAVE="$HOME/Library/Application Support/Steam/steamapps/compatdata/2608270/pfx/drive_c/users/steamuser/AppData/Roaming/intravenous2"
fi
[ -f "$GAME/love.dll" ] || { echo "Game not found in: $GAME"; echo "Pass your bottle path as the first argument."; exit 1; }
[ -f "$GAME/love.dll.original" ] || cp -p "$GAME/love.dll" "$GAME/love.dll.original"
mkdir -p "$SAVE/game/shaders"
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
unzip -p "$GAME/intravenous2.exe" game/shaders/actor_hueshift.lua > "$TMP/hue.lua" 2>/dev/null || true

python3 -I - "$GAME/love.dll" "$TMP/hue.lua" "$SAVE/game/shaders/actor_hueshift.lua" <<'PY'
import struct, sys
dll, hue_in, hue_out = sys.argv[1:4]

# 1) love.dll: request a forward-compatible GL 3.3 core context (macOS refuses non-FC core contexts)
b = bytearray(open(dll, 'rb').read())
pe = struct.unpack_from('<I', b, 0x3c)[0]; n = struct.unpack_from('<H', b, pe+6)[0]
optsz = struct.unpack_from('<H', b, pe+20)[0]; opt = pe+24; base = struct.unpack_from('<Q', b, opt+24)[0]
secs = [struct.unpack_from('<8sIIII', b, opt+optsz+40*i) for i in range(n)]
rva = 0x1800f8243 - base
off = next(rva-va+rp for _, vs, va, rs, rp in secs if va <= rva < va+vs)
old = bytes.fromhex('84d2ba010000000f45f2')  # test dl,dl; mov edx,1; cmovne esi,edx
new = bytes.fromhex('0fb6f283ce0290909090')  # movzx esi,dl; or esi,2 (FORWARD_COMPATIBLE); nops
cur = bytes(b[off:off+10])
if cur == old: b[off:off+10] = new; print('[1/3] GL context patch applied')
elif cur == new: print('[1/3] GL context patch already applied')
else: sys.exit('Unexpected love.dll version - nothing changed.')

# 2) love.dll: alias texture2D -> texture in GLSL3 shaders (Apple's compiler is strict)
anchor = b'#if __VERSION__ >= 130 && !defined(LOVE_GLSL1_ON_GLSL3)\n\t#define Texel texture\n'
ins = b'#define texture2D texture\n'
if anchor+ins in b: print('[2/3] GLSL3 header patch already applied')
else:
    assert b.count(anchor) == 1, 'GLSL header not found'
    i = b.find(anchor)+len(anchor); end = b.find(b'#endif\n#endif', i)
    need = len(ins); out = []
    for l in bytes(b[i:end]).split(b'\n'):  # free space by dropping leading tabs
        s = l.lstrip(b'\t'); t = min(len(l)-len(s), need); need -= t; out.append(l[t:])
    assert need == 0
    b[i:end] = ins + b'\n'.join(out); print('[2/3] GLSL3 header patch applied')
open(dll, 'wb').write(b)

# 3) actor_hueshift shader: replace non-const globals that crash Apple's GL driver
#    (same-length edit of the game's own bytecode, installed as a save-folder override)
h = open(hue_in, 'rb').read()
if not h: sys.exit('Could not extract actor_hueshift.lua from intravenous2.exe')
reps = [(b'vec3 skinColor = rgb2hsv(vec3(196.0 / 255.0, 158.0 / 255.0, 115.0 / 255.0));',
         b'const vec3 skinColor = vec3(0.0884774, 0.4132653, 0.7686275);'),
        (b'vec3 skinColorDark = rgb2hsv(vec3(97.0 / 255.0, 44.0 / 255.0, 68.0 / 255.0));',
         b'const vec3 skinColorDark = vec3(0.9245283, 0.5463918, 0.3803922);')]
for a, r in reps:
    assert h.count(a) == 1, 'Shader text not found (game updated?)'
    h = h.replace(a, r.ljust(len(a)))
open(hue_out, 'wb').write(h); print('[3/3] Shader override installed')
PY
echo "Done. Launch Intravenous 2 from Steam."
