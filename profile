# Make nano as the default editor.
export EDITOR='mate'

# Give django-admin.py output a nice color scheme.
export DJANGO_COLORS="dark"

# Set paths to bin scripts.
export PATH="/Users/dana/lib/get-shit-done/:/Users/dana/.gem/ruby/1.8/bin:/user/bin/:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"

# Server aliases:
alias danaw="ssh danaw@danaw.webfactional.com"
alias esketch="ssh esketch@esketch.webfactional.com"
alias giveplace="ssh ubuntu@107.22.198.229"
alias giveplace-staging="ssh ubuntu@107.22.197.88"
alias sketchup="ssh ec2-user@50.16.219.215"

# Create aliases for listing of files.
alias ll="ls -Glha"
alias la="ls -a"
alias lsd='ls -l | grep "^d"'

# Pretty print JSON output from things like curl 
alias json='python -m json.tool'

# Load git bash completion
source ~/git-completion.bash

# GIT aliases.
alias g="git"
alias gh='git help'
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gc='git commit -m'
alias gca='git commit -am'
alias gb='git branch'
alias gco='git co'
alias gra='git remote add'
alias grr='git remote rm'
alias gpl='git pull'
alias gcl='git clone'
alias gm='git merge'
alias gmv='git mv'
alias grm='git rm'
alias gst='git stash'
alias gf='git fetch'
alias gbt='git checkout -t -b'
alias grp='git rev-parse'

# Style terminal.
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Show more useful prompt information.
DULL=0
BRIGHT=1

FG_BLACK=30
FG_RED=31
FG_GREEN=32
FG_YELLOW=33
FG_BLUE=34
FG_VIOLET=35
FG_CYAN=36
FG_WHITE=37

FG_NULL=00

BG_BLACK=40
BG_RED=41
BG_GREEN=42
BG_YELLOW=43
BG_BLUE=44
BG_VIOLET=45
BG_CYAN=46
BG_WHITE=47

BG_NULL=00

##
# ANSI Escape Commands
##
ESC="\033"
NORMAL="\[$ESC[m\]"
RESET="\[$ESC[${DULL};${FG_WHITE};${BG_NULL}m\]"

##
# Shortcuts for Colored Text ( Bright and FG Only )
##
# DULL TEXT
BLACK="\[$ESC[${DULL};${FG_BLACK}m\]"
RED="\[$ESC[${DULL};${FG_RED}m\]"
GREEN="\[$ESC[${DULL};${FG_GREEN}m\]"
YELLOW="\[$ESC[${DULL};${FG_YELLOW}m\]"
BLUE="\[$ESC[${DULL};${FG_BLUE}m\]"
VIOLET="\[$ESC[${DULL};${FG_VIOLET}m\]"
CYAN="\[$ESC[${DULL};${FG_CYAN}m\]"
WHITE="\[$ESC[${DULL};${FG_WHITE}m\]"
# BRIGHT TEXT
BRIGHT_BLACK="\[$ESC[${BRIGHT};${FG_BLACK}m\]"
BRIGHT_RED="\[$ESC[${BRIGHT};${FG_RED}m\]"
BRIGHT_GREEN="\[$ESC[${BRIGHT};${FG_GREEN}m\]"
BRIGHT_YELLOW="\[$ESC[${BRIGHT};${FG_YELLOW}m\]"
BRIGHT_BLUE="\[$ESC[${BRIGHT};${FG_BLUE}m\]"
BRIGHT_VIOLET="\[$ESC[${BRIGHT};${FG_VIOLET}m\]"
BRIGHT_CYAN="\[$ESC[${BRIGHT};${FG_CYAN}m\]"
BRIGHT_WHITE="\[$ESC[${BRIGHT};${FG_WHITE}m\]"

# REV TEXT as an example
REV_CYAN="\[$ESC[${DULL};${BG_WHITE};${BG_CYAN}m\]"
REV_RED="\[$ESC[${DULL};${FG_YELLOW}; ${BG_RED}m\]"

PROMPT_COMMAND='export ERR=$?'

export LS_COLORS='di=01;33'
export PS1="${BRIGHT_YELLOW}[\@] ${BRIGHT_CYAN}\u@macbook-pro${WHITE}: ${BRIGHT_VIOLET}\w ${BRIGHT_WHITE} \$ ${RESET}  "

# Tell virtualenvwrapper where all virtual environments should go.
export WORKON_HOME="$HOME/Dropbox/Code/virtualenvs"
source /usr/local/bin/virtualenvwrapper_bashrc

# Tell PIP to install all virtual environments in the virtualenvwrapper home (from above).
export PIP_VIRTUALENV_BASE=$WORKON_HOME

# Shorthand SASS.
alias sassy="sass -t compressed --watch ."

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

# For Ruby rvm...
[[ -s "/Users/dana/.rvm/scripts/rvm" ]] && source "/Users/dana/.rvm/scripts/rvm"  # This loads RVM into a shell session.
