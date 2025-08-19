# ┬─┐┬  ┬ ┐┌─┐o┌┐┐┐─┐
# │─┘│  │ ││ ┬││││└─┐
# ┆  ┆─┘┆─┘┆─┘┆┆└┘──┘
# -------------------

if require_binary starship; then
  eval "$(starship init zsh)"
fi

function init_fzf() {
  if require_binary fzf fd; then
    source <(fzf --zsh)
    source "$ZSH_CONFIG_PATH/fzf.zsh"

    # ~/.zsh.d/functions + ~/scripts
    zle -N fzf_edit
    alias e=fzf_edit
    bindkey '^f' fzf_edit
    bindkey '^x' fdirs
  fi
}

# Arch spesific
if [[ -s '/usr/share/doc/pkgfile/command-not-found.zsh' ]]; then
  source '/usr/share/doc/pkgfile/command-not-found.zsh'
fi

# LS_COLORS using vivid
if require_binary vivid; then
  export LS_COLORS="$(vivid generate $HOME/.config/srcery/srcery-vivid/srcery.yml)"
fi

# Track if zsh-vi-mode was loaded
zsh_vi_mode_loaded=false

# Iterate over plugin submodules (see ~/.gitmodules)
for plugin in "$ZSH_CONFIG_PATH"/plugins/*/*.plugin.zsh; do

  # Extract plugin name
  bn=$(basename $plugin .zsh)
  name=${bn//\.plugin/}

  # Handle plugin config
  case "$name" in
    "forgit")
      # Enables `git forgit ...` commands
      PATH="$PATH:$ZSH_CONFIG_PATH/plugins/forgit/bin"
      ;;
    "zsh-vi-mode")
      ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
      ZVM_VI_HIGHLIGHT_BACKGROUND=red
      function zvm_after_init() {
        init_fzf
      }
      zsh_vi_mode_loaded=true
      ;;
    "fzf-tab")
      zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
      ;;
    "zsh-history-substring-search")
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
      ;;
    "zsh-autosuggestions")
      bindkey '^ ' autosuggest-accept
      ;;
  esac 
  source "$plugin"
done

# Handle fzf initialization based on zsh-vi-mode presence
if ! $zsh_vi_mode_loaded; then
  init_fzf
fi
