# ┬─┐┬  ┬ ┐┌─┐o┌┐┐┐─┐
# │─┘│  │ ││ ┬││││└─┐
# ┆  ┆─┘┆─┘┆─┘┆┆└┘──┘
# zsh-autosuggest: {{{

bindkey '^ ' autosuggest-accept

# }}}
# enhancd: {{{

export ENHANCD_DISABLE_DOT=1
export ENHANCD_HYPHEN_ARG=1

# }}}
# ls_colors: {{{

eval $(dircolors -b $HOME/.dircolors)

# }}}

#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
