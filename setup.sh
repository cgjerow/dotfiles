#!/bin/bash
# =============================================================================
# Dotfiles Setup — Main Entry Point
# =============================================================================
# Usage:
#   ./setup.sh              → general setup + recurring settings only
#   ./setup.sh --full       → general + recurring + one-time setup
#
# One-time setup (default browser, etc.) is skipped by default.
# Run with --full to execute one-time steps.
# =============================================================================

set -e

RUN_ONE_TIME=false
for arg in "$@"; do
    if [[ "$arg" == "--full" ]]; then
        RUN_ONE_TIME=true
    fi
done

echo "=========================================="
echo "  Dotfiles Setup"
echo "=========================================="

# Cross-platform setup (Linux + macOS)
bash ~/dotfiles/scripts/setup_general.sh

# macOS-specific setup (casks + settings)
if [[ "$(uname)" == "Darwin" ]]; then
    bash ~/dotfiles/scripts/setup_mac.sh
fi

# One-time setup (opt-in)
if [[ "$(uname)" == "Darwin" ]] && [[ "$RUN_ONE_TIME" == true ]]; then
    echo ""
    echo "Running one-time macOS setup..."
    bash ~/dotfiles/scripts/mac_settings_one_time.sh
else
    echo ""
    echo "One-time macOS setup skipped. Run with --full to execute one-time steps."
fi

# Source shell config
echo ""
echo "Sourcing .zshrc..."
source ~/.zshrc

echo ""
echo "=========================================="
echo "  Done!"
echo "=========================================="
