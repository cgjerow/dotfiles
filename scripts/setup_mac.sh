#!/bin/bash
# =============================================================================
# macOS-Specific Setup (Recurring)
# =============================================================================
# Homebrew Casks and recurring macOS system settings.
# One-time setup is handled by setup.sh --full (see mac_settings_one_time.sh).
# Skips entirely if not on macOS.
# =============================================================================

set -e

# Guard: skip if not macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Not macOS — skipping macOS-specific setup."
    exit 0
fi

echo "=== macOS-specific setup ==="

# ---------------------------------------------------------------------------
# Homebrew Casks
# ---------------------------------------------------------------------------

cask-upstall() {
    if brew upgrade --cask "$1" > /dev/null; then
        echo "$1 already installed"
    else
        echo "Install of $1 in progress..."
        brew install --cask "$1" "$2"
    fi
    echo "Upstall of $1 completed."
}

echo "Installing macOS casks..."

for cask in iglance iterm2 magnet font-meslo-lg-nerd-font; do
    cask-upstall "$cask" --cask
done

# ---------------------------------------------------------------------------
# Automator Workflows
# ---------------------------------------------------------------------------

mkdir -p ~/Library/Services
ln -sf ~/dotfiles/config/automator/Notify\ Active\ NIC.workflow ~/Library/Services/Notify\ Active\ NIC.workflow
ln -sf ~/dotfiles/config/automator/Toggle\ VPN.workflow ~/Library/Services/Toggle\ VPN.workflow

# ---------------------------------------------------------------------------
# LaunchAgents
# ---------------------------------------------------------------------------

if [[ -f ~/dotfiles/scripts/install_launchd.sh ]]; then
    bash ~/dotfiles/scripts/install_launchd.sh
fi

# ---------------------------------------------------------------------------
# Recurring macOS Settings (defaults write)
# ---------------------------------------------------------------------------

if [[ -f ~/dotfiles/scripts/mac_settings.sh ]]; then
    bash ~/dotfiles/scripts/mac_settings.sh
fi

echo "=== macOS-specific setup complete ==="
