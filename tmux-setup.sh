tmux-has-session () {
	tmux has-session -t $session 2>/dev/null
}

tmuxSession () {
	session=$1
	tmux-has-session $session
	if [ $? != 0 ]
	then
		cd
		tmux new-session -d -s $session -n main 
		tmux selectw $session:main
		tmux splitw -v -p 10
		tmux selectp -t 0
		tmux splitw -h
		tmux selectp -t 0
	fi
	tmux a -t $session
}
