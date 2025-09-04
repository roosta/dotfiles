// GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
// Source: https://github.com/caelestia-dots/shell/blob/8155e5b8735fd2473bdec8f56c7ba7fa1b66b081/services/Hyprland.qml
pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  id: root

  readonly property var toplevels: Hyprland.toplevels
  readonly property var workspaces: Hyprland.workspaces
  readonly property var monitors: Hyprland.monitors
  readonly property HyprlandToplevel activeToplevel: Hyprland.activeToplevel
  readonly property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
  readonly property HyprlandMonitor focusedMonitor: Hyprland.focusedMonitor
  readonly property int activeWsId: focusedWorkspace?.id ?? 1
  property string kbLayout: "?"

  function dispatch(request: string): void {
    Hyprland.dispatch(request);
  }

  function monitorFor(screen: ShellScreen): HyprlandMonitor {
    return Hyprland.monitorFor(screen);
  }

  Connections {
    target: Hyprland

    function onRawEvent(event: HyprlandEvent): void {
      const n = event.name;
      if (n.endsWith("v2"))
      return;

      if (n === "activelayout") {
        root.kbLayout = event.parse(2)[1].slice(0, 2).toLowerCase();
      } else if (["workspace", "moveworkspace", "activespecial", "focusedmon"].includes(n)) {
        Hyprland.refreshWorkspaces();
        Hyprland.refreshMonitors();
      } else if (["openwindow", "closewindow", "movewindow"].includes(n)) {
        Hyprland.refreshToplevels();
        Hyprland.refreshWorkspaces();
      } else if (n.includes("mon")) {
        Hyprland.refreshMonitors();
      } else if (n.includes("workspace")) {
        Hyprland.refreshWorkspaces();
      } else if (n.includes("window") || n.includes("group") || ["pin", "fullscreen", "changefloatingmode", "minimize"].includes(n)) {
        Hyprland.refreshToplevels();
      }
    }
  }

  // Process {
  //   running: true
  //   command: ["hyprctl", "-j", "devices"]
  //   stdout: StdioCollector {
  //     onStreamFinished: root.kbLayout = JSON.parse(text).keyboards.find(k => k.main).active_keymap.slice(0, 2).toLowerCase()
  //   }
  // }
}
