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
function rsrc() {
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

source ~/dotfiles/tmux/setup.sh
function ts() {
	tmuxSession $1
}


function has-theme() {
	base16-manager list-themes | grep $THEME$1
}

function dark() {
	export BACKGROUND="dark"
	if has-theme "-dark"
	then
		base16-manager set $THEME-dark
	else
		base16-manager set $THEME
	fi
}

function light() {
	export BACKGROUND="light"
	if has-theme "-light"
	then
		base16-manager set $THEME-light
	else
		base16-manager set $THEME
	fi
}

function theme() {
	export THEME=$1 
	if $BACKGROUND = "light"
		then light
		else dark
	fi
}

function themes() {
	base16-manager list-themes | less
}
