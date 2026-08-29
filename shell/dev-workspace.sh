# Tmux dev workspace — nvim left, pi right (based on tms/tmuxSession pattern)

piw() {
  local dir="${1:-.}"
  dir="$(cd "$dir" 2>/dev/null && pwd)" || return 1
  local session="piw"

  tmux-has-session "$session"
  if [ $? != 0 ]; then
    cd "$dir"
    set -- $(stty size)
    tmux new-session -d -x "$2" -y "$(($1 - 1))" -s "$session" -n main
    tmux splitw -h
    tmux send-keys -t "$session:main" "nvim" C-m
    tmux splitw -h
    tmux send-keys -t "$session:main" "pi" C-m
    tmux selectw -t "$session:main"
  fi
  tmux a -t "$session"
}
