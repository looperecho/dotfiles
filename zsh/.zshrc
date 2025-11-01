# .zshrc

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
export PATH=$HOME/.repo/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/bin/appimages:$PATH
export XDG_CONFIG_HOME="$HOME/.config"


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
    $HOME/.local/bin/pfetch
fi


# ┌──── Pyenv Stuff 
# ▼ 
if [ -d $HOME/.repo/python/pyenv ]; then
	export PYENV_ROOT="$HOME/.repo/python/pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
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
