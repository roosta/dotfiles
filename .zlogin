#!/bin/bash
# ┌───────────────────────────────────────────────┐
# │█▀▀▀▀▀▀▀▀█░░░░█░░░█▀█░█▀▀░▀█▀░█▀█░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░█░░░█░█░█░█░░█░░█░█░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀█░░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░░░█▀▀▀▀▀▀▀▀█│
# │█▀▀▀▀▀▀▀▀▀───────────────────────────▀▀▀▀▀▀▀▀▀█│
# ├┤ Author  : Daniel Berg <mail@roosta.sh>      ├┤
# ││ Repo    : https://github.com/roosta/dotfiles││
# ││ Site    : https://www.roosta.sh             ││
# ├┤ License : GNU General Public License v3     ├┤
# ┆└─────────────────────────────────────────────┘┆

function start_hypr() {
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
}

start_hypr

#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
