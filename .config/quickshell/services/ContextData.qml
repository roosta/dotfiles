pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.services
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.utils
import qs.config
import qs

Singleton {
  id: root
  // property HyprlandMonitor monitor: Hyprland.monitorFor(root.QsWindow.window?.screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  readonly property string activeWindowAddress: `0x${activeWindow?.HyprlandToplevel?.address}`
  property string launcherDesc: ""
  property string trayDesc: ""


  function focusingThisMonitor(monitor: HyprlandMonitor): bool {
    return HyprlandData.activeWorkspace?.monitor == monitor?.name
  }

  property string launcherIcon: {
    const mode = Config.modeMenu.find(m => m.mode === GlobalState.launcherMode)
    if (mode) {
      return Quickshell.iconPath(mode.iconId)
    }
  }

            // iconSource: Quickshell.iconPath(modelData.iconId)
  property var data: {
    if (GlobalState.launcherOpen) {
      return {
        "title": `${Functions.capitalize(GlobalState.launcherMode)}`,
        "desc": root.launcherDesc,
        "icon": GlobalState.launcherMode === "menu"
          ? Quickshell.iconPath("menulibre")
          : root.launcherIcon
      }
    } else if (GlobalState.trayMenuOpen) {
      return {
        "title": `System Tray Menu`,
        "desc": root.trayDesc,
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
