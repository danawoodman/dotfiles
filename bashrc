#!/bin/bash

#-------------------------------------------------------------------------------
# Imports
#-------------------------------------------------------------------------------

# Import git bash completion
if [ -f $HOME/.git-completion.bash ]; then
  source $HOME/.git-completion.bash
fi

# NVM bash completion.
source ~/.nvm/nvm.sh
[[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion

# load avn
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh"

# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done

# Setup bash-completions
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi


#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------

# Some content borrow from Paul Irish's .aliases file <https://github.com/paulirish/dotfiles/blob/master/.aliases>


# Log output:
#
# * 51c333e    (12 days)    <Gary Bernhardt>   add vim-eunuch
#
# The time massaging regexes start with ^[^<]* because that ensures that they
# only operate before the first "<". That "<" will be the beginning of the
# author name, ensuring that we don't destroy anything in the commit message
# that looks like time.
#
# The log format uses } characters between each field, and `column` is later
# used to split on them. A } in the commit subject or any other field will
# break this.

HASH="%C(yellow)%h%C(reset)"
RELATIVE_TIME="%C(green)(%ar)%C(reset)"
AUTHOR="%C(bold blue)%an%C(reset)"
REFS="%C(red)%d%C(reset)"
SUBJECT="%s%C(reset)"

FORMAT="$HASH{$RELATIVE_TIME{$AUTHOR{$REFS $SUBJECT"

ANSI_BLACK='\033[30m'
ANSI_BLACK_BOLD='\033[0;30;1m'
ANSI_RED='\033[31m'
ANSI_RED_BOLD='\033[0;31;1m'
ANSI_GREEN='\033[32m'
ANSI_GREEN_BOLD='\033[0;32;1m'
ANSI_YELLOW='\033[33m'
ANSI_YELLOW_BOLD='\033[0;33;1m'
ANSI_BLUE='\033[34m'
ANSI_BLUE_BOLD='\033[0;34;1m'
ANSI_MAGENTA='\033[35m'
ANSI_MAGENTA_BOLD='\033[0;35;1m'
ANSI_CYAN='\033[36m'
ANSI_CYAN_BOLD='\033[0;36;1m'
ANSI_WHITE='\033[37m'
ANSI_WHITE_BOLD='\033[0;37;1m'
ANSI_RESET='\033[0m'


# function show_git_head() {
#   pretty_git_log -1
#   git show -p --pretty="tformat:"
# }

function pretty_git_log() {
  git log --pretty="tformat:$FORMAT" --graph $* |
      # Replace (2 years ago) with (2 years)
      sed -Ee 's/(^[^<]*) ago\)/\1)/' |
      # Replace (2 years, 5 months) with (2 years)
      sed -Ee 's/(^[^<]*), [[:digit:]]+ .*months?\)/\1)/' |
      # Line columns up based on } delimiter
      column -t -s '{' |
      # Remove parens from around the timestamp.
      tr -d '()' |
      # Color merge commits specially
      sed -Ee "s/(Merge branch .* into .*$)/$(printf $ANSI_RED)\1$(printf $ANSI_RESET)/" |
      # Page only if we need to
      less -FXRS
}

# GIT aliases.
alias g='git'
alias gh='git help'
alias ga='git add'
alias gp='git push'
#alias gl='git log --oneline --graph --decorate'
alias gl=pretty_git_log
alias gls="gl -10"
alias gla='gl --graph --decorate'
alias gs='git status -sb'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -am'
alias gb='git branch'
alias gco='git checkout'
alias gcob='git branch | cut -c 3- | selecta | xargs git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias grst='git reset'
alias gpl='git pull'
alias gcl='git clone'
alias gm='git merge'
alias gmv='git mv'
alias grm='git rm'
alias gst='git stash'
alias gf='git fetch'
alias gbt='git checkout -t -b'
alias grp='git rev-parse'
alias grb='git rebase'
alias gsh='git show'
alias gcp='git cherry-pick'
alias gsub='git submodule'
alias gsvn='git svn'

# Create aliases for listing of files.
alias ll="ls -GFlha"
alias la="ls -Gpha"
alias lsd='ls -Glh | grep "^d"'

# Kill processes easier

alias ka='killall -kill'

# Easier navigation
alias cl='clear'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -" # return to last directory
alias ..-="cd .. && cd -" # backup and return to dir (good for reloading rvmrc file)

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Flush OSX DNS cache
alias flush="dscacheutil -flushcache && sudo killall -HUP mDNSResponder && echo  'Flushed DNS cache.'"

# Functions
function md() {
  mkdir -p "$@" && cd "$@"
}

function proj() {
    cd $(find ~/code -maxdepth 1 -type d | selecta)
}


#-------------------------------------------------------------------------------
# Bash prompt
#-------------------------------------------------------------------------------

# @gf3’s Sexy Bash Prompt, inspired by “Extravagant Zsh Prompt”
# Shamelessly copied from https://github.com/gf3/dotfiles

default_username='dana'

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
        export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
        export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    PURPLE=$(tput setaf 5)
    LIGHT_BLUE=$(tput setaf 6)
    ORANGE=$(tput setaf 9)
    GRAY=$(tput setaf 8)
    WHITE=$(tput setaf 256)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  MAGENTA="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[32m"
  GREEN_LIGHT="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  BOLD=""
  RESET="\033[m"
fi


# Get the ahead/behind status of the branch, if available (e.g. [ahead 3, behind 5])
function parse_git_sync_status {
  git status -sb | # Get the status message that contains the ahead/behind count
    head -n1 | # Get the first line of the message
    grep -o '\[.*\]' | # Get just the ahead/behind count
    sed -E "s/ahead ([0-9]+)/ahead $(printf $GREEN)\1$(printf $RESET)/" | # Highlight the ahead count
    sed -E "s/behind ([0-9]+)/behind $(printf $RED)\1$(printf $RESET)/" # Highlight the behind count
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

function parse_git_branch {
  git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||'
}

function git_info {
  # Check if we're in a git repo
  git rev-parse --is-inside-work-tree &>/dev/null || return

  # Quickest check for what branch we're on
  branch=$(parse_git_branch)

  # Check if it's dirty (via github.com/sindresorhus/pure)
  dirty=$(parse_git_dirty)

  # Get the sync status of the repo (how far ahead/behind we are from remote):
  status=$(parse_git_sync_status)

  echo ${GRAY}" on "${RESET}${PURPLE}$branch$dirty" "${RESET}$status${RESET}
}

# Only show username/host if not default
function usernamehost {
  if [ $USER != $default_username ]; then echo "${RED}$USER ${RESET}at ${ORANGE}$HOSTNAME ${RESET}in "; fi
}

# Display a stylized command line prompt:
PS1="${ORANGE}\@: \[\e]2;$PWD\[\a\]\[\e]1;\]$(basename "$(dirname "$PWD")")/\W\[\a\]${BOLD}\$(usernamehost)\[${GREEN}\]\w\$(git_info)\[${RESET}\]\n\$ "


#-------------------------------------------------------------------------------
# Shell settings
#-------------------------------------------------------------------------------

# Make vim as the default editor.
export EDITOR="nvim"

# Update bash scroll buffer
export HISTSIZE=10000

# Homebrew and others...
export PATH="/usr/local/bin:$PATH"

# Tell Homebrew Cask to symlink apps in the root directory
# instead of ~/Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Add user bins to path
export PATH="$HOME/.bin:$HOME/bin:$PATH"

# Golang
export GOPATH="$HOME/code/go"
export PATH="$GOPATH:$GOPATH/bin:$PATH"

# Add sbin binaries.
export PATH="/usr/local/sbin:$PATH"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Virtualenv
export WORKON_HOME=~/code/virtualenvs
