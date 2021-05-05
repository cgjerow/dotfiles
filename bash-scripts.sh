# Git commands
function gc() {
	git commit -m $1
}

function gs() {
	git status
}

function gl() {
	git log --all --graph --decorate --oneline
}

# Basic commands
function rsrc () {
    source ~/.zshrc
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

source ~/dotfiles/tmux-setup.sh
function ts() {
	tmuxSession $1
}
