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

# https://wiki.archlinux.org/title/Hyprland
# Autostart hyprland
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec start-hyprland
fi

#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
