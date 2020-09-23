# ┬─┐┬ ┐┌─┐┌─┐┐ ┬  ┬─┐o┌┐┐┬─┐┬─┐┬─┐
# ├─ │ │┌─┘┌─┘└┌┘──├─ │││││ │├─ │┬┘
# ┆  ┆─┘└─┘└─┘ ┆   ┆  ┆┆└┘┆─┘┴─┘┆└┘
# Options: {{{

# Respecting .gitignore, .hgignore, and svn:ignore
# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --hidden --smart-case --follow --ignore-file ~/.globalignore --files'

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
# Command history: {{{

# fh - repeat history
fhist() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf-tmux +s --tac | sed 's/ *[0-9]* *//')
}
#}}}
# Changing directory {{{

# fd - including hidden directories
fdir() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf-tmux +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# cf - fuzzy cd from anywhere
# ex: cf word1 word2 ... (even part of a file name)
# zsh autoload function
cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}

#}}}
# Kill {{{
fkill() {
  pid=$(ps -ef | sed 1d | fzf-tmux -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}
#}}}
# Opening files {{{

# Fuzzy match file and open with EDITOR
e() {
  if [ "$#" -ne 0 ]; then
    "${EDITOR:-vim}" "$@"
  else
    local file
    file=$(fzf-tmux --query="$1")
    [ -n "$file" ] && sleep 0.2 && "${EDITOR:-vim}" "$file"
  fi
}

et() {
  if [ "$#" -ne 0 ]; then
    emacsclient -c -t "$@"
  else
    local file
    file=$(fzf-tmux --query="$1")
    [ -n "$file" ] && sleep 0.2 && emacsclient -c -t "$file"
  fi
}

_e() {
  if [ "$#" -ne 0 ]; then
    SUDO_EDITOR="emacsclient -t" sudoedit $@
  else
    local file
    file=$(fzf-tmux --query="$1")
    [ -n "$file" ] && SUDO_EDITOR="emacsclient -t" sudoedit "$file"
  fi
}

# Fuzzy match file and open with vim
# If passed an argument, open that file in vim, otherwise fzf seach from CWD
v() {
  if [ "$#" -ne 0 ]; then
    vim $@
  else
    local file
    file=$(fzf-tmux --query="$1")
    [ -n "$file" ] && vim -- "$file"
  fi
}

# To to org folder and open match
o() {
  local file
  file=$(\ls ~/org | fzf-tmux --query="$1")  &&
    [ -n "$file" ] && emacsclient -a vim -c -t "~/org/${file}"
}

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
ef() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf-tmux --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     emacsclient -nw -- $files
     print -l $files[1]
  fi
}

#}}}
# Git {{{

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --graph --color=always --pretty=oneline --format="%C(auto)%h%d %s %C(black)%C(white)%cr" --abbrev-commit) &&
  commit=$(echo "$commits" | fzf-tmux --ansi +s +m -e) &&
  git checkout $(echo "$commit" | grep -oe "[0-9a-f]\{5,32\}")
}

# fsha - get git commit sha
# example usage: git rebase -i `fsha`
fsha() {
  local commits commit
  commits=$(git log --graph --color=always --pretty=oneline --format="%C(auto)%h%d %s %C(black)%C(white)%cr" --abbrev-commit) &&
  commit=$(echo "$commits" | fzf-tmux +s +m -e --ansi) &&
  echo -n $(echo "$commit" | grep -oe "[0-9a-f]\{5,32\}")
}

#}}}
# Tags {{{
# ftags - search ctags
ftags() {
  local line
  [ -e tags ] &&
  line=$(
    awk 'BEGIN { FS="\t" } !/^!/ {print toupper($4)"\t"$1"\t"$2"\t"$3}' tags |
    cut -c1-80 | fzf-tmux --nth=1,2
  ) && $EDITOR $(cut -f3 <<< "$line") -c "set nocst" \
                                      -c "silent tag $(cut -f2 <<< "$line")"
}
#}}}
# Tmux {{{
# fs [FUZZY PATTERN] - Select selected tmux session
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fts() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf-tmux --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
}

#}}}
# AG {{{
# ------

# search using ag and open selected file at linum
fv() {
  local match linum file;
  match=$(\ag \
    --nobreak \
    --smart-case \
    --hidden  \
    -p ~/.agignore \
    --noheading . | fzf-tmux +m) &&

    linum=$(echo "$match" | cut -d':' -f2) &&
    file=$(echo "$match" | cut -d':' -f1) &&

    emacsclient -nw +$linum $file
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
# Package managers {{{
# Search apt for query, and install selected package
fapt() {
  local pkg=$(apt-cache search $1 | fzf --no-multi -q $1 --ansi --preview="apt-cache show {1}" | awk '{ print $1 }')

  if [[ $pkg ]]; then
    sudo apt-get install $pkg
  fi
}

# Search AUR and official repos using yay and install on
# select. Supports multiple selections and preview using yay -Si
fyay() {
  local pkg=$(yay -Ssq | fzf-tmux --multi --query "$1" --preview="yay -Si {}")
  if [[ $pkg ]]; then
    yay -S - <<< $pkg
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
#}}}
# Convenience {{{
forg() {
  local match linum file;
  (
    cd ~/org &&
    match=$(\rg \
              --smart-case \
              --color "always" \
              --line-number \
              --no-heading . | \
              fzf -d ":" \
                  --ansi \
                  --nth "2.." \
                  --preview-window=up \
                  --with-nth "1,3.." \
                  --preview="fzf-preview {q} {}") &&

      linum=$(echo "$match" | cut -d':' -f2) &&
      file=$(echo "$match" | cut -d':' -f1) &&

      emacsclient -nw +$linum $file
  )
}

viemacs() {
  local file;
  (
    cd ~/.emacs.d/lisp &&
      file=$(fzf-tmux --query="$1" --multi --preview "bat --color always {}") &&
      [ -n "$file" ] &&
      emacsclient -nw "$file"
  )
}
#}}}
#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
