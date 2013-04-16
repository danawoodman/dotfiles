#-------------------------------------------------------------------------------
# Imports
#-------------------------------------------------------------------------------

# Import configuration
if [ -f $HOME/.bash_config ]; then
  source $HOME/.bash_config
fi

# Import terminal colors
if [ -f $DOTFILES_PATH/colors ]; then
  source $DOTFILES_PATH/colors
fi

# Import aliases
if [ -f $DOTFILES_PATH/aliases ]; then
  source $DOTFILES_PATH/aliases
fi

# Import git bash completion
if [ -f $HOME/.git-completion.bash ]; then
  source $HOME/.git-completion.bash
fi

# For Ruby rvm...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.


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

# Make nano as the default editor.
# export EDITOR='nano'
export EDITOR='subl -w'

# Update bash scroll buffer
export HISTSIZE=10000

# Add Python packages to PATH
export PATH="/usr/local/share/python:$PATH"

# Homebrew and others...
export PATH="/usr/local/bin:$PATH"

# Add npm global bin directory to path.
export PATH="/usr/local/share/npm/bin:$PATH"

# Add user bins to path
export PATH="$HOME/.bin:$PATH"

# PostgresApp bins
export PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# RVM
export PATH="$HOME/.rvm/bin:$PATH"

# Style terminal.
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LS_COLORS='di=01;33'
export PS1="${YELLOW}[\@]${WHITE}: ${BRIGHT_GREEN}\w ${BRIGHT_YELLOW} \$(parse_git_branch):${RESET} "
