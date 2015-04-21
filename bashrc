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

# For Ruby rvm...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done


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

# Easier navigation
alias cl='clear'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -" # return to last directory
alias ..-="cd .. && cd -" # backup and return to dir (good for reloading rvmrc file)

# Programs
alias st='open -a "Sublime Text"'

# `cat` with beautiful colors. requires Pygments installed (sudo easy_install Pygments)
alias c='pygmentize -O style=monokai -f console256 -g'

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Pretty print JSON output from things like curl 
alias json='python -m json.tool'

# Shorthand SASS.
alias sassy="sass -t compressed --watch ."

# Flush OSX DNS cache
alias flush="dscacheutil -flushcache && sudo killall -HUP mDNSResponder && echo  'Flushed DNS cache.'"

# Clean up Aventail stuck process
alias aventail-clean="rm ~/Library/Application\ Support/Aventail/run/SEM.*"

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
                MAGENTA=$(tput setaf 9)
                ORANGE=$(tput setaf 172)
                GREEN=$(tput setaf 190)
                PURPLE=$(tput setaf 141)
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
        GREEN="\033[1;32m"
        PURPLE="\033[1;35m"
        WHITE="\033[1;37m"
        BOLD=""
        RESET="\033[m"
fi


function git_info() {
        # check if we're in a git repo
        git rev-parse --is-inside-work-tree &>/dev/null || return

        # quickest check for what branch we're on
        branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')

        # check if it's dirty (via github.com/sindresorhus/pure)
        dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ]&& echo -e "*")

        echo $RESET" on "$PURPLE$branch$dirty
}

# Only show username/host if not default
function usernamehost() {
        if [ $USER != $default_username ]; then echo "${MAGENTA}$USER ${RESET}at ${ORANGE}$HOSTNAME $WHITEin "; fi
}

# iTerm Tab and Title Customization and prompt customization
# http://sage.ucsc.edu/xtal/iterm_tab_customization.html

# Put the string " [bash]   hostname::/full/directory/path"
# in the title bar using the command sequence
# \[\e]2;[bash]   \h::\]$PWD\[\a\]

# Put the penultimate and current directory
# in the iterm tab
# \[\e]1;\]$(basename $(dirname $PWD))/\W\[\a\]

PS1="$ORANGE\@: \[\e]2;$PWD\[\a\]\[\e]1;\]$(basename "$(dirname "$PWD")")/\W\[\a\]${BOLD}\$(usernamehost)\[$GREEN\]\w\$(git_info)\[$RESET\]\n\$ "


#-------------------------------------------------------------------------------
# Shell settings
#-------------------------------------------------------------------------------

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# Make vim as the default editor.
export EDITOR="vim -f"

# Update bash scroll buffer
export HISTSIZE=10000

# Add Python packages to PATH
# export PATH="/usr/local/share/python:$PATH"

# Homebrew and others...
export PATH="/usr/local/bin:$PATH"

# Add user bins to path
export PATH="$HOME/.bin:$HOME/bin:$PATH"

# Heroku Toolbelt
# export PATH="/usr/local/heroku/bin:$PATH"

# RVM
export PATH="$HOME/.rvm/bin:$PATH"

# Golang
export GOPATH="$HOME/code/go"
export PATH="$GOPATH:$GOPATH/bin:$PATH"

# Add sbin binaries.
export PATH="/usr/local/sbin:$PATH"


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Virtualenv
export WORKON_HOME=~/code/virtualenvs
