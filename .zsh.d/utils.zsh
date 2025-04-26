# ┌───────────────────────────────────────┐ #
# │ ┏━┓┓━┓┳ ┳  ┳ ┓┏┓┓o┳  ┓━┓              │ #
# │ ┏━┛┗━┓┃━┫  ┃ ┃ ┃ ┃┃  ┗━┓              │ #
# │ ┗━┛━━┛┇ ┻  ┇━┛ ┇ ┇┇━┛━━┛              │ #
# └───────────────────────────────────────┘ #
# Maintainer: Daniel Berg <mail@roosta.sh>  #
# Repo: https://github.com/roosta/dotfiles  #
# ----------------------------------------- #

# Helper fn to ensure binary presenense
require_binary() {
  local binary=$1
  local message=${2:-"Required binary '$binary' is not installed"}

  if ! command -v "$binary" &> /dev/null; then
    echo "Error: $message" >&2
    return 1
  fi
  return 0
}
