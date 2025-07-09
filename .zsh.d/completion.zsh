# ┏━┓┓━┓┳ ┳  ┏━┓┏━┓┏┏┓┳━┓┳  ┳━┓┏┓┓o┏━┓┏┓┓
# ┏━┛┗━┓┃━┫  ┃  ┃ ┃┃┃┃┃━┛┃  ┣━  ┃ ┃┃ ┃┃┃┃
# ┗━┛━━┛┇ ┻  ┗━┛┛━┛┛ ┇┇  ┇━┛┻━┛ ┇ ┇┛━┛┇┗┛

fpath=($HOME/.zsh.d/completion $fpath)
fpath=($FORGIT_INSTALL_DIR/completions $fpath)

autoload -Uz compinit
compinit -u

# Manually added completions, try to use upstream if possible
# autoload -U ~/.zsh.d/completion/*(:t)

# complete hidden files
# https://unix.stackexchange.com/questions/308315/how-can-i-configure-zsh-completion-to-show-hidden-files-and-folders/366137 
_comp_options+=(globdots)

# OPTIONS
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${HOME}/.zcompcache"


# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
