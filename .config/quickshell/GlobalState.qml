pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.config
import qs.services
import Quickshell.Wayland
import qs.utils

// Tray monitor id not needed after all, check TrayMenu state, but I might as
// well track it now that I've configured it here
Singleton {
  id: root
  property bool launcherOpen: false
  property string launcherMonitorId: ""
  property string trayMonitorId: ""
  property string launcherMode: Config.defaultMode
  property bool overlayOpen: root.launcherOpen || Notifications.open || root.trayMenuOpen
  property QsMenuHandle activeMenu: null
  property bool trayMenuOpen: false

  Timer {
    id: timer
    interval: Appearance.durations.small
    onTriggered: {
      root.launcherMonitorId = ""
      root.launcherMode = Config.defaultMode
    }
  }
  function log(val) {
    console.log(JSON.stringify(val, null, 2))
    return val
  }

  function openTrayMenu(menu, id = Config.primaryDisplay) {
    if (!menu) {
      console.error("No provided menu, cant open menu")
      return
    }
    root.activeMenu = menu
    trayMenuOpen = true
    trayMonitorId = id
  }

  function closeTrayMenu() {
    root.activeMenu = null
    trayMenuOpen = false
  }

  function openLauncher(id = Config.primaryDisplay, mode = null) {
    launcherMonitorId = id
    if (mode) {
      root.launcherMode = mode
    }
    launcherOpen = true
  }

  function closeLauncher() {
    launcherOpen = false
    timer.restart()
  }

  function toggleLauncher(id) {
    if (launcherOpen) {
      closeLauncher()
    } else {
      openLauncher(id)
    }
  }
}
