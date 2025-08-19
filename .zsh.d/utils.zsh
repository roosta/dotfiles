#!/usr/bin/env zsh
# ┌───────────────────────────────────────┐ #
# │ ┏━┓┓━┓┳ ┳  ┳ ┓┏┓┓o┳  ┓━┓              │ #
# │ ┏━┛┗━┓┃━┫  ┃ ┃ ┃ ┃┃  ┗━┓              │ #
# │ ┗━┛━━┛┇ ┻  ┇━┛ ┇ ┇┇━┛━━┛              │ #
# └───────────────────────────────────────┘ #
# Maintainer: Daniel Berg <mail@roosta.sh>  #
# Repo: https://github.com/roosta/dotfiles  #
# ----------------------------------------- #

# Helper fn to ensure binary presenense
# require_binary() {
#   local binary=$1
#   local message=${2:-"Required binary '$binary' is not installed"}
#
#   if ! command -v "$binary" &> /dev/null; then
#     echo "Error: $message" >&2
#     return 1
#   fi
#   return 0
# }

# Helper fn to ensure binary presenense
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
