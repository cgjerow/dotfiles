#!/bin/bash
# =============================================================================
# Install LaunchAgents from dotfiles
# =============================================================================
# Copies plists from dotfiles/launchd/ to ~/Library/LaunchAgents/
# Resolves $HOME references in plist values before copying.
# Loads each plist with launchctl.
# =============================================================================

set -e

LAUNCHD_DIR="$HOME/dotfiles/config/launchd"
DEST_DIR="$HOME/Library/LaunchAgents"

if [[ ! -d "$LAUNCHD_DIR" ]]; then
    echo "ERROR: $LAUNCHD_DIR not found. Is ~/dotfiles set up?"
    exit 1
fi

mkdir -p "$DEST_DIR"

echo "Installing LaunchAgents from dotfiles..."

for plist in "$LAUNCHD_DIR"/*.plist; do
    name=$(basename "$plist")

    # Resolve $HOME references in the plist
    resolved=$(sed "s|\$HOME|$HOME|g" "$plist")

    # Write resolved plist to destination
    echo "$resolved" > "$DEST_DIR/$name"

    # Load the plist
    launchctl load "$DEST_DIR/$name"

    echo "  Installed & loaded: $name"
done

echo "LaunchAgents installation complete."
