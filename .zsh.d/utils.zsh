#!/usr/bin/env zsh
# ┌───────────────────────────────────────────────┐
# │█▀▀▀▀▀▀▀▀█░░░░█░█░▀█▀░▀█▀░█░░░█▀▀░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░█░█░░█░░░█░░█░░░▀▀█░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░▀▀▀░░▀░░▀▀▀░▀▀▀░▀▀▀░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
# ├┤ Author  : Daniel Berg <mail@roosta.sh>      ├┤
# ││ Repo    : https://github.com/roosta/dotfiles││
# ││ Site    : https://www.roosta.sh             ││
# ├┤ License : GNU General Public License v3     ├┤
# ┆└─────────────────────────────────────────────┘┆

# Helper fn to ensure binary precense
# takes multiple arguments, i.e `require_binary fzf fd`
require_binary() {
  local missing=()

  for binary in "$@"; do
    if ! command -v "$binary" &> /dev/null; then
      missing+=("$binary")
    fi
  done

  if [[ ${#missing[@]} -gt 0 ]]; then
    if [[ ${#missing[@]} -eq 1 ]]; then
      echo "Warning: binary '${missing[1]}' is not installed, skipping config..." >&2
    else
      echo "Warning: binaries are not installed: ${missing[*]}, skipping config..." >&2
    fi
    return 1
  fi
  return 0
}
