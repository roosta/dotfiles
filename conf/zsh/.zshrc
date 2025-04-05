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
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# zplug "Tarrasch/zsh-bd"
zplug 'wfxr/forgit'
# zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
# zplug "b4b4r07/enhancd", use:init.sh
# zplug "roosta/fif"
zplug "~/src/fif", from:local
zplug "Aloxaf/fzf-tab"
# zplug "softmoth/zsh-vim-mode", defer:2
zplug "jeffreytse/zsh-vi-mode"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
# zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zdharma-continuum/fast-syntax-highlighting"
zplug "urbainvaes/fzf-marks"

zplug "plugins/safe-paste", from:oh-my-zsh
# zplug "plugins/web-search", from:oh-my-zsh

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

source ~/.zsh.d/srcery_linux_vc.sh
source ~/.zsh.d/aliases.zsh
source ~/.zsh.d/colored_man_pages.zsh
source ~/.zsh.d/completion.zsh
source ~/.zsh.d/dirstack.zsh
source ~/.zsh.d/fzf.zsh
source ~/.zsh.d/options.zsh
source ~/.zsh.d/plugins.zsh
source ~/.zsh.d/prompt.zsh
source ~/.zsh.d/rationalise_dot.zsh

function zvm_after_init() {
  source ~/.zsh.d/keybinds.zsh
  source /home/roosta/.config/broot/launcher/bash/br
  source <(fzf --zsh)
}

# }}}
#  vim: set ts=2 sw=2 tw=0 fdm=marker et :

