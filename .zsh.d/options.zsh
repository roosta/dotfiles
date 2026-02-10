# ┏━┓┓━┓┳ ┳  ┏━┓┳━┓┏┓┓o┏━┓┏┓┓┓━┓
# ┏━┛┗━┓┃━┫  ┃ ┃┃━┛ ┃ ┃┃ ┃┃┃┃┗━┓
# ┗━┛━━┛┇ ┻  ┛━┛┇   ┇ ┇┛━┛┇┗┛━━┛

# Use vim keybinds
bindkey -v

# try to avoid the 'zsh: no matches found...'
# setopt NO_NOMATCH

# preform cd if command matches a directory
setopt autocd

# use #, ~ and ^ for filename generation grep word
setopt extendedglob

# allow use of comments in interactive code
setopt INTERACTIVE_COMMENTS

# allow functions to have local options
setopt LOCAL_OPTIONS

# allow functions to have local traps
setopt LOCAL_TRAPS

# not just at the end
setopt COMPLETE_IN_WORD

# Try to correct the spelling of command
setopt CORRECT

# Do not exit on end-of-file.  Require the use of exit or logout instead
setopt IGNORE_EOF

# History
HISTFILE=~/.histfile
HISTSIZE=500000
SAVEHIST=500000

# Whenever the user enters a line with history expansion, don't execute the
# line directly; instead, perform history expansion and reload the line into
# the editing buffer.
setopt HIST_VERIFY

# Save each command's beginning timestamp (in seconds since the epoch) and the duration  (in  seconds)  to  the  history
# file.  The format of this prefixed data is:
# `: <beginning time>:<elapsed seconds>;<command>'.
setopt EXTENDED_HISTORY

# clean up history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# enable a built in help command
autoload -U run-help
autoload run-help-git
alias help=run-help

# Batch rename files using patterns
# zmv '(*).txt' '$1.md'  # rename all .txt to .md
autoload -Uz zmv

# Like xargs but native to zsh. Handles argument list limits gracefully.
autoload -Uz zargs

## Edit command in $EDITOR (norm vv)
autoload -Uz edit-command-line

