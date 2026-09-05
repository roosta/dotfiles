# ┌────────────────────────────────────────────────────────────────────┐
# │█▀▀▀▀▀▀▀▀█░░░█▀▀░█▀█░█░█░▀█▀░█▀▄░█▀█░█▀█░█▄█░█▀▀░█▀█░▀█▀░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░█▀▀░█░█░▀▄▀░░█░░█▀▄░█░█░█░█░█░█░█▀▀░█░█░░█░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░▀░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
# ├┤ Author  : Daniel Berg <mail@roosta.sh>                           ├┤
# ││ Repo    : https://github.com/roosta/dotfiles                     ││
# ││ Site    : https://www.roosta.sh                                  ││
# ├┤ License : GNU General Public License v3                          ├┤
# ┆└──────────────────────────────────────────────────────────────────┘┆

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

path=(
	~/.local/bin
	~/.cargo/bin
	~/.local/share/pnpm/bin
	$path[@]
)

fpath=(
	"$HOME/.zsh.d/functions"
	$fpath[@]
)

export TERMINAL=kitty
export BROWSER=firefox

## SSH
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"

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

#  vim: set ts=2 sw=2 tw=0 fdm=marker noet :
