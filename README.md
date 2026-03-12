# MacOSX Dotfiles

Contains dotfiles used in my local development environment. Portable enough to use in your own setup, if you're brave.

## Setup

Install [stow](https://www.gnu.org/software/stow/) then run:

```sh
# Checkout this project on a new machine:
git checkout https://github.com/danawoodman/dotfiles.git ~/dotfiles


# Setup the environment
./scripts/setup

# Activate new zsh config
source ~/.zshrc
```

## Update

```sh
# Update the dotfiles
./scripts/update
```
