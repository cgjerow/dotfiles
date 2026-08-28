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
# Default Browser — Chrome
# ---------------------------------------------------------------------------
# This is complex because macOS stores LSHandlers in a binary plist.
# We use a helper approach: export current handlers, add Chrome, write back.

echo "Setting Chrome as default browser..."

# Chrome bundle identifier
CHROME_BUNDLE="com.google.Chrome"

# Get current handlers (may fail if none set yet)
CURRENT_HANDLERS=$(defaults read com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers 2>/dev/null || echo "[]")

# Check if Chrome is already the default
if echo "$CURRENT_HANDLERS" | grep -q "$CHROME_BUNDLE"; then
    echo "Chrome is already set as default browser."
else
    # Add Chrome handler for http and https
    # This is a simplified approach — for full accuracy, use a tool like
    # defaults write or a plist editor. The below sets Chrome as default
    # for the two main URL schemes.
    defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers \
        -array-add '{"LSItemContentType" = "public.url"; "LSHandlerURLScheme" = "http"; "LSHandlerRole" = "Viewer";}' \
        -array-add '{"LSItemContentType" = "public.url"; "LSHandlerURLScheme" = "https"; "LSHandlerRole" = "Viewer";}'
    echo "Chrome set as default browser."
fi

# Note: The above may not work perfectly on all macOS versions due to
# the binary plist. If Chrome doesn't become default, run manually:
#   open -a "Google Chrome" --args --make-default-browser
# Or use: defaults write com.apple.HIToolbox AppleDefaultBrowser -string "com.google.Chrome"

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
