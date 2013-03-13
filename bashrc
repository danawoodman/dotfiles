#-------------------------------------------------------------------------------
# Imports
#-------------------------------------------------------------------------------

# Import terminal colors
if [ -f $HOME/.colors ]; then
    source $HOME/.colors
fi

# Import aliases
if [ -f $HOME/.aliases ]; then
    source $HOME/.aliases
fi

# Import server aliases
if [ -f $HOME/.servers ]; then
    source $HOME/.servers
fi

# Import git bash completion
if [ -f $HOME/.git-completion.bash ]; then
    source $HOME/.git-completion.bash
fi

# Import virtualenvwrapper (Python 2.7)
# if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
#     source /usr/local/bin/virtualenvwrapper.sh
# fi

# Import virtualenvwrapper (Python 2.6)
if [ -f /usr/local/bin/virtualenvwrapper_bashrc ]; then
    source /usr/local/bin/virtualenvwrapper_bashrc
fi

# For Ruby rvm...
[[ -s "/Users/dana/.rvm/scripts/rvm" ]] && source "/Users/dana/.rvm/scripts/rvm"  # This loads RVM into a shell session.


#-------------------------------------------------------------------------------
# Shell settings
#-------------------------------------------------------------------------------

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir[master]$   # clean working directory
#   username@Machine ~/dev/dir[master*]$  # dirty working directory
 
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

# Import Ruby stuff.
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# Make nano as the default editor.
# export EDITOR='nano'
export EDITOR='subl -w'

# Update bash scroll buffer
export HISTSIZE=10000

# Give django-admin.py output a nice color scheme.
export DJANGO_COLORS="dark"

# Add Python packages to PATH
export PATH="/usr/local/share/python:$PATH"

# Homebrew and others...
export PATH="/usr/local/bin:$PATH"

# Add npm global bin directory to path.
export PATH="/usr/local/share/npm/bin:$PATH"

# Add user bins to path
export PATH="$HOME/.bin:$PATH"

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# RVM
export PATH="$HOME/.rvm/bin:$PATH"

# Style terminal.
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LS_COLORS='di=01;33'
export PS1="${YELLOW}[\@]${WHITE}: ${BRIGHT_GREEN}\w ${BRIGHT_YELLOW} \$(parse_git_branch):${RESET} "

# Tell virtualenvwrapper where all virtual environments should go.
export WORKON_HOME="$HOME/Dropbox/Code/virtualenvs"

# Tell PIP to install all virtual environments in the virtualenvwrapper home (from above).
export PIP_VIRTUALENV_BASE=$WORKON_HOME

# Setup Amazon EC2 Command-Line Tools
# export EC2_HOME=~/.ec2
# export PATH=$PATH:$EC2_HOME/bin
# export EC2_PRIVATE_KEY=`ls $EC2_HOME/pk-*.pem`
# export EC2_CERT=`ls $EC2_HOME/cert-*.pem`
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/


#-------------------------------------------------------------------------------
# Etc...
#-------------------------------------------------------------------------------

# PIP bash completion
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
