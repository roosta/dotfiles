#!/bin/bash
# Toggle mouse menu state (kando) in hyprland via bindings

STATE_FILE="/tmp/hypr-menu-state"

enable_menu() {
  hyprctl keyword bind ",mouse:275,global,:media-menu"
  rm -f "$STATE_FILE"
  notify-send --icon input-mouse "Media Menu" "Enabled media menu"
}

disable_menu() {
  hyprctl keyword unbind ",mouse:275"
  touch "$STATE_FILE"
  notify-send --icon preferences-desktop-peripherals "Media Menu" "Disabled media menu"
}

case "${1:-sync}" in
  enable)
    enable_menu
    ;;
  disable)
    disable_menu
    ;;
  toggle)
    if [ -f "$STATE_FILE" ]; then
      enable_menu
    else
      disable_menu
    fi
    ;;
  sync)
    if [ -f "$STATE_FILE" ]; then
      hyprctl keyword unbind ",mouse:275"
    else
      hyprctl keyword bind ",mouse:275,global,:media-menu"
    fi
    ;;
  *)
    echo "Usage: $0 {enable|disable|toggle|sync}"
    exit 1
    ;;
esac
