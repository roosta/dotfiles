# ┳┏ ┳━┓┓ ┳┳━┓o┏┓┓┳━┓┓━┓
# ┣┻┓┣━ ┗┏┛┃━┃┃┃┃┃┃ ┃┗━┓
# ┇ ┛┻━┛ ┇ ┇━┛┇┇┗┛┇━┛━━┛

# Use vim keybinds
bindkey -v

# 10ms for key sequences
# make keymode indication more responsive
# KEYTIMEOUT=1

# Bind up arrow, down arrow to zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# bind k and j for VI mode hist substring search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# invoke vim to edit command-line
bindkey '^e' edit-command-line
