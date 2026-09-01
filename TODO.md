# TODO: Automated Systems Audit & Migration Plan

This file tracks automated systems on this machine that are **not** accounted for by the dotfiles repo, and outlines steps to make them easily transferable to new machines.

---

## 1. Shell & Environment Configuration

### ✅ Already Covered
- `~/.zshrc` → symlinked from `dotfiles/shell/zshrc`
- `~/.tmux.conf` → symlinked from `dotfiles/tmux/tmux.conf`
- `~/.config/nvim` → symlinked from `dotfiles/lua-nvim`
- Shell aliases in `dotfiles/shell/scripts.sh`
- Theme colors in `dotfiles/shell/theme.sh`
- Prompt config in `dotfiles/shell/prompt.sh`
- Work profile in `dotfiles/shell/work.sh`
- Media tools in `dotfiles/shell/media.sh`
- Zsh plugins (zsh-autocomplete, zsh-syntax-highlighting, zsh-history-substring-search)
- Git config (push.default = current)
- NVM setup
- Zoxide setup
- SDKMAN setup (commented out in zshrc)
- Google Cloud SDK paths (hardcoded — see #5)
- SSH agent + key loading loop (hardcoded in zshrc)
- `.npmrc` → symlinked

### ⚠️ Partially Covered / Needs Attention
| Item | Current State | Fix |
|------|--------------|-----|
| **`~/.profile`** | Not in dotfiles. Contains cargo env, LM Studio CLI paths. | Add to dotfiles/shell/profile and symlink in setup.sh |
| **`~/.ssh/config`** | Not in dotfiles. Points to `~/.ssh/id_gh_primary`. | Add `dotfiles/ssh/config` and symlink. **Note:** private keys (`id_gh_primary`, `studio-1`) should **never** be in dotfiles — document that they must be imported manually. |
| **`~/.ssh/known_hosts`** | Not in dotfiles (expected). | Document that `ssh-keyscan` commands should be run on new machines. |
| **Git global user.email** | Not in setup.sh — mentioned in README only. | Add `git config --global user.name` and `user.email` to `setup.sh`. |
| **`~/.gitignore_global`** | Does not exist. | Decide if needed; if so, add to dotfiles. |
| **`~/.gitattributes`** | Does not exist. | Decide if needed; if so, add to dotfiles. |
| **`~/.inputrc`** | Does not exist. | Decide if needed; if so, add to dotfiles. |
| **`~/.curlrc`** | Does not exist. | Decide if needed; if so, add to dotfiles. |
| **Google Cloud SDK path** | Hardcoded in zshrc as `/Users/cjerow/Downloads/google-cloud-sdk/...` | Either add gcloud to `setup.sh` brew packages, or use a relative/standard install path. |

---

## 2. macOS System Settings (✅ Automated)

Automated via two scripts called from `setup.sh` on macOS:
- `dotfiles/scripts/mac_settings.sh` — recurring/idempotent (run every setup)
- `dotfiles/scripts/mac_settings_one_time.sh` — one-time setup (default browser), guarded by `~/.dotfiles_mac_one_time_done`, re-runnable with `--force`

### Keyboard
- [x] **Caps Lock → Escape** — `defaults write -g NSUserKeyEquivalents`
- [x] **Key Repeat → Fast** (value: 2) — `defaults write -g KeyRepeat -int 2`
- [x] **Initial Key Repeat → Fast** (value: 15) — `defaults write -g InitialKeyRepeat -int 15`

### Dock
- [x] **Auto Hide** — `defaults write com.apple.dock autohide -bool true`
- [x] **Magnification Off** — `defaults write com.apple.dock magnification -bool false`
- [x] **Minimize Effect → Scale** — `defaults write com.apple.dock mineffect -string "scale"`
- [x] **Group Windows By App On** — `defaults write com.apple.dock "group-apps" -bool true`
- [x] **Tile Size** — `defaults write com.apple.dock tilesize -int 36`

### Trackpad / Mouse
- [x] **Natural Scrolling Off** — `defaults write -g com.apple.swipescrolldirection -bool false`
- [x] **Spring Loading Off** — `defaults write com.apple.finder DisableSpringLoads -bool true`
- [x] **Pointer Acceleration Off** — `defaults write -g com.apple.mouse.scaling -float -1.0`
- [x] **Tap to Click** — `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true`
- [x] **Secondary Click (2-finger)** — `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true`

### Finder
- [x] **Show Hidden Files** — `defaults write -g AppleShowAllFiles -bool true`
- [x] **Show Path Bar** — `defaults write com.apple.finder ShowPathbar -bool true`
- [x] **Show Status Bar** — `defaults write com.apple.finder ShowStatusBar -bool true`
- [x] **Show File Extensions** — `defaults write -g AppleShowAllExtensions -bool true`

### Mission Control
- [x] **Disable Auto Rearrange Spaces** — `defaults write com.apple.dock mru-spaces -bool false`

### Safari
- [x] **Show Full URL** — `defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true`

---

## 3. LaunchAgents / Background Services

These are `launchd` plists running in `~/Library/LaunchAgents/` and `/Library/LaunchDaemons/`:

| Service | Plist | Currently in dotfiles? | Action Needed |
|---------|-------|----------------------|---------------|
| **Cloudflared (user tunnel)** | `com.user.cloudflared.plist` | ❌ No | Add to `dotfiles/launchd/cloudflared-user.plist`. Tunnel name "foundry" is hardcoded. Consider making tunnel name configurable. |
| **FoundryVTT** | `com.user.foundryvtt.plist` | ❌ No | Add to `dotfiles/launchd/foundryvtt.plist`. Hardcoded to Node v20.19.5 — may need version parameterization. |
| **Cloudflared** (system) | `homebrew.mxcl.cloudflared.plist` | ⚠️ Homebrew | System-level cloudflared (separate from user tunnel `com.user.cloudflared.plist`). |
| **Docker socket** | `/Library/LaunchDaemons/com.docker.socket.plist` | ⚠️ App-installed | Not dotfiles concern — installed by Docker Desktop. |
| **Docker vmnetd** | `/Library/LaunchDaemons/com.docker.vmnetd.plist` | ⚠️ App-installed | Not dotfiles concern — installed by Docker Desktop. |
| **Muutv** | `/Library/LaunchDaemons/net.mullvad.daemon.plist` | ⚠️ App-installed | Not dotfiles concern — Mullvad VPN app. |

### Recommendation
Create `dotfiles/launchd/` directory with plists for user cloudflared and FoundryVTT. Create `dotfiles/scripts/install_launchd.sh` to:
1. Copy plists to `~/Library/LaunchAgents/`
2. Resolve any hardcoded paths (e.g., Node version, working directories)
3. Run `launchctl load` for each


---

## 4. Login Items & Automator Workflows

| Item | Currently in dotfiles? | Action Needed |
|------|----------------------|---------------|
| **Magnet** (window management) | ❌ No | Document as "install via Homebrew/Cask" — `brew install --cask magnet`. No config to preserve. |
| **DDPM** | ❌ No | Unknown app — investigate and document. |
| **Notify Active NIC.workflow** | ❌ No | Automator workflow in `~/Library/Services/`. Add to dotfiles if needed. |
| **Toggle VPN.workflow** | ❌ No | Automator workflow in `~/Library/Services/`. Add to dotfiles if needed. |

---

## 5. iTerm2 Configuration

| Item | Currently in dotfiles? | Action Needed |
|------|----------------------|---------------|
| **iTerm2 preferences** (`com.googlecode.iterm2.plist`) | ❌ No | Export plist and add to `dotfiles/iterm2/`. Script should copy to `~/Library/Preferences/`. **Note:** plist is binary; use `defaults read` + `defaults write` or `plutil` to convert. |
| **iTerm2 AppSupport** (`~/.config/iterm2/AppSupport`) | ❌ No | Symlink from dotfiles if needed (profiles, bookmarks, etc.) |
| **iTerm2 sockets** | ⚠️ Runtime only | No need to persist. |

### Recommendation
Export iTerm2 preferences: `plutil -convert xml1 ~/Library/Preferences/com.googlecode.iterm2.plist -o - > dotfiles/iterm2/com.googlecode.iterm2.plist.xml`. Document that the plist should be copied back on new machines.

---

## 6. AI / LLM Tool Configurations

| Tool | Config Location | Currently in dotfiles? | Action Needed |
|------|----------------|----------------------|---------------|
| **Cursor** | `~/.cursor/` (agents, skills, extensions, plans, etc.) | ❌ No | Large directory with extensive config. Add `dotfiles/cursor/` with key configs. Exclude: `statsig-cache.json`, `debug-logs`, `sandbox-policies`. |
| **UV** (Python package manager) | `~/.local/bin/uv` | ❌ No | Add to setup.sh: `curl -LsSf https://astral.sh/uv/install.sh \| sh` |

---

## 7. Docker & Container Configurations

| Item | Currently in dotfiles? | Action Needed |
|------|----------------------|---------------|
| **Docker Desktop** | ❌ No | Add to cask list in setup.sh: `brew install --cask docker` |
| **Media Servers Compose** (`~/media-servers/docker-compose.yml`) | ❌ No | This is a project repo (has its own `.git`). Document as separate repo to clone. |
| **FI-Source Compose** (`~/fi-source/docker-compose.yml`) | ❌ No | This is a project repo (has its own `.git`). Document as separate repo to clone. |
| **Docker Images/Containers** | ❌ No | These are ephemeral/project-specific. No action needed. |

---

## 8. Application-Specific Configs (in ~/.config/)

| App | Config | Currently in dotfiles? | Priority | Action Needed |
|-----|--------|----------------------|----------|---------------|
| **GitHub CLI** | `~/.config/gh/config.yml`, `hosts.yml` | ❌ No | Medium | Add to `dotfiles/gh/`. Note: hosts.yml may contain auth tokens — exclude or document manual login via `gh auth login`. |
| **htop** | `~/.config/htop/htoprc` | ❌ No | Low | Add to `dotfiles/htop/htoprc`. |
| **qBittorrent** | `~/.config/qBittorrent/qBittorrent.ini` | ❌ No | Low | Add if torrenting is part of workflow. |
| **MusicBrainz Picard** | `~/.config/MusicBrainz/Picard.ini` | ❌ No | Low | Add if music tagging is part of workflow. |
| **Sunshine** (game streaming) | `~/.config/sunshine/` | ❌ No | Low | Add if needed. Contains credentials — handle carefully. |
| **CAgent** | `~/.config/cagent/.cagent_first_run` | ❌ No | Low | First-run flag only. No config to preserve. |

---

## 9. Homebrew / Package Manager Coverage

### ✅ Already in `setup.sh`
- **Taps:** `chrokh/tap`, `hashicorp/tap`
- **Packages:** `node`, `nvm`, `tmux`, `fzf`, `bat`, `tldr`, `luajit`, `luarocks`, `neovim`, `gh`, `htop`, `zsh-autosuggestions`, `ripgrep`, `stylua`, `zoxide`, `entr`
- **Casks:** `iglance`, `iterm2`
- **Work packages:** `glab`, `ngrok`, `terraform`, `ktlint`, `ktfmt`, `krew` (when `IS_WORK` set)
- **Global npm:** `eslint`, `tldr`
- **Global luarocks:** `luasocket`

### ❌ Missing from `setup.sh` (found on system but not installed by dotfiles)
| Package | Source | Why Missing |
|---------|--------|-------------|
| `cloudflared` | Homebrew | Should be added — used by launchd plists |
| `docker` | Cask | Should be added — used for media servers & dev |
| `mullvad-app` | Cask | VPN app — user choice, document in README |
| `magnet` | Cask | Window management — document in README |
| `uv` | pip/curl | Not a brew package — add curl installer to setup.sh |
| `cursor` | App | Not a brew package — document manual install |
| `yt-dlp` | Homebrew | Used by `dlp` alias — should be added |
| `mkvtoolnix` | Homebrew | Used by `mkvpropedit` functions — should be added |
| `grpcurl` | Homebrew | Used by work alias `lextest` — should be added |
| `glab` | Homebrew | Only in `IS_WORK` block — consider always including |
| `jq` | Homebrew | Common utility — consider adding |
| `httpie` | Homebrew | Common utility — consider adding |
| `exa` or `eza` | Homebrew | Alternative to `ls` — user preference |

---

## 10. Project Repositories (Separate from Dotfiles)

These are git repos in `~` that should be cloned during setup:

| Repo | Location | Action |
|------|----------|--------|
| `media-servers` | `~/media-servers/` | Add clone step to setup.sh |
| `fi-source` | `~/fi-source/` | Add clone step to setup.sh |
| `hl-vyos-config` | `~/hl-vyos-config/` | Add clone step to setup.sh (if needed) |
| `deepseek-harness` | `~/deepseek-harness/` | Add clone step to setup.sh (if needed) |
| `less-browser` | `~/less-browser/` | Add clone step to setup.sh (if needed) |
| `ruin` | `~/ruin/` | Add clone step to setup.sh (if needed) |
| `drchrono-web-portal` | `~/drchrono-web-portal/` | Add clone step to setup.sh (work-related) |
| `drchrono-integration` | `~/drchrono-integration/` | Add clone step to setup.sh (work-related) |

---

## 11. Priority & Implementation Plan

### Phase 1: Critical (Setup.sh Gaps)
- [x] Add missing brew packages to `setup.sh` (cloudflared, docker, yt-dlp, mkvtoolnix, jq, openjdk@11 in core; grpcurl in work; magnet in casks)
- [x] Add `git config --global user.name` and `user.email` to `setup.sh`
- [x] Add `~/.profile` to dotfiles (cargo, LM Studio paths) — symlinked from `dotfiles/shell/profile`
- [x] Add `~/.ssh/config` to dotfiles (symlinked from `dotfiles/ssh/config`) — private keys (`id_gh_primary`) must be imported manually
- [x] Add `~/.config/gh/config.yml` to dotfiles (symlinked from `dotfiles/gh/config.yml`) — `hosts.yml` with auth tokens must be excluded
- [x] Add `~/.config/htop/htoprc` to dotfiles (symlinked from `dotfiles/htop/htoprc`)
- [ ] Add uv install to setup.sh (deferred — not needed)

- [x] Remove hardcoded Google Cloud SDK path from zshrc (SDK not needed, credentials JSON is separate)

### Phase 2: macOS Settings Automation
- [x] Create `dotfiles/scripts/mac_settings.sh` (recurring, always runs)
- [x] Create `dotfiles/scripts/mac_settings_one_time.sh` (one-time, guarded + `--full` flag)
- [x] Split setup: `setup_general.sh` (cross-platform) + `setup_mac.sh` (macOS recurring)
- [x] `setup.sh` skips one-time by default, shows help message
- [ ] Export iTerm2 plist and add to dotfiles (deferred)
- [ ] Add iTerm2 plist install step to setup.sh (deferred)

### Phase 3: Launchd Services
- [x] Create `dotfiles/launchd/` with plists for cloudflared (user) and FoundryVTT — paths use `$HOME`, resolved by install script
- [x] Create `dotfiles/scripts/install_launchd.sh` — resolves $HOME, copies plists, loads with launchctl
- [x] Add launchd install step to setup.sh (via setup_mac.sh)

### Phase 4: Project Repos & Documentation
- [ ] Add project repo clone list to setup.sh (deferred)
- [x] Update README.md with complete new-machine checklist, setup flags, config table, and manual setup section
- [ ] Document which items require manual setup (SSH keys, auth tokens, etc.)

### Phase 5: Nice-to-Have
- [x] Add Automator workflows to dotfiles (Notify Active NIC, Toggle VPN) — symlinked from `dotfiles/automator/`
- [ ] Add qBittorrent, MusicBrainz, Sunshine configs (deferred)
- [ ] Consider migrating to a unified config manager (chezmoi/stow) — current symlink approach works fine for now

---

## 12. Security Notes

Items that should **NEVER** be committed to dotfiles:
- SSH private keys (`~/.ssh/id_gh_primary`, `~/.ssh/studio-1`)
- GitHub CLI auth tokens (`~/.config/gh/hosts.yml`)
- Work API keys (`~/.config/ugc-server/*.key` — referenced in work.sh)
- Sunshine credentials
- Any file with `.synclock` suffix

All such items should be documented in the README as "manual setup required" with clear instructions.