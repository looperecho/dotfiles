# .zshrc
autoload -Uz compinit
compinit

# ┌──── Set zsh directories 
# ▼
export ZSH_DIR="$HOME/.repo/zsh"

export KEYBINDINGS="$ZSH_DIR/keys.zsh"
export ALIASES="$ZSH_DIR/aliases.zsh"
export PLUGINS="$ZSH_DIR/plugins.zsh"

export EDITOR="nvim"
export VISUAL="nvim"
alias e="$EDITOR"


# ┌──── Paths 
# ▼
typeset -U path PATH
path=(
    "$HOME/.repo/bin"
    "$HOME/.local/bin/appimages"
    $path
)


# ┌──── Load Keybindings 
# ▼
if [ -f $KEYBINDINGS ]; then
  source $KEYBINDINGS
fi


# ┌─ Load Aliases 
# ▼
if [ -f $ALIASES ]; then
  source $ALIASES
fi


# ┌──── Load zsh plugins 
# ▼
if [ -f $PLUGINS ]; then
  source $PLUGINS
fi


# ┌──── SSH check
# ▼
if [[ -n $SSH_CONNECTION ]]; then
    fastfetch
fi


# ┌──── Yazi exec and CWD on exit 
# ▼ 
function zi() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
