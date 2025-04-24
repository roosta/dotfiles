#!/bin/bash
# ┏━━━━━━━━━━━━━━━━━━━━┓
# ┃  ┏━┓┳  ┏━┓┏━┓o┏┓┓  ┃
# ┃  ┏━┛┃  ┃ ┃┃ ┳┃┃┃┃  ┃
# ┃  ┗━┛┇━┛┛━┛┇━┛┇┇┗┛  ┇
# ┗━━━━━━━━━━━━━━━━━━━━┛

## Hyprland {{{
function start_hypr() {
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
}
# }}}
## Sway {{{

function start_sway() {
  if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
    # https://github.com/swaywm/sway/wiki#xdg_current_desktop-environment-variable-is-not-being-set
    # https://github.com/flameshot-org/flameshot/blob/master/docs/Sway%20and%20wlroots%20support.md
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_QPA_PLATFORM=wayland
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_DESKTOP=sway
    export ELECTRON_OZONE_PLATFORM_HINT=wayland
    exec sway
    # exec sway > ~/.cache/sway.log 2>&1
  fi
}

# }}}

start_hypr

#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
