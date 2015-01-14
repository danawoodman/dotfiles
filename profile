#-------------------------------------------------------------------------------
# Imports
#-------------------------------------------------------------------------------

# Import bashrc
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

export NVM_DIR="/Users/dana/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
