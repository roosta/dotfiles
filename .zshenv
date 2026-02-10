# ┌──────────────────────────────────────────────────┐
# │░░░█▀▀░█▀█░█░█░▀█▀░█▀▄░█▀█░█▀█░█▄█░█▀▀░█▀█░▀█▀░░░░│
# │░░░█▀▀░█░█░▀▄▀░░█░░█▀▄░█░█░█░█░█░█░█▀▀░█░█░░█░░░░░│
# │░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░▀░░░░░│
# └──────────────────────────────────────────────────┘

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

path=(
	~/bin
	~/.local/bin
	~/.cargo/bin
	~/.npm/bin
	$path[@]
)

fpath=(
	"$HOME/.zsh.d/functions"
	$fpath[@]
)

# Use this with hyprland disable xwayland scaling
export GDK_SCALE=2

export TERMINAL=kitty
export BROWSER=firefox

# Editor
export EDITOR=nvim
export ALTERNATE_EDITOR=nvim
export VISUAL=nvim
export SYSTEMD_EDITOR="/usr/bin/nvim"

# Set less default opts
export LESS="-R --use-color --mouse --jump-target=12 -DP15.236"

# pager
export PAGER=nvimpager
export PARU_PAGER=$PAGER
export MANPAGER=$PAGER


if [ -f "${HOME}/Secrets/environment.zsh" ]; then
	source "${HOME}/Secrets/environment.zsh"
fi

#  vim: set ts=2 sw=2 tw=0 fdm=marker noet :
