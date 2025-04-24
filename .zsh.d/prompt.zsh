# ┳━┓┳━┓┏━┓┏┏┓┳━┓┏┓┓
# ┃━┛┃┳┛┃ ┃┃┃┃┃━┛ ┃
# ┇  ┇┗┛┛━┛┛ ┇┇   ┇

# VIM_PROMPT="❯"
# PROMPT='%(?.%F{magenta}.%F{red}${VIM_PROMPT})${VIM_PROMPT}%f%k '


eval "$(starship init zsh)"

# prompt_pure_update_vim_prompt() {
#     zle || {
#         print "error: pure_update_vim_prompt must be called when zle is active"
#         return 1
#     }
#     VIM_PROMPT=${${KEYMAP/vicmd/❮}/(main|viins)/❯}
#     zle .reset-prompt
# }

# function zle-line-init zle-keymap-select {
#     prompt_pure_update_vim_prompt
# }
# zle -N zle-line-init
# zle -N zle-keymap-select

