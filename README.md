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


## Reference


### Bash

- Search bash history: <kbd>Control</kbd>


### VIM

Combination of general vim snippets and custom ones in `.vimrc`:


#### Various Commands

- Jump back to last location: <kbd>Control</kbd> + <kbd>o</kbd>
- Copy (or "yank") entire line: <kbd>Shift</kbd> + <kbd>y</kbd>
- Copy select to clipboard: <kbd>Shift</kbd> + <kbd>"</kbd> + <kbd>\*</kbd> + <kbd>y</kbd>


#### Expand Emmet Snippets

- <kbd>Control</kbd> + <kbd>z</kbd> + <kbd>,</kbd>
- <kbd>Control</kbd> + <kbd>z</kbd> + <kbd>,</kbd>


#### Spelling suggestions

- Look up spelling suggestions for selection: <kbd>z</kbd> + <kbd>=</kbd>

#### Bookmarking

1. Create bookmark: <kbd>m</kbd> + <kbd>ANY_LETTER</kbd>
2. Go to bookmark: <kbd>\`</kbd> + <kbd>ANY_LETTER</kbd>


#### Record a Macro

1. Start recording macro (replace ANY_LETTER): <kbd>q</kbd> + <kbd>ANY_LETTER</kbd>
2. Type your commands...
3. Stop recording: <kbd>q</kbd>
4. Replay your recording: <kbd>@</kbd> + <kbd>ANY_LETTER</kbd>


#### Surrounding Text

Surround choices: `'`, `"`, `{`, `[`, `(`, etc

- Change surrounding characters: <kbd>c</kbd> + <kbd>s</kbd> + <kbd>FROM_CHARACTER</kbd> + <kbd>TO_CHARACTER</kbd>
    - FROM_CHARACTER is the current surround character
    - TO_CHARACTER is the surround character you want to replace it with
    - Example: `c+s+"'` changes `"Foobar"` to `'Foobar'`
- Delete surround character: <kbd>d</kbd> + <kbd>s</kbd> + <kbd>CHARACTER</kbd>
    - CHARACTER can be any supported surrounding character
- Surround selected text/line in visual mode: <kbd>Shift</kbd> + <kbd>S</kbd> + <kbd>CHARACTER</kbd>


## TODO:

- [ ] Script to auto symlink files
