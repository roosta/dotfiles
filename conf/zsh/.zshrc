# ┌───────────────────────────────────────────────┐
# │█▀▀▀▀▀▀▀▀█░░░░▀▀█░█▀▀░█░█░█▀▄░█▀▀░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░▄▀░░▀▀█░█▀█░█▀▄░█░░░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀░░░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░▀▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
# ├┤ Author : Daniel Berg <mail@roosta.sh>       ├┤
# ├┤ Github : https://github.com/roosta/etc      ├┤
# ┆└─────────────────────────────────────────────┘┆
# Plugins {{{

if [[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]; then
  source '/usr/share/doc/pkgfile/command-not-found.zsh'
fi

source ~/.zplug/init.zsh

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
zplug "softmoth/zsh-vim-mode", defer:2
# zplug "jeffreytse/zsh-vi-mode"
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
#}}}
# Config: {{{

for fn (~/.zsh.d/functions/*)  autoload -Uz $fn
for config (~/.zsh.d/*.zsh) source $config

if [[ -s ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# }}}
#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
