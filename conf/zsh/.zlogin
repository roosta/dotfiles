#!/bin/bash

# Autostart Sway at login
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then

  # https://github.com/swaywm/sway/wiki#xdg_current_desktop-environment-variable-is-not-being-set
  # https://github.com/flameshot-org/flameshot/blob/master/docs/Sway%20and%20wlroots%20support.md
  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
  export QT_QPA_PLATFORM=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway
  export ELECTRON_OZONE_PLATFORM_HINT=wayland
  export MOZ_ENABLE_WAYLAND=1
  exec sway
  # exec sway > ~/.cache/sway.log 2>&1
fi

# Autostart X at login
# if [ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ]; then
#   export GDK_SCALE=2
#   exec startx ~/.xinitrc i3
# fi

