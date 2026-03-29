#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LIST_CMD="$SCRIPT_DIR/claude-panes-list.sh"

# Catppuccin Mocha fzf colors
FZF_COLORS="bg:#1e1e2e,bg+:#313244,fg:#cdd6f4,fg+:#cdd6f4"
FZF_COLORS+=",header:#f5c2e7,hl:#89b4fa,hl+:#89b4fa"
FZF_COLORS+=",info:#cba6f7,marker:#a6e3a1,pointer:#f5e0dc"
FZF_COLORS+=",prompt:#cba6f7,spinner:#f5e0dc,border:#6c7086,label:#89b4fa"

# Check for Claude panes
pane_list=$("$LIST_CMD")
if [ -z "$pane_list" ]; then
  echo "No Claude Code sessions found."
  echo ""
  echo "Start Claude in any tmux pane with: claude"
  read -r -s -n 1
  exit 0
fi

# Pick a random port for fzf --listen
FZF_PORT=$((10000 + RANDOM % 50000))

# Background poller: reload fzf every 2 seconds
(
  sleep 2
  while true; do
    curl -s -XPOST "localhost:$FZF_PORT" -d "reload($LIST_CMD)" 2>/dev/null || exit 0
    sleep 2
  done
) &
POLLER_PID=$!
trap "kill $POLLER_PID 2>/dev/null" EXIT

# Run fzf
result=$(echo "$pane_list" | fzf \
  --listen "$FZF_PORT" \
  --ansi \
  --no-multi \
  --reverse \
  --border=rounded \
  --border-label=" Claude Sessions " \
  --border-label-pos=2 \
  --header="enter: switch | esc: cancel" \
  --header-first \
  --prompt="  " \
  --pointer="▶" \
  --margin=0 \
  --padding=1,2 \
  --with-nth=2.. \
  --delimiter='|' \
  --preview='tmux capture-pane -t {1} -p -e -S -200 2>/dev/null' \
  --preview-window='right,60%,border-left,follow' \
  --preview-label=" Preview " \
  --color="$FZF_COLORS" \
) || exit 0

# Switch to selected pane
selected=$(echo "$result" | cut -d'|' -f1)
if [ -n "$selected" ]; then
  tmux switch-client -t "$selected"
  tmux select-window -t "$selected"
  tmux select-pane -t "$selected"
fi
