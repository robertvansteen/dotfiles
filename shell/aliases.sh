# Shortcuts
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"

alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lss="eza"
alias cat="bat"
alias cd="z"

# Reload ZSH by re-executing zsh instead of sourcing it.
# https://github.com/romkatv/powerlevel10k#weird-things-happen-after-typing-source-zshrc
alias reload="exec zsh"

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
alias vim="nvim"
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
alias stan="vendor/bin/phpstan"
alias pest="vendor/bin/pest"

# JS
alias yarn:fresh="rm -rf node_modules/ && yarn install"

# Git prune squash merged branches
alias gbsm='git checkout -q $(git_main_branch) && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base $(git_main_branch) $branch) && [[ $(git cherry $(git_main_branch) $(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)) == "-"* ]] && echo $branch; done'
alias gbdsm='gbsm | xargs git branch -d'
alias grss='git reset --soft HEAD^'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "WIP: --wip-- [skip ci]"'

 # Logitech Litra
 function _hid() {
  /usr/local/bin/hidapitester --vidpid 046D/C901 --open --length 20 --send-output $1
}
# 2/17/22 Litra Glow aliases from https://github.com/kharyam/litra-driver/issues/13
function light() {
  _hid 0x11,0xff,0x04,0x1c,0x01
}
function dark() {
  _hid 0x11,0xff,0x04,0x1c
}
# ~10%
function glow(){
  _hid 0x11,0xff,0x04,0x4c,0x00,20
}
# ~20%
function dim(){
  _hid 0x11,0xff,0x04,0x4c,0x00,50
}
# tweaking by hand - less than 50%
function normal() {
  _hid 0x11,0xff,0x04,0x4c,0x00,70
}
# ~50%
function medium() {
  _hid 0x11,0xff,0x04,0x4c,0x00,100
}
# 90%
function bright(){
  _hid 0x11,0xff,0x04,0x4c,0x00,204
}
# 2700K
function warmest() {
  _hid 0x11,0xff,0x04,0x9c,10,140
}
# 3200K
function warm() {
  _hid 0x11,0xff,0x04,0x9c,12,128
}
# 6500K
function coldest() {
  _hid 0x11,0xff,0x04,0x9c,25,100
}
