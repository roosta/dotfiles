# ┏━┓┓━┓┳ ┳  ┏━┓┳━┓┏┓┓o┏━┓┏┓┓┓━┓
# ┏━┛┗━┓┃━┫  ┃ ┃┃━┛ ┃ ┃┃ ┃┃┃┃┗━┓
# ┗━┛━━┛┇ ┻  ┛━┛┇   ┇ ┇┛━┛┇┗┛━━┛

# try to avoid the 'zsh: no matches found...'
setopt nonomatch

# report the status of backgrounds jobs immediately
setopt notify

# preform cd if command matches a directory
setopt autocd

# use #, ~ and ^ for filename generation grep word
setopt extendedglob

# allow use of comments in interactive code
setopt interactivecomments

# don't nice background tasks
setopt NO_BG_NICE

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# no beeps plz
# unsetopt beep
# setopt nobeep

# allow functions to have local options
setopt LOCAL_OPTIONS

# allow functions to have local traps
setopt LOCAL_TRAPS

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# use zsh style word splitting
setopt noshwordsplit

setopt PROMPT_SUBST

# Try to correct the spelling of command
setopt CORRECT

# Do not exit on end-of-file.  Require the use of exit or logout instead
setopt IGNORE_EOF

# ┬ ┬o┐─┐┌┐┐┌─┐┬─┐┐ ┬
# │─┤│└─┐ │ │ ││┬┘└┌┘
# ┆ ┴┆──┘ ┆ ┘─┘┆└┘ ┆

HISTFILE=~/.histfile
HISTSIZE=500000
SAVEHIST=500000

# Whenever  the  user  enters  a  line with history expansion, don't execute the line directly; instead, perform history
# expansion and reload the line into the editing buffer.
setopt HIST_VERIFY

# Save each command's beginning timestamp (in seconds since the epoch) and the duration  (in  seconds)  to  the  history
# file.  The format of this prefixed data is:
# `: <beginning time>:<elapsed seconds>;<command>'.
setopt EXTENDED_HISTORY

# clean up history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
#setopt HIST_EXPIRE_DUPS_FIRST

# adds history incrementally and share it across sessions
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

#  enable a built in help command
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
#unalias run-help
alias help=run-help

# remove empty whitespace on righthand side of prompt
#ZLE_RPROMPT_INDENT=0

# Set up 256 color support.
# see spectrum.zsh
if (( C == 256 )); then
    autoload spectrum && spectrum
fi

# Autoload some useful utilities.
autoload -Uz zmv
autoload -Uz zargs
autoload -Uz vcs_info

# set title
case $TERM in
  *xterm*|*rxvt*|*screen*)
    # Special function precmd, executed before displaying each prompt.
    function precmd() {
    # Set the terminal title to the current working directory.
    print -Pn "\e]0;%n@%m:%~\a"
    # Get the current git branch into the prompt.
    vcs_info
  }
  # Special function preexec, executed before running each command.
  function preexec () {
  # Set the terminal title to the curently running command.
  print -Pn "\e]2;[${2:q}]\a"
}
esac

autoload -z edit-command-line
zle -N edit-command-line

