# Git commands
function gc() {
	read message
	git commit -m $message
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
