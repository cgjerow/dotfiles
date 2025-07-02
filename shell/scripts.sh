# Setup
alias setup='zsh ~/dotfiles/setup.sh'

# Git commands
alias gc='git commit -m'
alias gs='git status'
alias gl='git log --all --graph --decorate --oneline'
alias gp='git push -u'
alias gcm='git checkout master'

# Gitlab commands
alias glv='glab repo view --web'

# Basic commands
alias rsrc='source ~/.zshrc'
alias resource='source ~/.zshrc'
alias dotfiles='cd ~/dotfiles'
alias dot='dotfiles'
alias neovimdotfiles='cd ~/dotfiles/plugins/nvim'
alias ndot='neovimdotfiles'
alias e="$EDITOR"
alias vi='e'
alias vim='e'
alias ll='ls -la'

# Search
alias rg='rg -.S'

# zoxide - cd
alias cd=z

# Gradle
alias gradlew="./gradlew"

source ~/dotfiles/tmux/setup.sh
alias tms='tmuxSession'
alias tmi='tmuxIdea'

source ~/dotfiles/shell/work.sh
