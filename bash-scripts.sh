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
function l() {
	ls -Ca | less -F
}

function ll() {
	ls -Cla | less -F
}

function cc() {
	g++ $1 $2
}

source ~/dotfiles/tmux-setup.sh
function ts() {
	tmuxSession $1
}
