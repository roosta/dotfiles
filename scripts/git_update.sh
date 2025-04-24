#!/bin/bash
error_msg() {
  echo "missing argument(s)"
  exit 1
}

git_clone() {
  local repo="$1"
  local out
  out=$(git clone "$repo" 2>&1)
  echo "$out"
}
export -f git_clone

git_pull() {
  local dest="$1"
  cd "$dest" && git pull && cd - || return
}
export -f git_pull

collect_clone() {
  local file="$1"
  local tmp
  local result=""

  while read -r repo; do

    # ignore blank lines
    if [ "$repo" != "" ]; then

      tmp=$(sem -j 4 git_clone "$repo" 2>&1)
      result+="${tmp},"
    fi

  done <"$file"
  echo "$result"
}

update_repos() {
  local repos="$1"
  IFS=,
  for out in $repos; do
    if [[ $out =~ fatal ]]; then
      dest=$(echo "$out" | awk '{print substr($4, 2, length($4) - 2)}')
      sem -j 4 git_pull "$dest"
    else
      echo "$out"
    fi
  done
  sem --wait
}

 # echo -e "\033[0;33mupdating $dest...\033[0m"
# take two args. Parent folder and repositories text file.
# loop over each repo in text file, attempting to clone
main () {
  (( $# == 2 )) || error_msg

  local out
  local path="$1"
  local repo_file="$2"
  local clone_status
  local dest

  cd "$path" || exit

  if [[ -f "$2" ]]; then
    clone_status=$(collect_clone "$repo_file")
    update_repos "$clone_status"
  else
    error_msg
  fi
}

main "${@}"
# git_pull
