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
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc

#--------------------------------------------------------------
# Aliases
#--------------------------------------------------------------

alias c="cd"

# Docker aliases
alias d="docker"
alias dc='docker-compose'

# Tell dropbox to ignore the given file/directory
alias dbi="xattr -w com.dropbox.ignored 1"

alias code="vsc"

# npm
alias n="npm"
alias ni="n i"
alias nu="n un"
alias nug="nu -g"
alias nid="ni -D"
alias nig="ni -g"
alias nr="n run"
alias nb="nr build"
alias nd="nr dev"
alias nt="n test"
alias ncr="n create -y"
alias no="n outdated"
alias npx="npx -y"

# Bun
alias b="bun"
alias bi="b i"
alias bup="b update"
alias bu="b rm"
alias brm="bu"
alias bug="bu -g"
alias bid="bi -d"
alias big="bi -g"
alias ba="b add"
alias bad="ba -d"
alias bag="ba -g"
alias br="b run "
alias bb="br build"
alias bd="br dev"
alias bs="br start"
alias bt="br test"
alias bcr="b create"
alias bo="b outdated"
alias bx="b x"

# Makefile
alias m="make"
alias mb="m build"
alias mt="m test"
alias mtw="m watch-test"
alias mwt="mtw"

# vim
alias vi="nvim"
alias vim="nvim"

# clear out build junk
alias wipe="trash **/node_modules **/.svelte-kit/ **/.turbo/ **/build/ bun.lockb bun.lock package-lock.json"

alias w="bunx wrangler"

# General utils
alias cl="clear"
alias ka='killall'
alias ls="eza"
alias l="eza -l --color=always --icons=always"
# alias l="ls -GFlha"
alias ll="l"

# Git aliases
HASH="%C(yellow)%h%C(reset)"
RELATIVE_TIME="%C(green)(%ar)%C(reset)"
AUTHOR="%C(bold blue)%an%C(reset)"
REFS="%C(red)%d%C(reset)"
SUBJECT="%s%C(reset)"
FORMAT="{$HASH{$RELATIVE_TIME{$AUTHOR{$REFS $SUBJECT"
function pretty_git_log() {
	git log --color --pretty="tformat:$FORMAT" --graph $* |
		# Replace (2 years ago) with (2 years)
		sed -Ee 's/(^[^<]*) ago\)/\1)/' |
		# Replace (2 years, 5 months) with (2 years)
		sed -Ee 's/(^[^<]*), [[:digit:]]+ .*months?\)/\1)/' |
		# Remove parens from around the timestamp.
		tr -d '()' |
		# Line columns up based on { delimiter
		column -t -s '{' |
		# Color merge commits specially
		sed -Ee "s/(Merge branch .* into .*$)/$(printf $ANSI_MAGENTA)\1$(printf $ANSI_RESET)/" |
		# Page only if we need to
		less -FXRS
}
alias gl=pretty_git_log
alias gp="g push"
alias gpt="g push && g push --tags"
alias gpf="g push -f"
alias grst="g reset"
alias gcob="gco -b"
alias gpl="g pull"
alias gbl="g branch -l"
alias gpnv="g push --no-verify"
alias gs="g status -sb"
alias gls="gl -20"
alias gst="g stash"
alias gt="g tag"
alias gmv="g mv"
alias gup="gf && gst -u -m \"pre-pull\" ; gpl && gst pop"
# alias gup="gf && gst -u -m \"pre-pull\"; grb origin/$(git rev-parse --abbrev-ref HEAD) && gst pop"
# alias gupp="gup ; gp"
alias gw="g worktree"

# Github
alias hb="hub browse"

# Homebrew
alias brew="arch -arm64 brew"

# Unalias built-in oh-my-zsh aliases
# unalias gog
# unalias md
# unalias rm

function md() {
	mkdir -p "$@" && cd "$@"
}

# Remove zsh annoying "rm -i" alias
setopt rm_star_silent
setopt +o nomatch
eval "$(mise activate zsh)"
eval "$(mise activate zsh)"
eval "$(mise activate zsh)"
eval "$(mise activate zsh)"
eval "$(mise activate zsh)"
eval "$(mise activate zsh)"
eval "$(mise activate zsh)"
eval "$(mise activate zsh)"
