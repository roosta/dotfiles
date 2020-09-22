# ┌──────────────────────────────────────────────────┐
# │░░░█▀▀░█▀█░█░█░▀█▀░█▀▄░█▀█░█▀█░█▄█░█▀▀░█▀█░▀█▀░░░░│
# │░░░█▀▀░█░█░▀▄▀░░█░░█▀▄░█░█░█░█░█░█░█▀▀░█░█░░█░░░░░│
# │░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░▀░░░░░│
# └──────────────────────────────────────────────────┘

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

path=(~/bin
      /usr/local/bin
      $HOME/.go/bin
      ~/perl5/bin
      ~/.npm/bin
      ~/.pip/bin
      ~/.cargo/bin
      $path[@])

# set ruby gems install location to home
# export BUNDLE_PATH=$(ruby -rubygems -e "puts Gem.user_dir")

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# only define LC_CTYPE if undefined
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
	export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

# export TERM="rxvt-unicode-256color"
export TERM="xterm-termite"
export TERMINAL=termite
export BROWSER=firefox

# uniform qt/gtk look.
export DESKTOP_SESSION=gnome
export QT_STYLE_OVERRIDE=GTK+
export GDK_DPI_SCALE=1
# export GDK_SCALE=2

# editor
export EDITOR="nvim"
# export EDITOR="emacsclient -a vim -c -t"
export ALTERNATE_EDITOR="nvim"
# export VISUAL="emacsclient -a vim -c -t"
export VISUAL="nvim"

# export EDITOR=vim
# export VISUAL=vim

# golang lib path
export GOPATH=$HOME/.go

export ZSH_CACHE_DIR=$HOME/.cache/zsh

# always use the -R option to show raw characters
export LESS=-R

if hash vimpager 2>/dev/null; then
  export PAGER=/usr/bin/vimpager
else
  export PAGER=less
fi

alias less=$PAGER
alias zless=$PAGER

export BAT_STYLE="plain"

# tell ranger not to use default config
export RANGER_LOAD_DEFAULT_RC="false"

# cpan stuff
export PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base \"${HOME}/perl5\""
export PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"

# set site.USERBASE for pip user installs
export PYTHONUSERBASE=$HOME/.pip

export ARDUINO_DIR=/usr/share/arduino

# Fix for latency issues in wine
export PULSE_LATENCY_MSEC=60

# gtags
export GTAGSLABEL=ctags

# https://github.com/trapd00r/vim-syntax-vidir-ls
export VIDIR_EDITOR_ARGS='-c :set nolist | :set ft=vidir-ls'

export SYSTEMD_EDITOR="/usr/bin/nvim"

export GRAALVM_HOME="${HOME}/java/graalvm-ce-19.1.1/bin"
export JAVA_HOME="/usr/lib/jvm/default"
export NASHORN_HOME="$JAVA_HOME/bin"

# temp
# export PGSSLMODE=require

# https://github.com/racer-rust/racer#installation
# hash rustc 2>/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# if hash ruby 2>/dev/null; then
#   PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
# fi

export CHEAT_USE_FZF=true
