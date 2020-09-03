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
	ls -a
}

function ll() {
	ls -la
}
