#!/bin/bash
# Handle the different states mouse:275 (first side button on my setup)
# I use this for various conflicting things, this handles toggling on and off
# the various modes.
#
# Old attempt, keep for reference
# bind = , mouse:275, global, :media-menu 
# bind = , mouse:275, pass, class:^gamescope$
# bind = , mouse:275, pass, class:^steam_app.*$
# bind = , mouse:275, sendshortcut,, ALT_L, title:^World of Warcraft.*


STATE_FILE="/tmp/hypr-mouse-state"

get_state() {
  if [ -f "$STATE_FILE" ]; then
    cat "$STATE_FILE"
  else
    echo "menu"
  fi
}

disable() {
  hyprctl keyword unbind ",mouse:275"
  echo "disabled" > "$STATE_FILE"
  notify-send --icon media-playback-paused "Mouse Mode Disabled" "Mouse now acts normally"
}

enable_menu() {
  state=$(get_state)
  if [ "$state" = "menu" ]; then
    disable
  else
    hyprctl keyword bind ",mouse:275,global,:media-menu"
    notify-send --icon input-mouse "Media Menu" "Enabled media menu (kando)"
    echo "menu" > "$STATE_FILE"
  fi
}

enable_alt() {
  state=$(get_state)
  if [ "$state" = "alt" ]; then
    disable
  else
    echo "alt" > "$STATE_FILE"
    hyprctl keyword bind ",mouse:275,sendshortcut,,ALT_L"
    notify-send --icon preferences-desktop-keyboard "Alt Mode" "Enabled alt mode"
  fi
}

case "${1:-sync}" in
  menu)
    enable_menu
    ;;
  disable)
    disable
    ;;
  alt)
    enable_alt
    ;;
  sync)
    state=$(get_state)
    case "$state" in
      menu)
        hyprctl keyword bind ",mouse:275,global,:media-menu"
        ;;
      disabled)
        hyprctl keyword unbind ",mouse:275"
        ;;
      alt)
        hyprctl keyword bind ",mouse:275,sendshortcut,,ALT_L"
        ;;
    esac
    ;;
  *)
    echo "Usage: $0 {menu|alt|sync}"
    echo "Tracks state via $STATE_FILE, will toggle on and off mode if script is fired repeatedly"
    exit 1
    ;;
esac
