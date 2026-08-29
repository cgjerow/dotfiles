# Tmux dev workspace — nvim left, pi right

piw() {
  local dir="${1:-.}"
  dir="$(cd "$dir" 2>/dev/null && pwd)" || return 1
  local session="piw"

  # Check if session exists
  tmux has-session -t "$session" 2>/dev/null
  if [ $? != 0 ]; then
    tmux new-session -d -s "$session" -c "$dir"
    tmux send-keys -t "$session:0" "nvim" Enter
    tmux split-window -h -t "$session:0"
    tmux send-keys -t "$session:0.1" "pi" Enter
    tmux select-pane -t "$session:0.1"
  fi
  tmux attach -t "$session"
}
