# ┌───────────────────────────────────────────────┐
# │█▀▀▀▀▀▀▀▀█░░░░▀▀█░█▀▀░█░█░█▀▄░█▀▀░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░▄▀░░▀▀█░█▀█░█▀▄░█░░░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀░░░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░▀▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
# ├┤ Author : Daniel Berg <mail@roosta.sh>       ├┤
# ├┤ Github : https://github.com/roosta/etc      ├┤
# ┆└─────────────────────────────────────────────┘┆
# Virtual console {{{
# Set colors by parsing xresources (or attempt to, not working. Will fix eventually)
# Also start a tmux session
if [ "$TERM" = "linux" ]; then
  _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
  for i in $(sed -n "$_SEDCMD" $HOME/.Xresources.d/srcery.xresources | \
               awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
    echo -en "$i"
  done
  clear
  tmux new-session -s vconsole
fi
#}}}
# Plugins {{{
source ~/.zplug/init.zsh

if [[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]; then
  source '/usr/share/doc/pkgfile/command-not-found.zsh'
fi

# (If the defer tag is given 2 or above, run after compinit command)
zplug "Tarrasch/zsh-bd"
zplug 'wfxr/forgit'
zplug "kutsan/zsh-system-clipboard"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "b4b4r07/enhancd", use:init.sh
# zplug "roosta/fif"
zplug "~/src/fif", from:local
zplug "Aloxaf/fzf-tab"
zplug "softmoth/zsh-vim-mode"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
  zplug install
fi

# Then, source plugins and add commands to $PATH
zplug load
# }}}
# Functions {{{
fpath+=("$HOME/.zsh.d/functions")
for fn (~/.zsh.d/functions/*)  autoload -Uz $fn
# }}}
# Zsh configuration {{{
for config (~/.zsh.d/*.zsh) source $config

if [[ -s ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi
# }}}
# Plugin conf {{{
# for cfg (~/.zsh.d/plugin_conf/*.zsh) source $cfg
# hash fasd 2>/dev/null && source ~/.zsh.d/plugin_conf/fasd.zsh
hash fzf 2>/dev/null && source ~/.zsh.d/plugin_conf/fzf.zsh
source ~/.zsh.d/plugin_conf/ls_colors.zsh
source ~/.zsh.d/plugin_conf/autosuggestions.zsh
source ~/.zsh.d/plugin_conf/enhancd.zsh
source ~/.zsh.d/plugin_conf/zsh-syntax-highlighting.zsh
hash thefuck 2>/dev/null && eval $(thefuck --alias)
# }}}
#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
