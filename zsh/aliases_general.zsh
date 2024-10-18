# Alias source file. Referenced in .zshrc

# ┌──────── LS 
# ▼
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias las='ls -lah'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# ▼ Modify LS_COLORS for STICKY_OTHER_WRITABLE dirs
LS_COLORS="${LS_COLORS}:ow=34;40"
export LS_COLORS
export LSCOLORS=ExFxBxDxCxegedabagacad


# ┌──────── SSH 
# ▼
# ▼ Basic: rPi
pi() {
    alacritty --config-file "$HOME/.config/alacritty/pi.toml" &> /dev/null & disown
}

# ▼ Basic: macOS
alias macos='TERM=screen-256color ssh macos'

# ▼ Profile: box
box() {
    alacritty --config-file "$HOME/.config/alacritty/box.toml" &> /dev/null & disown
}

# ▼ Profile: whatbox.ca
whatbox() {
    alacritty --config-file "$HOME/.config/alacritty/whatbox.toml" &> /dev/null & disown
}


# ┌──────── Directory Exports 
# ▼
export repo="$HOME/.repo"
export bashbin="$HOME/.repo/bin"
export ffprofile="$HOME/.mozilla/firefox/fbx6vbty.Recoil"
export qmkmap="$HOME/.repo/qmk/keebchron"
export appimage="$HOME/.local/bin/appimages"
export builds="$HOME/.local/builds"
export CODE="$HOME/code"
export REPO="$HOME/.repo"
export VENVS="$HOME/.repo/python/venvs"
export DROP="/mnt/Drop"


# ┌──────── Script Shortcuts 
# ▼
alias :themes='bash -c "$(wget -qO- https://git.io/vQgMr)"'
alias :ytdl="$bashbin/ytdl.sh"
alias :qmk="source $bashbin/qmk.sh"
alias :newvenv="$bashbin/newvenv.sh"
alias :uvr="$bashbin/uvr.sh"
alias :backup="$bashbin/backup.sh"


# ┌──────── Shortcuts 
# ▼
# ▼ Pacman
alias pacsearch='pacman -Ss'
alias pacin='sudo pacman -S'
alias pacup="$bashbin/pacman/list_updates.sh"
alias paclist='pacman -Qe'
alias pacdeps='pacman -Qi'
alias pacrm='sudo pacman -Rs'
alias paclog='pacman -Qc'
alias pacsync='sudo pacman -Syy'
alias pacache='sudo pacman -Sc'
alias pacaurup='yay -Syu --aur'
alias paclistaur='pacman -Qm'
alias mirrorup='sudo reflector --verbose --latest 20 --sort rate --save /etc/pacman.d/mirrorlist'

# ▼ Edit zsh etc.
alias editzsh="e $ZSH_DIR/.zshrc"
alias editalias="e $ZSH_DIR/aliases.zsh"
alias editprompt="e $ZSH_DIR/prompt.zsh"
alias editplugins="e $ZSH_DIR/plugins.zsh"
alias reload="exec $SHELL"

# ▼ Jump to exported locations
alias .bashbin="cd $bashbin"
alias .ffprofile="cd $ffprofile"
alias .code="cd $CODE/$1"
alias .qmk="cd $qmkmap"

# ▼ Other
alias code="codium"
alias nv="nvim"
alias envoff="source deactivate"
alias editqmk="e $qmkmap"


# ┌──────── Functions 
# ▼
# ▼ Create .desktop file (for .AppImage)
makedesktop() {
    "$bashbin/make_desktop_file.sh" "$@"
}

# ▼ Activate venv
envon() {
    source "$bashbin/envon.sh" "$1"
}

# ▼ Backup `home` or `root`
bak() {
    source "$bashbin/backup.sh" "$1"
}

# ▼ Start Project Zomboid local server
pzserver() {
	source "$bashbin/zomboid-server.sh"
}

# ▼ Run waveflow service
waveflow() {
    source "$bashbin/waveflow.sh"
}

# ▼ Prevent nested ranger instance
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}

# ┌──────── . 
# ▼
