#!/bin/bash
# =============================================================================
# General Setup (Cross-Platform: Linux + macOS)
# =============================================================================
# Homebrew packages, npm, luarocks, git, symlinks, zsh plugins.
# Does NOT include macOS casks or macOS system settings.
# =============================================================================

set -e

# ---------------------------------------------------------------------------
# Prerequisites
# ---------------------------------------------------------------------------

mkdir -p ~/.config

[ -f ~/dotfiles/.env ] || touch ~/dotfiles/.env
[ -f ~/dotfiles/shell/private_profiles.sh ] || touch ~/dotfiles/shell/private_profiles.sh

source ~/dotfiles/.env

# ---------------------------------------------------------------------------
# Homebrew
# ---------------------------------------------------------------------------

echo "Homebrew setup in progress..."

which -s brew
if [[ $? != 0 ]]; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

brew-upstall() {
    if brew ls --versions "$1" > /dev/null; then
        echo "Upgrade of $1 in progress..."
        HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
    else
        echo "Install of $1 in progress..."
        HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
    fi
    echo "Upstall of $1 completed."
}

# Taps
for tap in chrokh/tap hashicorp/tap; do
    brew tap "$tap"
done

# Core packages
for package in node nvm tmux fzf bat tldr luajit luarocks neovim gh htop zsh-autosuggestions ripgrep stylua zoxide entr; do
    brew-upstall "$package"
done

# Work packages (opt-in)
if [[ -v IS_WORK ]]; then
    echo "Installing work packages..."
    for package in glab ngrok hashicorp/tap/terraform ktlint ktfmt krew; do
        brew-upstall "$package"
    done
fi

brew cleanup

# ---------------------------------------------------------------------------
# Package Managers (npm, luarocks)
# ---------------------------------------------------------------------------

echo "Installing global packages..."

npm install -g eslint
npm install -g tldr
luarocks install luasocket

# ---------------------------------------------------------------------------
# Zsh Plugins & Git
# ---------------------------------------------------------------------------

gitCloneOrPull() {
    (cd ~/dotfiles/plugins ; git clone --depth 1 -- "$1" "$2" &> /dev/null) || \
    (cd ~/dotfiles/plugins/"$2" ; git pull)
}

echo "Cloning zsh plugins and neovim config..."

gitCloneOrPull https://github.com/marlonrichert/zsh-autocomplete.git zsh-autocomplete
gitCloneOrPull https://github.com/zsh-users/zsh-syntax-highlighting.git zsh-syntax-highlighting
gitCloneOrPull https://github.com/zsh-users/zsh-history-substring-search.git zsh-history-substring-search
gitCloneOrPull https://github.com/zsh-users/zsh-history-substring-search.git zsh-history-substring-search
gitCloneOrPull git@github.com:cgjerow/kickstart.nvim.git nvim

git config --global push.default current

# ---------------------------------------------------------------------------
# Symlinks
# ---------------------------------------------------------------------------

echo "Linking dotfiles to home directory..."
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/lua-nvim ~/.config/nvim

echo "General setup complete."
