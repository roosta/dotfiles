# ┌──────────────────────────────────────────────────┐
# │░░░█▀▀░█▀█░█░█░▀█▀░█▀▄░█▀█░█▀█░█▄█░█▀▀░█▀█░▀█▀░░░░│
# │░░░█▀▀░█░█░▀▄▀░░█░░█▀▄░█░█░█░█░█░█░█▀▀░█░█░░█░░░░░│
# │░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░▀░░░░░│
# └──────────────────────────────────────────────────┘

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

path=(
	~/bin
	/usr/local/bin
	$HOME/.go/bin
	~/perl5/bin
	~/.npm/bin
	~/.pip/bin
	~/.cargo/bin
	$path[@]
)

fpath=(
	"$HOME/.zsh.d/functions"
	"/opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/zsh"
	$fpath[@]
)

# export TERM="xterm-termite"
export TERMINAL=alacritty
export BROWSER=firefox

# uniform qt/gtk look.
export DESKTOP_SESSION=gnome
export QT_STYLE_OVERRIDE=adwaita-dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export GTK_THEME=Adwaita:dark
export GDK_DPI_SCALE=1

# editor
export EDITOR="nvim"
export ALTERNATE_EDITOR="nvim"
export VISUAL="nvim"

# golang lib path
export GOPATH=$HOME/.go

export ZSH_CACHE_DIR=$HOME/.cache/zsh

# Set less default opts
export LESS="-R --use-color --mouse --jump-target=12 -DP15.236"

export PAGER=less
export PARU_PAGER=less

# alias less=$PAGER
# alias zless=$PAGER

# tell ranger not to use default config
export RANGER_LOAD_DEFAULT_RC="false"

# set site.USERBASE for pip user installs
export PYTHONUSERBASE=$HOME/.pip

export ARDUINO_DIR=/usr/share/arduino

# Fix for latency issues in wine
export PULSE_LATENCY_MSEC=60

# https://github.com/trapd00r/vim-syntax-vidir-ls
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export SYSTEMD_EDITOR="/usr/bin/nvim"

export GRAALVM_HOME="${HOME}/java/graalvm-ce-19.1.1/bin"
export JAVA_HOME="/usr/lib/jvm/default"
export NASHORN_HOME="$JAVA_HOME/bin"

# https://github.com/racer-rust/racer#installation
# hash rustc 2>/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

if hash ruby 2>/dev/null; then
	export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
  PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

# export NODE_OPTIONS="--openssl-legacy-provider"

export SSH_AUTH_SOCK=/run/user/$(id -u)/gcr/ssh

#  vim: set ts=2 sw=2 tw=0 fdm=marker noet :
