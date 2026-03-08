export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git
    composer
    aliases
    gh
    httpie
    laravel
    postgres
    jj
)

source $ZSH/oh-my-zsh.sh

source $(brew --prefix)/opt/spaceship/spaceship.zsh
spaceship remove docker

# Pure Prompt
#autoload -U promptinit; promptinit
#if [[ $- == *i* ]]; then
#  prompt pure
#fi

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# source ~/dotfiles/shell/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# Zoxide
eval "$(zoxide init zsh)"

# GPG
export GPG_TTY=$(tty)

# Aliases
alias dx="docker compose exec"
alias dart="docker compose exec php artisan" # Run php artisan in a docker-compose environment.
alias claudew='CLAUDE_CONFIG_DIR=~/.claude-work claude'
alias claudep='CLAUDE_CONFIG_DIR=~/.claude-personal claude'
export EDITOR=nvim
export PATH="$HOME/.spin/bin:$PATH"

export SPACESHIP_PHP_SYMBOL=" "
export SPACESHIP_PHP_COLOR="blue"
export SPACESHIP_PHP_PREFIX=""
export SPACESHIP_PHP_SUFFIX=" "
export SPACESHIP_NODE_PREFIX=""
SPACESHIP_DOCKER_COMPOSE_SHOW=false

# Custom jj section for spaceship
spaceship_jj() {
  # Check if we're in a jj repo
  [[ -d .jj ]] || return
  
  # Get the shortest unique change id prefix
  local jj_change_id=$(jj log -r @ --no-graph -T 'change_id.shortest()' 2>/dev/null)
  
  if [[ -n $jj_change_id ]]; then
    spaceship::section \
      --color magenta \
      "[$jj_change_id] "
  fi
}

# Override spaceship git section
spaceship_git() {
  # Check if we're in a jj repo first
  if [[ -d .jj ]]; then
    spaceship_jj
    return
  fi
  
  # Fall back to original git behavior
  spaceship::git::branch
}

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
