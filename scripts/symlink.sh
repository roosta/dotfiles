#!/bin/bash
error_msg() {
  echo "missing argument(s)"
  exit 1
}

# take two args. Parent folder and repositories text file.
# loop over each repo in text file, attempting to clone
(( $# == 1 )) || error_msg

if [[ -f "$1" ]]; then
  while read -r item; do

    # ignore blank lines
    if [[ "$item" != "" ]]; then
        src=$(echo "$item" | awk '{print $1}') 
        dest=$(echo "$item" | awk '{print $2}') 
        # echo $dest
        # echo "Symlinking $src -> $dest"
        ln -sfv "$src" "$dest"
    fi
  done <"$1"
else
  error_msg
fi
