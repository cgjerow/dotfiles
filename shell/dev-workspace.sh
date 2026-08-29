# Tmux dev workspace — split nvim + pi

# Open nvim on left, pi on right in a new tmux window
# Usage: piw [project-dir]
piw() {
  local dir="${1:-.}"
  # Resolve to absolute path
  dir="$(cd "$dir" 2>/dev/null && pwd)" || return 1

  # Start tmux if not already in a session
  if [ -z "$TMUX" ]; then
    tmux new-session -d -s dev -c "$dir"
    tmux send-keys -t "dev:0.0" "nvim" Enter
    tmux split-window -h -t "dev:0.0"
    tmux send-keys -t "dev:0.1" "pi" Enter
    tmux select-pane -t "dev:0.1"
    tmux attach -t dev
  else
    tmux new-window -n "dev" -c "$dir"
    tmux send-keys -t "dev:0.0" "nvim" Enter
    tmux split-window -h -t "dev:0.0"
    tmux send-keys -t "dev:0.1" "pi" Enter
    tmux select-pane -t "dev:0.1"
  fi
}

# Open nvim + pi in current tmux session (split right)
# Usage: dev-split <project-dir>
dev-split() {
  local dir="${1:-.}"
  dir="$(cd "$dir" 2>/dev/null && pwd)" || return 1

  tmux split-window -h -c "$dir"
  tmux send-keys -t "$TMUX_PANE" "pi" Enter
}
