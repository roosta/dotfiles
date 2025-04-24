# ┬─┐┬  ┬ ┐┌─┐o┌┐┐┐─┐
# │─┘│  │ ││ ┬││││└─┐
# ┆  ┆─┘┆─┘┆─┘┆┆└┘──┘
# zsh-autosuggest: {{{

if zplug check zsh-users/zsh-autosuggestions; then
  bindkey '^ ' autosuggest-accept
fi

# }}}
# enhancd: {{{

if zplug check b4b4r07/enhancd; then
    export ENHANCD_DISABLE_DOT=1
    export ENHANCD_HYPHEN_ARG=1
fi

# }}}
# ls_colors: {{{

if  [[ -f $HOME/.dircolors ]]; then
  eval $(dircolors -b $HOME/.dircolors)
fi

# }}}
# zsh-vi-mode {{{

if zplug check jeffreytse/zsh-vi-mode; then
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_HIGHLIGHT_BACKGROUND=red
fi
# }}}
# Cheat.sh {{{

export CHEAT_USE_FZF=true

# }}}
# clipmenu {{{

export CM_LAUNCHER=rofi

# }}}
# fzf-tab {{{
if zplug check Aloxaf/fzf-tab; then
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
# }}}
# forgit {{{

if zplug check wfxr/forgit; then
  # export FORGIT_PAGER="forgit-pager"
fi


# }}}

#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
