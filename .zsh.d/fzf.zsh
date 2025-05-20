# ┬─┐┬ ┐┌─┐┌─┐┐ ┬  ┬─┐o┌┐┐┬─┐┬─┐┬─┐
# ├─ │ │┌─┘┌─┘└┌┘──├─ │││││ │├─ │┬┘
# ┆  ┆─┘└─┘└─┘ ┆   ┆  ┆┆└┘┆─┘┴─┘┆└┘
# -----------------------------------------------------------------------------
# Options {{{

# Respecting .gitignore, .hgignore, and svn:ignore
# Setting rg as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f \
  --hidden \
  --color=always'

export FZF_DEFAULT_OPTS="
--ansi
--bind='alt-k:preview-up,alt-p:preview-up'
--bind='alt-j:preview-down,alt-n:preview-down'
--bind='ctrl-r:toggle-all'
--bind='ctrl-s:toggle-sort'
--bind='ctrl-p:toggle-preview'
--bind='ctrl-a:select-all'
--bind='alt-w:toggle-preview-wrap'
"

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type dir --hidden --color=always"
export FZF_ALT_C_OPTS="--preview 'tree -a --gitignore -C {} | head -200'"
#}}}
# Functions {{{

# Parses dirstack, and presents is a fzf window, I truncate the $HOME path to
# "~", bound to ctrl-f, see keybinds.zsh
fdirs() {
  local dir
  print -rNC1 -- ${(D)dirstack} |
    fzf \
      --read0 \
      --scheme=path \
      --print0 \
      --ansi \
      --preview 'eval eza --color always -aghl \
                  --group-directories-first -F {}' \
      --preview-window 'right:50%' |
    IFS= read -rd '' dir &&
    cd -- ${dir/#\~/$HOME} &&
    zle -I
}
zle -N fdirs # So that it can be used as a shortcut. See keybinds.sh

# I keep a ~/lib dir for when I need to build extenal repos from source, or
# reference it's source code. This makes it quick to navigate to a dir in that
# location.
flib() {
  local dir
  dir=$(ls -1 ~/lib | fzf)
  if [ -n "$dir" ]; then
    cd $HOME/lib/$dir
  else
    return 2
  fi
}

# Fuzzy match file and open with $EDITOR
#
# Requirements: fzf, fd
#
# Usage:
#   edit - Fuzzy find files in current directory and open in $EDITOR
#   edit <file> .. - Open specified file(s) in $EDITOR
#   edit <multiple args> - Pass all arguments to $EDITOR
edit() {
  if [ "$#" -eq 0 ]; then
    local files=$(fd --type file --color=always --strip-cwd-prefix)
    fzf \
      --ansi \
      --preview-window 'right:60%' --multi \
      --bind 'enter:become(${EDITOR:-nvim} {+})' \
      --preview 'bat --color=always --style=numbers {}' <<< $files
  else
    ${EDITOR:-nvim} "$@"
  fi
}
zle -N edit # So that it can be used as a shortcut. See keybinds.sh
alias e=edit

# Open file in ~/notes
open_note() {
  local file=$(find ~/notes -name '*.md' | fzf -d "/" --query="$1" --with-nth "5..")
  [ -n "$file" ] && vim -c "cd $HOME/notes" -- "$file"
}
alias o=open_note

# fsha - get git commit sha
# example usage: git rebase -i `fsha`
fsha() {
  local commits commit
  commits=$(git log --graph --color=always --pretty=oneline --format="%C(auto)%h%d %s %C(black)%C(white)%cr" --abbrev-commit) &&
    commit=$(echo "$commits" | fzf +s +m -e --ansi) &&
    echo -n $(echo "$commit" | \grep -oe "[0-9a-f]\{5,32\}")
  }

# Search AUR and official repos using yay and install on select. Supports
# multiple selections and preview using paru -Si
faur() {
  local pkg=$(paru -Slq | fzf --multi --query "$1" --preview 'paru -Si {1}')
  if [[ $pkg ]]; then
    paru -S - <<< $pkg
  fi
}

# Search with pacman, and install on select. Supports multiple
# selections, and preview using pacman -Si
fpac() {
  local pkg=$(pacman -Ssq | fzf --multi --query "$1" --preview="pacman -Si {}")
  if [[ $pkg ]]; then
    sudo pacman -S - <<< $pkg
  fi
}

# Search aliases.zsh, and output match to cmd # Expand the alias instead of
# outputing the alias itself, useful for referece.
falias() {
  local match;
  match=$(bat --color=always --decorations=never ~/.zsh.d/aliases.zsh | fzf +m --reverse)
  out=$(sed -n "s/^\s*alias [^=]*=[\"']\(.*\)[\"'].*$/\1/p" <<< "$match")
  if [ -n "$out" ]; then
    print -z "$out"
  else
    echo "Not an alias!"
    return 1
  fi
}

#}}}
#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
