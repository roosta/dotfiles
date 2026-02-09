#!/bin/bash
# ┏━━━━━━━━━━━━━━━━━━━━┓
# ┃  ┏━┓┳  ┏━┓┏━┓o┏┓┓  ┃
# ┃  ┏━┛┃  ┃ ┃┃ ┳┃┃┃┃  ┃
# ┃  ┗━┛┇━┛┛━┛┇━┛┇┇┗┛  ┇
# ┗━━━━━━━━━━━━━━━━━━━━┛

## Hyprland
function start_hypr() {
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
}

start_hypr

#  vim: set ts=2 sw=2 tw=0 fdm=marker et :
