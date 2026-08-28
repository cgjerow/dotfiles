#!/bin/bash
# =============================================================================
# macOS System Settings (Recurring)
# =============================================================================
# Idempotent settings that can be re-run at any time.
# Called from setup.sh on every run.
# One-time-only items are in mac_settings_one_time.sh
# =============================================================================

# Guard: skip if not macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Not macOS — skipping macOS settings."
    exit 0
fi

echo "Applying macOS system settings..."

# ---------------------------------------------------------------------------
# Keyboard
# ---------------------------------------------------------------------------

# Caps Lock → Escape
defaults write -g NSUserKeyEquivalents -dict "@$\\uf700" "Escape"
defaults write com.apple.keyboard.modifiermapping.1234.5678 -int 0 2>/dev/null || true
# Alternative method (works on most systems):
# systemsetup -setkeyboard commandkey 0  # 0 = Escape (requires sudo)

# Key Repeat → Fastest (lower = faster, 2 is very fast)
defaults write -g KeyRepeat -int 2

# Initial Key Repeat → Fast (lower = faster, 15 is fast)
defaults write -g InitialKeyRepeat -int 15

# ---------------------------------------------------------------------------
# Dock
# ---------------------------------------------------------------------------

# Auto Hide
defaults write com.apple.dock autohide -bool true

# Magnification Off
defaults write com.apple.dock magnification -bool false

# Minimize Effect → Scale (cleaner than Genie)
defaults write com.apple.dock mineffect -string "scale"

# Group Windows By App
defaults write com.apple.dock "group-apps" -bool true

# Disable "Arrange by display" in Mission Control
defaults write com.apple.dock "wvous-br-corner" -int 14

# Size
defaults write com.apple.dock tilesize -int 36

# ---------------------------------------------------------------------------
# Trackpad / Mouse
# ---------------------------------------------------------------------------

# Natural Scrolling Off
defaults write -g com.apple.swipescrolldirection -bool false

# Spring Loading Off (for desktop and dock)
defaults write -g NSWindowShouldDelayNonResponderEvents -bool false
defaults write com.apple.finder DisableSpringLoads -bool true

# Pointer Acceleration Off (mouse scaling: -1 = off)
defaults write -g com.apple.mouse.scaling -float -1.0

# ---------------------------------------------------------------------------
# Finder
# ---------------------------------------------------------------------------

# Show hidden files
defaults write -g AppleShowAllFiles -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show file extensions
defaults write -g AppleShowAllExtensions -bool true

# New windows open in home directory
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# ---------------------------------------------------------------------------
# Spotlight
# ---------------------------------------------------------------------------

# Disable Spotlight indexing for specific volumes (optional)
# mdsutil disable /Volumes/ExternalDrive &

# ---------------------------------------------------------------------------
# Mission Control
# ---------------------------------------------------------------------------

# Disable "Automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

# ---------------------------------------------------------------------------
# Trackpad Settings
# ---------------------------------------------------------------------------

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Enable secondary click (two-finger click)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

# Trackpad tracking speed (-8 to 8)
defaults write -g com.apple.mouse.tracking -string "5"

# ---------------------------------------------------------------------------
# Safari (if installed)
# ---------------------------------------------------------------------------

# Show full URL in address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# ---------------------------------------------------------------------------
# Apply changes
# ---------------------------------------------------------------------------

# Kill affected apps to apply settings immediately
for app in "Dock" "Finder" "SystemUIServer" "System Events"; do
    killall "$app" 2>/dev/null || true
done

echo "macOS system settings applied."
