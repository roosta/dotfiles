pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root
  readonly property string defaultIcon: ""
  readonly property var categoryIcons: ({
    "WebBrowser": "",
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
    "Music": "",
    "com.obsproject.Studio": "",
    "TerminalEmulator": "",
    "Alacritty": "",
    "gimp": "",
    "(?i)steam$": "",
    "(?i)reaper$": "",
    "(?i)slack$": "",
    "(?i)evince$": "",
    "(?i)gedit": "",
    "(?i)minecraft.*": "󰍳",
  })

    function getAppCategoryIcon(name: string, fallback: string): string {
        const obj = DesktopEntries.heuristicLookup(name);
        const categories = obj?.categories

        // console.log(JSON.stringify(obj, null, 2))
        if (categories) {
          for (const [key, value] of Object.entries(categoryIcons)) {
            if (categories.includes(key)) {
              return value;
            }

          }
        }
        return fallback;
    }

}
