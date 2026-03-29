#!/usr/bin/env bash
set -euo pipefail

STATUS_DIR="/tmp/claude-panes"

# Status colors (ANSI)
RED='\033[38;2;243;139;168m'
YELLOW='\033[38;2;249;226;175m'
GREEN='\033[38;2;166;227;161m'
GRAY='\033[38;2;108;112;134m'
DIM='\033[2m'
RESET='\033[0m'

check_pane_working() {
  local target="$1"
  local content
  content=$(tmux capture-pane -t "$target" -p -S -15 2>/dev/null) || true
  echo "$content" | grep -qE '….*\([0-9]+[smh]'
}

read_status() {
  local pane_id="$1"
  local target="$2"
  local status_file="$STATUS_DIR/$pane_id"
  local status="unknown"
  if [ -f "$status_file" ]; then
    status=$(cat "$status_file")
  fi
  if [ "$status" = "waiting" ] && check_pane_working "$target"; then
    status="working"
  fi
  echo "$status"
}

format_path() {
  echo "${1/#$HOME/~}"
}

pane_list=""
while IFS='|' read -r target session window_name pane_title pane_path pane_cmd pane_id; do
  if [[ "$pane_cmd" =~ ^[0-9]+\.[0-9]+\.[0-9]+ ]]; then
    status=$(read_status "$pane_id" "$target")
    short_path=$(format_path "$pane_path")

    case "$status" in
      waiting) icon="${RED}●${RESET}"; sort_key=1 ;;
      idle)    icon="${GREEN}●${RESET}"; sort_key=2 ;;
      working) icon="${YELLOW}●${RESET}"; sort_key=3 ;;
      *)       icon="${GRAY}●${RESET}"; sort_key=4 ;;
    esac

    line="${sort_key}|${target}|$(printf "${icon}  ${session} / ${window_name}  ${DIM}${short_path}${RESET}")"
    if [ -n "$pane_list" ]; then
      pane_list="${pane_list}\n${line}"
    else
      pane_list="${line}"
    fi
  fi
done < <(tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index}|#{session_name}|#{window_name}|#{pane_title}|#{pane_current_path}|#{pane_current_command}|#{pane_id}')

if [ -n "$pane_list" ]; then
  printf "%b\n" "$pane_list" | sort -t'|' -k1,1n | cut -d'|' -f2-
fi
