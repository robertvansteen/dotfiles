#!/bin/zsh

# Icons (nerd font)
i_model=$'\uf2db'
i_usage=$'\uf201'
i_timer=$'\uf017'
i_dir=$'\uf07b'
i_branch=$'\ue725'
i_pr=$'\uf407'

# Parse JSON from stdin
json=$(cat)

# Model
model=$(echo "$json" | jq -r '.model.display_name // empty')
[[ -n "$model" ]] && model="$i_model $model"

# Usage % and time until reset (rate limit for the 5-hour window)
usage=$(echo "$json" | jq -r '.rate_limits.five_hour.used_percentage // empty')
resets_at=$(echo "$json" | jq -r '.rate_limits.five_hour.resets_at // empty')
if [[ -n "$usage" ]]; then
  usage="$i_usage $(printf '%.0f%%' "$usage")"
fi
reset_timer=""
if [[ -n "$resets_at" ]]; then
  now=$(date +%s)
  secs_remaining=$(( resets_at - now ))
  if (( secs_remaining > 0 )); then
    hrs=$(( secs_remaining / 3600 ))
    mins=$(( (secs_remaining % 3600) / 60 ))
    if (( hrs > 0 )); then
      reset_timer="$i_timer ${hrs}h ${mins}m"
    else
      reset_timer="$i_timer ${mins}m"
    fi
  else
    reset_timer="$i_timer resetting..."
  fi
fi

# PWD (abbreviated)
dir=$(echo "$json" | jq -r '.workspace.current_dir // empty')
dir="${dir/#$HOME/~}"
[[ -n "$dir" ]] && dir="$i_dir $dir"

# Git branch + PR
git_info=""
if git rev-parse --is-inside-work-tree &>/dev/null; then
  branch=$(git branch --show-current 2>/dev/null)
  if [[ -n "$branch" ]]; then
    cache="/tmp/.gh-pr-cache-$$-$branch"
    if [[ -f "$cache" && $(($(date +%s) - $(stat -f%m "$cache"))) -lt 300 ]]; then
      pr=$(cat "$cache")
    else
      pr=$(gh pr view "$branch" --json number --jq '.number' 2>/dev/null || echo "")
      echo "$pr" > "$cache"
    fi
    if [[ -n "$pr" ]]; then
      git_info="$i_pr PR #$pr"
    else
      git_info="$i_branch $branch"
    fi
  else
    git_info="$i_branch $(git rev-parse --short HEAD 2>/dev/null)"
  fi
fi

# Line 1: model + usage + reset timer
line1=""
for part in "$model" "$usage" "$reset_timer"; do
  [[ -n "$part" ]] && line1="${line1:+$line1 · }$part"
done

# Line 2: directory + git
line2=""
for part in "$dir" "$git_info"; do
  [[ -n "$part" ]] && line2="${line2:+$line2 · }$part"
done

echo "$line1"
[[ -n "$line2" ]] && echo "$line2"
