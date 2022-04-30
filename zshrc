export ZSH=$HOME/.oh-my-zsh

# Plugins
plugins=(git)

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
source ~/.shell/aliases.sh

# Path
source ~/.shell/path.sh

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
