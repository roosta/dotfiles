// import Quickshell
import Quickshell.Io
pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.config
// import qs.utils

Singleton {
  id: root
  property var layout: {
    return Config.keyboardLayouts.find(l => l.default)
  }
  Process {
    id: devicesProc
    running: true
    command: ["hyprctl", "-j", "devices"]

    stdout: StdioCollector {
      id: devicesCollector
      onStreamFinished: {
        const parsed = JSON.parse(devicesCollector.text);
        const main = parsed["keyboards"].find(kb => kb.main);
        const keymap = main["active_keymap"]; 
        root.layout = Config.keyboardLayouts.find(l => l.label === keymap)
      }
    }
  }
  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "activelayout") {
        devicesProc.running = true
      }
    }
  }
}
