# MacOSX Dotfiles

Contains dotfiles used in my local development environment. Portable enough to use in your own setup, if you're brave.

## Setup

First, checkout this project on a new machine:

```bash
git checkout https://github.com/danawoodman/dotfiles.git ~/dotfiles
```

Next, create a configuration file:

```bash
cp ~/dotfiles/bash_config.example ~/bash_config
```

Modify the contents of the `bash_config` file to suite.

Then run:

    ln -sf ~/dotfiles/profile ~/.profile
    ln -sf ~/dotfiles/inputrc ~/.inputrc
    ln -sf ~/dotfiles/osx ~/.osx
    ln -sf ~/dotfiles/gitconfig ~/.gitconfig
    ln -sf ~/dotfiles/gitignore ~/.gitignore
    source ~/.profile

Go into `.githconfig` and set your name and your Github email address.
