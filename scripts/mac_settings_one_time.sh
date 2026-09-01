#!/bin/bash
# =============================================================================
# macOS System Settings (One-Time Setup)
# =============================================================================
# Items that only need to run once on a fresh machine.
# Guard file: ~/.dotfiles_mac_one_time_done
# Run manually if you need to re-apply: bash ~/dotfiles/scripts/mac_settings_one_time.sh --force
# =============================================================================

set -e

# Guard file path
GUARD_FILE="$HOME/.dotfiles_mac_one_time_done"

# Check for --force flag
FORCE=false
for arg in "$@"; do
    if [[ "$arg" == "--force" ]]; then
        FORCE=true
    fi
done

if [[ -f "$GUARD_FILE" ]] && [[ "$FORCE" != true ]]; then
    echo "One-time macOS settings already applied. Use --force to re-run."
    exit 0
fi

# Guard: skip if not macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Not macOS — skipping one-time macOS settings."
    exit 0
fi

echo "Applying one-time macOS system settings..."

# ---------------------------------------------------------------------------
# Default Browser
# ---------------------------------------------------------------------------
# Intentionally not automated.
# Browser choice is personal, and macOS can prompt inconsistently when changed
# from scripts. Set this manually in System Settings if desired.

echo "Skipping default browser setup (configure manually if desired)."

# ---------------------------------------------------------------------------
# Disable Startup Sound (optional, requires sudo)
# ---------------------------------------------------------------------------
# sudo nvram StartupMute=%01
# echo "Startup sound disabled."

# ---------------------------------------------------------------------------
# Reset NVRAM/PRAM (optional — unsets some settings)
# ---------------------------------------------------------------------------
# sudo nvram -c
# echo "NVRAM reset."

# ---------------------------------------------------------------------------
# Mark one-time setup as complete
# ---------------------------------------------------------------------------
touch "$GUARD_FILE"
echo "One-time macOS settings applied. Guard file: $GUARD_FILE"
echo "Re-run with --force to apply again."
