#-------------------------------------------------------------------------------
# Imports
#-------------------------------------------------------------------------------
# Import bashrc
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi
export NVM_DIR="/Users/dana/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
