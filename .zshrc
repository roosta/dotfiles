# ┌───────────────────────────────────────────────┐
# │█▀▀▀▀▀▀▀▀█░░░░▀▀█░█▀▀░█░█░█▀▄░█▀▀░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░▄▀░░▀▀█░█▀█░█▀▄░█░░░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀░░░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░▀▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
# ├┤ Author : Daniel Berg <mail@roosta.sh>       ├┤
# ├┤ Github : https://github.com/roosta/dotfiles ├┤
# ┆└─────────────────────────────────────────────┘┆


# Use vim keybinds
bindkey -v

# invoke vim to edit command-line
bindkey '^e' edit-command-line

for fn (~/.zsh.d/functions/*)  autoload -Uz $fn

source ~/.config/srcery/srcery-terminal/linux_vc/srcery_linux_vc.sh
source ~/.zsh.d/utils.zsh
source ~/.zsh.d/aliases.zsh
source ~/.zsh.d/completion.zsh
source ~/.zsh.d/dirstack.zsh
source ~/.zsh.d/options.zsh
source ~/.zsh.d/rationalise_dot.zsh


# ┬─┐┬  ┬ ┐┌─┐o┌┐┐┐─┐
# │─┘│  │ ││ ┬││││└─┐
# ┆  ┆─┘┆─┘┆─┘┆┆└┘──┘
# -------------------

export ZSH_PLUGIN_PATH="$HOME/.zsh.d/plugins"

if require_binary starship "Starship is required for prompt"; then
  eval "$(starship init zsh)"
fi

function init_fzf() {
  if require_binary fzf "Fzf is required for many zsh helper functions"; then
    source <(fzf --zsh)
    source ~/.zsh.d/fzf.zsh
    bindkey '^f' edit
    bindkey '^x' fdirs
  fi
}

if [[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]; then
  source '/usr/share/doc/pkgfile/command-not-found.zsh'
fi

if [ -f "$ZSH_PLUGIN_PATH/forgit/forgit.plugin.zsh" ]; then
  export FORGIT_GLO_FORMAT="%C(auto)%h%d %s %C(brightblack)%cr%Creset"
  source "$HOME/.zsh.d/plugins/forgit/forgit.plugin.zsh"

  # Enables `git forgit ...` commands
  PATH="$PATH:$ZSH_PLUGIN_PATH/forgit/bin"

fi

if [ -f "$ZSH_PLUGIN_PATH/zsh-vi-mode.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_HIGHLIGHT_BACKGROUND=red
  function zvm_after_init() {
    init_fzf
  }
else
  init_fzf
fi


if [ -f "$ZSH_PLUGIN_PATH/fif/fif.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/fif/fif.plugin.zsh"
fi

if [ -f "$ZSH_PLUGIN_PATH/fzf-tab/fzf-tab.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/fzf-tab/fzf-tab.plugin.zsh"
#   zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

if [ -f "$ZSH_PLUGIN_PATH/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh"

  # Bind up arrow, down arrow to zsh-history-substring-search
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down

  # bind k and j for VI mode hist substring search
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

if [ -f "$ZSH_PLUGIN_PATH/zsh-completions/zsh-completions.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/zsh-completions/zsh-completions.plugin.zsh"
fi

if [ -f "$ZSH_PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
  bindkey '^ ' autosuggest-accept
fi

if [ -f "$ZSH_PLUGIN_PATH/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
fi

if [ -f "$ZSH_PLUGIN_PATH/fzf-marks/fzf-marks.plugin.zsh" ]; then
  source "$ZSH_PLUGIN_PATH/fzf-marks/fzf-marks.plugin.zsh"
fi

if require_binary vivid "Vivid is required to set LS_COLOR theme"; then
  export LS_COLORS="$(vivid generate $HOME/.config/srcery/srcery-vivid/srcery.yml)"
fi

#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
