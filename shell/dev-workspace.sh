# Tmux dev workspace — split nvim + pi

# Open nvim on left, pi on right in a new tmux window
# Usage: piw [project-dir]
piw() {
  local dir="${1:-.}"
  # Resolve to absolute path
  dir="$(cd "$dir" 2>/dev/null && pwd)" || return 1

  if [ -n "$TMUX" ]; then
    # Already in tmux: new window with nvim + pi split
    tmux new-window -n "dev" -c "$dir"
    tmux send-keys "nvim" Enter
    tmux split-window -h
    tmux send-keys "pi" Enter
    tmux select-pane -R
  else
    # Not in tmux: create session with split layout, then attach
    tmux new-session -d -s dev -c "$dir" "nvim"
    tmux split-window -h -t "dev:0"
    tmux send-keys -t "dev:0.1" "pi" Enter
    tmux attach -t dev
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
