# AGENTS.md

## Dotfiles Architecture

### Entry Point
- `setup.sh` — Main entry point, thin wrapper that calls platform-specific scripts
  - No flags: general setup + recurring settings
  - `--full` flag: includes one-time setup (default browser, etc.)

### Script Organization

```
setup.sh                    # Entry point
├── scripts/setup_general.sh   # Cross-platform (Linux + macOS)
│                              #   Homebrew packages, npm, luarocks, git, symlinks
├── scripts/setup_mac.sh       # macOS-only
│                              #   Homebrew casks + LaunchAgents + defaults write
├── scripts/mac_settings.sh    # Recurring macOS settings (idempotent)
├── scripts/mac_settings_one_time.sh # One-time macOS setup (guarded by flag file)
├── config/
│   ├── ssh/config
│   ├── gh/config.yml
│   ├── htop/htoprc
│   ├── automator/
│   └── launchd/                 # LaunchAgent plists
└── scripts/
    └── install_launchd.sh      # LaunchAgent installation
```

### Key Design Decisions

1. **Separation of concerns**: General (cross-platform) vs macOS-specific
2. **Recurring vs one-time**: `mac_settings.sh` runs every setup; `mac_settings_one_time.sh` runs once (guarded by `~/.dotfiles_mac_one_time_done`, re-runnable with `--force`)
3. **`$HOME` over hardcoded paths**: All dotfiles use `$HOME` instead of `/Users/connorjerow/` for portability
4. **Symlinks, not copies**: Config files are symlinked from `dotfiles/` to `~/` for a single source of truth
5. **No secrets in dotfiles**: Private keys, auth tokens, and credentials are never committed

### Sensitive Data (Never in Git)

| Item | Location | How to restore |
|------|----------|----------------|
| SSH private keys | `~/.ssh/id_*` | Copy from backup |
| GitHub tokens | `~/.config/gh/hosts.yml` | Run `gh auth login` |
| GCP credentials | `~/.config/gcloud/configurations/gcp-local.json` | Copy from backup |
| iTerm2 passwords | Terminal.app → Preferences → Passwords | Manual entry |

### Platform Guards

All macOS-specific scripts check `uname` at the top:
```bash
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Not macOS — skipping macOS-specific setup."
    exit 0
fi
```

### Work Mode

Set `IS_WORK=1` in `~/dotfiles/.env` to install work packages (glab, ngrok, terraform, etc.).

## Current State

### Automated ✅
- All Homebrew packages (core + work)
- All macOS casks (iglance, iterm2, magnet)
- macOS system settings (keyboard, dock, trackpad, Finder, Safari)
- Symlinks (zshrc, profile, config/ssh/config, config/gh/config.yml, config/htop/htoprc, tmux, nvim)
- LaunchAgents (cloudflared, FoundryVTT, AI Trading Agent)
- zsh plugins (autocomplete, syntax-highlighting, history-substring-search)
- Neovim (kickstart.nvim)

### Pending / Deferred
- iTerm2 plist export (sensitive: saved passwords)
- Project repo clone list (needs manual review)
- chezmoi/stow migration (long-term consideration)

## Useful Links

- [Homebrew](https://brew.sh)
- [iTerm2](https://iterm2.com) — plist at `~/Library/Preferences/com.googlecode.iterm2.plist`
- [Magnet](https://magnet.cool) — window management
- [Cloudflared](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/) — tunnel config in `~/.cloudflared/`
- [FoundryVTT](https://foundryvtt.com) — installed at `~/FoundryVTT/`
- [NVM](https://github.com/nvm-sh/nvm) — Node versions at `~/.nvm/versions/`
- [Neovim Kickstart](https://github.com/nvim-lua/kickstart.nvim)

## Common Tasks

### Add a new package
1. Add to `scripts/setup_general.sh` (core) or `scripts/setup_mac.sh` (cask)
2. Add to `scripts/setup_general.sh` work block if `IS_WORK` gated
3. Update README.md "Core Packages" or "Work Packages" section

### Add a new config file
1. Create file in `dotfiles/<category>/` (e.g., `dotfiles/htop/htoprc`)
2. Use `$HOME` for any paths
3. Add symlink to `scripts/setup_general.sh` (or `setup_mac.sh` if macOS-only)
4. Update README.md config table

### Add a LaunchAgent
1. Create plist in `dotfiles/config/launchd/` with `$HOME` paths
2. Update `scripts/install_launchd.sh` (auto-discovers `*.plist`)
3. Update README.md LaunchAgents section

### Re-apply one-time settings
```bash
bash ~/dotfiles/scripts/mac_settings_one_time.sh --force
```

### Re-run full setup
```bash
zsh ~/dotfiles/setup.sh --full
```
