# Shortcuts
alias reload="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias l="ls -l ${colorflag}" # List all files colorized in long format
alias la="ls -la ${colorflag}" # List all files colorized in long format, including dot files
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'" # List only directories

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, yarn, and their installed packages
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; brew upgrade yarn; yarn global upgrade";

# Navigation
alias ..="cd .."
alias ...="cd ../.."

# Explain (v) what was done when moving a file
alias mv='mv -v'

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Applications 
alias preview="open -a '$PREVIEW'"
alias safari="open -a safari"
alias firefox="open -a firefox"
alias chrome="open -a google\ chrome"
alias f='open -a Finder'

# Laravel
alias art="php artisan"
alias fresh="php artisan migrate:fresh --seed"
alias seed="php artisan db:seed"

# PHP
alias cfresh="rm -rf vendor/ composer.lock && composer i"

# JS
alias yarn:fresh="rm -rf node_modules/ && yarn install"
