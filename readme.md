# Dotfiles

Cross-platform dotfiles for macOS and Linux.

## Quick Setup

```bash
git clone git@github.com:cgjerow/dotfiles.git ~/dotfiles
cd ~/dotfiles
zsh setup.sh
```

### Flags

| Flag | Behavior |
|------|----------|
| *(none)* | General setup + recurring settings only |
| `--full` | General + recurring + one-time setup |

## What Gets Installed

### Core Packages (Homebrew)
node, nvm, tmux, fzf, bat, tldr, luajit, luarocks, neovim, gh, htop, zsh-autosuggestions, ripgrep, stylua, zoxide, entr, cloudflared, docker, yt-dlp, mkvtoolnix, jq, openjdk@11

### macOS Casks
iglance, iterm2, magnet, font-meslo-lg-nerd-font

### Work Packages (opt-in)
Set `IS_WORK=1` in `~/dotfiles/.env` before running setup:
glab, ngrok, terraform, ktlint, ktfmt, krew, grpcurl

### Zsh Plugins
zsh-autocomplete, zsh-syntax-highlighting, zsh-history-substring-search

### Neovim
kickstart.nvim (from git@github.com:cgjerow/kickstart.nvim.git)

## Configuration Files

| File | Location |
|------|----------|
| Shell | `~/dotfiles/shell/zshrc` → `~/.zshrc` |
| Profile | `~/dotfiles/shell/profile` → `~/.profile` |
| Tmux | `~/dotfiles/tmux/tmux.conf` → `~/.tmux.conf` |
| Neovim | `~/dotfiles/lua-nvim` → `~/.config/nvim` |
| SSH | `~/dotfiles/config/ssh/config` → `~/.ssh/config` |
| GitHub CLI | `~/dotfiles/config/gh/config.yml` → `~/.config/gh/config.yml` |
| htop | `~/dotfiles/config/htop/htoprc` → `~/.config/htop/htoprc` |
| iTerm2 | `~/dotfiles/iterm2/` → `~/Library/Preferences/` (pending) |

## LaunchAgents

User-level services managed via `dotfiles/launchd/`:
- **Cloudflared** (user tunnel) — `com.user.cloudflared.plist`
- **FoundryVTT** — `com.user.foundryvtt.plist`

Installed automatically by `scripts/install_launchd.sh` (plists in `config/launchd/`).

## Manual Setup Required

These items must be configured manually on a new machine:

1. **SSH private keys** — Copy `~/.ssh/id_*` files from backup
2. **GitHub auth** — Run `gh auth login` (config is symlinked, tokens are not)
3. **GCP credentials** — Copy `~/.config/gcloud/configurations/gcp-local.json` from backup
4. **iTerm2 saved passwords** — Import from Terminal.app preferences or manual entry
5. **iTerm2 font** — Set to **MesloLGLDZ Nerd Font 16** (Preferences → Profiles → Text), **n|n** → **80**
6. **Browser bookmarks** — Import from Chrome/your browser

## Directory Structure

```
dotfiles/
├── setup.sh                    # Main entry point
├── scripts/
│   ├── setup_general.sh        # Cross-platform setup
│   ├── setup_mac.sh            # macOS-only (casks + settings)
│   ├── mac_settings.sh         # Recurring defaults write
│   ├── mac_settings_one_time.sh # One-time setup (opt-in)
│   └── install_launchd.sh      # LaunchAgent installation
├── shell/
│   ├── zshrc
│   ├── profile
│   ├── scripts.sh
│   ├── work.sh
│   └── media.sh
├── tmux/
│   └── tmux.conf
├── lua-nvim/                   # Neovim config
├── config/
│   ├── ssh/config
│   ├── gh/config.yml
│   ├── htop/htoprc
│   ├── automator/
│   └── launchd/                 # LaunchAgent plists
```
