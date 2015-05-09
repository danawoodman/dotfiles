# MacOSX Dotfiles

Contains dotfiles used in my local development environment. Portable enough to use in your own setup, if you're brave.

## Setup

First, checkout this project on a new machine:

```bash
git checkout https://github.com/danawoodman/dotfiles.git ~/dotfiles
```

Then run:

```bash
# Symlink dotfiles
ln -sf ~/dotfiles/profile ~/.profile
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/inputrc ~/.inputrc
ln -sf ~/dotfiles/osx ~/.osx
ln -sf ~/dotfiles/git_template ~/.git_template
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore ~/.gitignore
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/Brewfile ~/Brewfile
ln -sf ~/dotfiles/.Xresources-hybrid ~/.Xresources-hybrid

# Activate new bash config
source ~/.bashrc

# Install brew packages
brew bundle
```


## TODO:

- Script to auto symlink files
