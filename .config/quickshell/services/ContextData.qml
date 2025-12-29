pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.services
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.utils

Singleton {
  id: root
  // property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
  property Toplevel activeWindow: ToplevelManager.activeToplevel
  property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`

  function focusingThisMonitor(monitor: HyprlandMonitor): bool {
    return HyprlandData.activeWorkspace?.monitor == monitor?.name
  }

  property var data: {
    if (ToplevelManager?.activeToplevel?.activated) {
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
