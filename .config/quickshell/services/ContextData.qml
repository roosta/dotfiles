pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.services
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.utils
import qs

Singleton {
  id: root
  // property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  readonly property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`
  property string launcherDesc: ""

  function focusingThisMonitor(monitor: HyprlandMonitor): bool {
    return HyprlandData.activeWorkspace?.monitor == monitor?.name
  }

  property var data: {
    if (GlobalState.launcherOpen) {
      return {
        "title": `Ritual Launcher (${GlobalState.launcherMode})`,
        "desc": root.launcherDesc,
        "icon": Apps.getIcon("launcher")
      }
    } else if (GlobalState.trayMenuOpen) {
      return {
        "title": `Test`,
        "desc": "Hello world",
        "icon": Apps.getIcon("systemtray")
      }
    } else if (ToplevelManager?.activeToplevel?.activated) {
      return {
        title: Functions.capitalize(root.activeWindow?.appId),
        desc: root.activeWindow?.title,
        icon: Apps.lookupIcon(root.activeWindow?.appId)
      }
    } else {
      return {
        title: "Desktop",
        desc: `Workspace ${HyprlandData.activeWorkspace?.id}`,
        icon: Apps.getIcon("workspace")
      }
    }
  }

}
