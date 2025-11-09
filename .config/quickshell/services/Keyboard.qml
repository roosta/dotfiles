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

        // Hyprland.dispatch(`exec hyprctl switchxkblayout current next`)
Singleton {
  id: root
  property var layout: {
    return Config.keyboardLayouts.find(l => l.default)
  }
  property bool capsLock
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
        root.capsLock = main?.capsLock ?? false
        root.layout = Config.keyboardLayouts.find(l => l.label === keymap)
      }
    }
  }

  GlobalShortcut {
    name: "shiftlock"
    description: "Handles capslock state"
    onPressed: {
      devicesProc.running = true
    }
  }
  Process {
    id: switchProc
    running: false
    command: ["hyprctl", "switchxkblayout", "current", "next"]
  }

  function nextLayout() {
    switchProc.running = true
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
