#!/bin/bash

# Autostart Sway at login
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
  exec sway
  # exec sway > ~/.cache/sway.log 2>&1
fi

# Autostart X at login
# if [ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ]; then
#   export GDK_SCALE=2
#   exec startx ~/.xinitrc i3
# fi

