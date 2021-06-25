tmux-has-session () 
{
	tmux has-session -t $session 2>/dev/null
}

tmuxSession () 
{
	session=$1
	tmux-has-session $session
	if [ $? != 0 ]
	then
		cd
        set -- $(stty size) # $1 = rows $2 = columns
		tmux new-session -d -x "$2" -y "$(($1 - 1))" -s $session -n main 
		tmux selectw -t $session:main
		tmux splitw -v -p 30
		tmux selectp -t 1
		tmux splitw -h
	
		tmux new-window -n stats
		tmux send-keys htop C-m

		tmux selectw -t $session:main
        tmux selectp -t 1
		tmux selectp -t 0
	fi
	tmux a -t $session
}
