# Git commands
alias gc='git commit -m '

function gs() {
	git status
}

function gl() {
	git log --all --graph --decorate --oneline
}

# Basic commands
function rsrc() {
    source ~/.zshrc
}

alias regrep='grep -Er --exclude=*~ --exclude=*.snap --exclude-dir=.git --exclude-dir=node_modules'

function e() {
    $EDITOR "$@"
}

function vi() {
    nvim "$@"
}

function vim() {
    nvim "$@"
}

function l() {
	ls -Ca 
}

function ll() {
	ls -Cla | less
}

function cc() {
	g++ $1 $2
}

source ~/dotfiles/tmux/setup.sh
function ts() {
	tmuxSession $1
}
