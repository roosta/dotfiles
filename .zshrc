# ┌───────────────────────────────────────────────┐
# │█▀▀▀▀▀▀▀▀█░░░░▀▀█░█▀▀░█░█░█▀▄░█▀▀░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░▄▀░░▀▀█░█▀█░█▀▄░█░░░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀░░░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░░░▀▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
# ├┤ Author : Daniel Berg <mail@roosta.sh>       ├┤
# ├┤ Github : https://github.com/roosta/dotfiles ├┤
# ┆└─────────────────────────────────────────────┘┆

# config path
export ZSH_CONFIG_PATH="$HOME/.zsh.d"

# Load config scripts
scripts=(
  "$HOME/.config/srcery/srcery-terminal/linux_vc/srcery_linux_vc.sh"
  "$ZSH_CONFIG_PATH/utils.zsh"
  "$ZSH_CONFIG_PATH/aliases.zsh"
  "$ZSH_CONFIG_PATH/completion.zsh"
  "$ZSH_CONFIG_PATH/dirstack.zsh"
  "$ZSH_CONFIG_PATH/options.zsh"
  "$ZSH_CONFIG_PATH/rationalise_dot.zsh"
  "$ZSH_CONFIG_PATH/plugins.zsh"
  "/usr/share/nvm/init-nvm.sh"
)
for script in "${scripts[@]}"; do
  source "$script"
done

# Autload functions
for fn in $ZSH_CONFIG_PATH/functions/*; do
  autoload -Uz $fn
done

# vim: set ts=2 sw=2 tw=0 fdm=marker et :
