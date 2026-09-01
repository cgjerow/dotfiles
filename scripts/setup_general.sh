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

[ -f ~/.env ] || touch ~/.env
[ -f ~/dotfiles/shell/private_profiles.sh ] || touch ~/dotfiles/shell/private_profiles.sh

source ~/.env

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
#for package in node nvm tmux fzf bat tldr luajit luarocks neovim gh htop zsh-autosuggestions ripgrep stylua zoxide entr cloudflared docker yt-dlp mkvtoolnix jq openjdk@11; do
    # brew-upstall "$package"
#done

# Work packages (opt-in)
if [[ "${IS_WORK:-0}" == "1" ]]; then
    echo "Installing work packages..."
    #for package in glab ngrok hashicorp/tap/terraform ktlint ktfmt krew grpcurl; do
        # brew-upstall "$package"
    #done
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

git config --global user.name "cgjerow"
git config --global user.email "cgjerow@gmail.com"
git config --global push.default current

# ---------------------------------------------------------------------------
# Symlinks
# ---------------------------------------------------------------------------

echo "Linking dotfiles to home directory..."

link_file() {
    local source_path="$1"
    local target_path="$2"
    mkdir -p "$(dirname "$target_path")"
    ln -sf "$source_path" "$target_path"
}

link_file ~/dotfiles/shell/zshrc ~/.zshrc
link_file ~/dotfiles/shell/profile ~/.profile
link_file ~/dotfiles/config/ssh/config ~/.ssh/config
link_file ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
link_file ~/dotfiles/lua-nvim ~/.config/nvim
link_file ~/dotfiles/config/gh/config.yml ~/.config/gh/config.yml
link_file ~/dotfiles/config/htop/htoprc ~/.config/htop/htoprc

echo "General setup complete."
