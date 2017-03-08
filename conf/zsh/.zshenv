# ┌──────────────────────────────────────────────────┐
# │░░░█▀▀░█▀█░█░█░▀█▀░█▀▄░█▀█░█▀█░█▄█░█▀▀░█▀█░▀█▀░░░░│
# │░░░█▀▀░█░█░▀▄▀░░█░░█▀▄░█░█░█░█░█░█░█▀▀░█░█░░█░░░░░│
# │░░░▀▀▀░▀░▀░░▀░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░▀░░▀░░░░░│
# └──────────────────────────────────────────────────┘

# set paths.
# See ~/.zprofile
typeset -U path
path=(~/bin $(ruby -rubygems -e "puts Gem.user_dir")/bin /usr/local/bin $HOME/.go/bin /perl5/bin ~/.npm/bin ~/.pip/bin $path[@])
# export PATH=$HOME/bin:$(ruby -rubygems -e "puts Gem.user_dir")/bin:/usr/local/bin:$HOME/.go/bin:$HOME/perl5/bin:$HOME/.npm/bin:$HOME/.pip/bin:$PATH
#export MANPATH=/usr/local/man:$MANPATH

fpath=($HOME/.zsh.d/functions $HOME/.zsh.d/completion $fpath)
# fpath=("$HOME/.zsh.d/completion" $fpath)

# set ruby gems install location to home
export BUNDLE_PATH=$(ruby -rubygems -e "puts Gem.user_dir")

# locate
export LANG=en_US.UTF-8

# only define LC_CTYPE if undefined
if [[ -z "$LC_CTYPE" && -z "$LC_ALL" ]]; then
	export LC_CTYPE=${LANG%%:*} # pick the first entry from LANG
fi

# export TERM="xterm-screen-256color"
# export TERM="xterm-256color"
# export TERM="rxvt-unicode-256color"
export TERM="screen-256color"
export TERMINAL=termite
export BROWSER=firefox-developer

#export GEM_HOME="/usr/local/lib/ruby/gems/2.2.0"

# uniform qt/gtk look.
export DESKTOP_SESSION=gnome
export QT_STYLE_OVERRIDE=GTK+
# export GDK_DPI_SCALE=2

# editor
# export EDITOR="emacsclient -t"
# export VISUAL="emacsclient -t"

export EDITOR=vim
export VISUAL=vim

# golang lib path
export GOPATH=$HOME/.go

export ZSH_CACHE_DIR=$HOME/.cache/zsh

# use vimpager, and replace less
export PAGER=/usr/bin/vimpager
export LESS=-R

# alias less to vim pager
alias less=$PAGER
alias zless=$PAGER

# Use native runtime for steam.
# See https://wiki.archlinux.org/index.php/Unofficial_user_repositories#alucryd-multilib
# export STEAM_RUNTIME=0

# tell ranger not to use default config
export RANGER_LOAD_DEFAULT_RC="false"

# cpan stuff
PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"${HOME}/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"; export PERL_MM_OPT;

# set site.USERBASE for pip user installs
export PYTHONUSERBASE=$HOME/.pip

export ARDUINO_DIR=/usr/share/arduino

# Fix for latency issues in wine
export PULSE_LATENCY_MSEC=60

# gtags
export GTAGSLABEL=ctags
export PROJECT_HOME=~/dev
