# Setup
alias setup='zsh ~/dotfiles/setup.sh'

# Git commands
alias gc='git commit -m'
alias gs='git status'
alias gl='git log --all --graph --decorate --oneline'
alias gp='git push -u'
git config --global push.default current

# Basic commands
alias rsrc='source ~/.zshrc'
alias dotfiles='cd ~/dotfiles'
alias e="$EDITOR"
alias vi='e'
alias vim='e'
alias ll='ls -la'

# Search
alias rg='rg -S'

source ~/dotfiles/tmux/setup.sh
alias tms='tmuxSession'
