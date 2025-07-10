pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property string defaultIcon: ""
  readonly property var windowIcons: ({
    "firefox-developer-edition": "",
    "libreoffice-calc": "",
    "^firefox$": "",
    "^firefox-media$": "",
    "Google-chrome-unstable": "",
    "Google-chrome": "",
    ".*(?i)transmission": "",
    "org.gnome.Nautilus": "Nautilus",
    "com\\.bitwig\\.BitwigStudio": "󰎄",
    "jetbrains-idea-ce": "",
    "thunderbird": "",
    ".*(?i)shortwave": "",
    "pavucontrol": "",
    ".*(?i)lutris": "",
    ".*(?i)discord": "󰭹",
    "(?i)org.gnome.software": "󰀻",
    ".*(?i)flatseal": "",
    "Gpick": "",
    "Spotify": "",
    "com.obsproject.Studio": "",
    "Kitty": "",
    "Alacritty": "",
    "gimp": "",
    "(?i)steam$": "",
    "(?i)reaper$": "",
    "(?i)slack$": "",
    "(?i)evince$": "",
    "(?i)gedit": "",
    "(?i)minecraft.*": "󰍳",
  })
}
