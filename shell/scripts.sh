# Setup
alias setup='zsh ~/dotfiles/setup.sh'

# Git commands
alias gc='git commit -m'
alias gs='git status'
alias gl='git log --all --graph --decorate --oneline'
alias gp='git push -u'
alias gcm='git checkout master'
git config --global push.default current

# Basic commands
alias rsrc='source ~/.zshrc'
alias dotfiles='cd ~/dotfiles'
alias dot='dotfiles'
alias e="$EDITOR"
alias vi='e'
alias vim='e'
alias ll='ls -la'

# Search
alias rg='rg -.S'

alias python=python3

source ~/dotfiles/tmux/setup.sh
alias tms='tmuxSession'
