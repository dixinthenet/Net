# === 1. WINE ===
echo "═══════════════════════════════ WINE ═══════════════════════════════"
echo "[1.1] Variables:"
echo "  XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
echo "  WINEPREFIX=$WINEPREFIX"
echo "  WINELOADER=$WINELOADER"
echo "[1.2] which wine:"
which wine
type -a wine 2>&1 | head -5
echo "[1.3] /usr/lib/wine/:"
ls /usr/lib/wine/ 2>&1
echo "[1.4] dpkg wine:"
dpkg -l | grep -i "wine\|libwine" 2>&1
echo "[1.5] dpkg arches:"
dpkg --print-foreign-architectures
echo "[1.6] wineprefix:"
[ -d "$WINEPREFIX" ] && echo "  prefix existe" || echo "  prefix NO existe"
[ -f "$WINEPREFIX/drive_c/windows/system32/ntdll.dll" ] && echo "  ✓ system32/ntdll.dll" || echo "  ✗ system32/ntdll.dll AUSENTE"
[ -f "$WINEPREFIX/drive_c/windows/syswow64/ntdll.dll" ] && echo "  ✓ syswow64/ntdll.dll (32-bit)" || echo "  ✗ syswow64/ntdll.dll AUSENTE (PEs 32-bit no funcionarán)"
echo "[1.7] wine --version:"
wine --version 2>&1
echo "[1.8] wine ejecuta cmd?:"
wine cmd /c "echo test" 2>&1 | tail -3

# === 2. PARCHES en Boaz.py ===
echo ""
echo "═══════════════════════════════ Boaz.py ═══════════════════════════════"
echo "[2.1] ¿Sigue el flag '-passes=' en Boaz.py?:"
grep -n "passes=" /boaz/Boaz.py | head -10
echo "[2.2] Cómo aparece exactamente (contexto):"
grep -n "mllvm" /boaz/Boaz.py | head -10
echo "[2.3] ¿Está _detect_mingw_dir?:"
grep -n "_detect_mingw_dir" /boaz/Boaz.py | head -5
echo "[2.4] ¿rc4_x64 reemplazado?:"
grep -n "rc4_x" /boaz/Boaz.py

# === 3. PARCHES en loaders ===
echo ""
echo "═══════════════════════════════ LOADERS ═══════════════════════════════"
echo "[3.1] Enum renombrado en loader1.c:"
grep -c "_BOAZ" /boaz/loaders/loader1.c
echo "[3.2] Enum renombrado en loader1_modified.c:"
grep -c "_BOAZ" /boaz/loaders/loader1_modified.c 2>/dev/null
echo "[3.3] Loaders presentes:"
ls /boaz/loaders/loader1*.c 2>&1 | head -10

# === 4. COMPILADORES ===
echo ""
echo "═══════════════════════════════ COMPILADORES ═══════════════════════════════"
echo "[4.1] Akira:"
ls -la /boaz/akira_built/bin/clang++ 2>&1
echo "[4.2] Pluto symlink:"
ls -la /boaz/llvm_obfuscator_pluto/bin/clang++ 2>&1
echo "[4.3] MinGW:"
ls /usr/lib/gcc/x86_64-w64-mingw32/ 2>&1
echo "[4.4] NASM:"
which nasm && nasm -v
echo "[4.5] AVCleaner:"
ls -la /boaz/build_2/avcleaner.bin /boaz/avcleaner_bin/avcleaner.bin 2>&1

# === 5. PYTHON ===
echo ""
echo "═══════════════════════════════ PYTHON ═══════════════════════════════"
echo "[5.1] Python venv:"
which python3
python3 -c "import sys; print('path:', sys.executable)"
echo "[5.2] Modulos críticos:"
python3 -c "import Crypto, macaddress, base58, base45; print('  ✓ todos OK')" 2>&1

# === 6. ARTEFACTOS ===
echo ""
echo "═══════════════════════════════ ARTEFACTOS ═══════════════════════════════"
ls /boaz/PIC/ 2>&1
echo "---"
ls /tmp/notepad.exe 2>&1 || echo "  ✗ notepad.exe ausente"
