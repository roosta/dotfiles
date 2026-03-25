// ┌────────────────────────────────────────────────────────────────┐
// │█▀▀▀▀▀▀▀▀█░░░█▀█░█▀█░█▄█░█▀▀░█▀▄░█▀█░█▀█░█▀█░█▀▀░█░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░█░█░█▀█░█░█░█▀▀░█░█░█▀▀░█▀█░█░█░█▀▀░█░░░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀█░░░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀░░▀░░░▀░▀░▀░▀░▀▀▀░▀▀▀░░█▀▀▀▀▀▀▀▀█│
// │█▀▀▀▀▀▀▀▀▀────────────────────────────────────────────▀▀▀▀▀▀▀▀▀█│
// ├┤ Author  : Daniel Berg <mail@roosta.sh>                       ├┤
// ││ Repo    : https://github.com/roosta/dotfiles                 ││
// ││ Site    : https://www.roosta.sh                              ││
// ├┤ License : GNU General Public License v3                      ├┤
// ┆└──────────────────────────────────────────────────────────────┘┆

import Quickshell
import Quickshell.Wayland

PanelWindow {
    required property string name

    WlrLayershell.namespace: `ritual-${name}`
    color: "transparent"
}
