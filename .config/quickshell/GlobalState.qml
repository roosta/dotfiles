pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property bool launcherOpen: false
  property string activeMonitorId: ""
  
  function openLauncher(screen) {
    if (screen) {
      activeMonitorId = screen.name
    }
    launcherOpen = true
  }
  
  function closeLauncher() {
    launcherOpen = false
    activeMonitorId = ""
  }
  
  function toggleLauncher(screen = null) {
    if (launcherOpen) {
      closeLauncher()
    } else {
      openLauncher(screen)
    }
  }
}
