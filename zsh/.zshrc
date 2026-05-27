export ZSH="$HOME/.oh-my-zsh"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
	git
	git-extras
	github
	golang
	vscode
	common-aliases
	encode64
	extract
	macos
	supervisor
	systemd
	wd
)

source $ZSH/oh-my-zsh.sh

#--------------------------------------------------------------
# Shell settings
#--------------------------------------------------------------

# Disable shared history
unsetopt share_history

# Allow completion of hidden files
compinit
_comp_options+=(globdots)

#--------------------------------------------------------------
# Env / tooling setup
#--------------------------------------------------------------

eval "$(starship init zsh)"

# fnm: https://github.com/Schniz/fnm
# do this before we setup node aliases!
FNM_PATH="$HOME/.fnm"
FNM_ARCH="arm64"
export PATH="$FNM_PATH:$PATH"
eval "$(fnm env --use-on-cd --shell zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# mise completions
eval "$(/opt/homebrew/bin/mise activate zsh --shims)"
