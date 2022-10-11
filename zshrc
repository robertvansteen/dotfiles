export ZSH=$HOME/.oh-my-zsh

# Plugins
plugins=(
git
composer
aliases
gh
httpie
laravel
postgres
)

# Brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
source ~/.shell/aliases.sh

# Path
source ~/.shell/path.sh

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
