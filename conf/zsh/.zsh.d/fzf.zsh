# ┬─┐┬ ┐┌─┐┌─┐┐ ┬  ┬─┐o┌┐┐┬─┐┬─┐┬─┐
# ├─ │ │┌─┘┌─┘└┌┘──├─ │││││ │├─ │┬┘
# ┆  ┆─┘└─┘└─┘ ┆   ┆  ┆┆└┘┆─┘┴─┘┆└┘
# Options {{{
# Respecting .gitignore, .hgignore, and svn:ignore
# Setting rg as the default source for fzf
export FZF_DEFAULT_COMMAND='rg \
  --colors=path:fg:blue \
  --colors=line:fg:yellow \
  --hidden \
  --smart-case \
  --follow \
  --ignore-file ~/.globalignore \
  --files'

export FZF_DEFAULT_OPTS="
--ansi
--color='fg:15,bg:0,hl:5,fg+:15,bg+:235,hl+:13'
--color='info:11,prompt:5,spinner:11,pointer:10,marker:208,header:15'
--bind='alt-k:preview-up,alt-p:preview-up'
--bind='alt-j:preview-down,alt-n:preview-down'
--bind='ctrl-r:toggle-all'
--bind='ctrl-s:toggle-sort'
--bind='ctrl-p:toggle-preview'
--bind='alt-w:toggle-preview-wrap'
"
# export FZF_COMPLETION_TRIGGER='~~'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS="--preview '(bat -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
#}}}
# Functions {{{

# fhist - repeat history
fhist() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf-tmux +s --tac | sed 's/ *[0-9]* *//')
}

fdirs() {
  local dir
  dir=$(dirs | fzf-tmux)
  if [ -n "$dir" ]; then
    index=$(echo "$dir"|cut -f1)
    cd -$index
  else
    return 2
  fi
}

# cddir - including hidden directories
cddir() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf-tmux +m) && cd "$dir"
}

# cdfile - cd into the directory of the selected file
cdfile() {
  local file
  local dir
  file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Fuzzy match file and open with EDITOR
e() {
  if [ "$#" -eq 0 ]; then
    local file
    file=$(fd -tf --color=always --strip-cwd-prefix | fzf-tmux --ansi)
    [ -n "$file" ] && sleep 0.1 && vim "$file"
  elif [ "$#" -eq 1 ] && [ -d "$1"  ]; then
    local file
    file=$(fd -tf --base-directory="$1" --color=always --strip-cwd-prefix | fzf-tmux --ansi)
    echo "$file"
    [ -n "$file" ] && vim -c "cd $1" -- "${1}/$file"
  elif [ "$#" -eq 1 ] && [ -f "$1" ]; then
    vim "$1"
  else
    vim "$@"
  fi
}

# Set sudo editor to vim and call sudoedit
# fuzzy edit readonly files
_e() {
  if [ "$#" -ne 0 ]; then
    SUDO_EDITOR="vim" sudoedit $@
  else
    local file
    file=$(fzf-tmux --query="$1")
    [ -n "$file" ] && SUDO_EDITOR="vim" sudoedit "$file"
  fi
}

# Open file in notes
o() {
  local file
  file=$(find ~/notes -name '*.md' | fzf -d "/" --query="$1" --with-nth "5..")  &&
    [ -n "$file" ] && vim -c "cd ~/notes" -- "$file"
  }

# fsha - get git commit sha
# example usage: git rebase -i `fsha`
fsha() {
  local commits commit
  commits=$(git log --graph --color=always --pretty=oneline --format="%C(auto)%h%d %s %C(black)%C(white)%cr" --abbrev-commit) &&
    commit=$(echo "$commits" | fzf-tmux +s +m -e --ansi) &&
    echo -n $(echo "$commit" | grep -oe "[0-9a-f]\{5,32\}")
  }

# Search apt for query, and install selected package
fapt() {
  local pkg=$(apt-cache search $1 | fzf --no-multi -q $1 --ansi --preview="apt-cache show {1}" | awk '{ print $1 }')

  if [[ $pkg ]]; then
    sudo apt-get install $pkg
  fi
}

# Search AUR and official repos using yay and install on
# select. Supports multiple selections and preview using yay -Si
faur() {
  local pkg=$(paru -Slq | fzf --multi --query "$1" --preview 'paru -Si {1}')
  if [[ $pkg ]]; then
    paru -S - <<< $pkg
  fi
}

# Search with pacman, and install on select. Supports multiple
# selections, and preview using pacman -Si
fpac() {
  local pkg=$(pacman -Ssq | fzf-tmux --multi --query "$1" --preview="pacman -Si {}")
  if [[ $pkg ]]; then
    sudo pacman -S - <<< $pkg
  fi
}

falias() {
  local match;
  match=$(cat ~/.zsh.d/aliases.zsh -n | fzf-tmux +m --reverse --preview="echo {1}") &&
    echo $match

  # cat aliases.zsh|sed -n '4,5p'
  # linum=$(echo "$match" | cut -d':' -f2) &&
  # file=$(echo "$match" | cut -d':' -f1) &&

    # ${EDITOR:-vim} +$linum $file
  }

#}}}
#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
