pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.config

Singleton {
  id: root
  property bool launcherOpen: false
  property string activeMonitorId: ""
  property string launcherMode: Config.defaultMode
  
  function openLauncher(id, mode = null) {
    if (!id) {
      console.error("No id supplied to launcher!")
      return
    }
    activeMonitorId = id
    if (mode) {
      root.launcherMode = mode
    }
    launcherOpen = true
  }
  
  function closeLauncher() {
    launcherOpen = false
    activeMonitorId = ""
    launcherMode = Config.defaultMode
  }
  
  function toggleLauncher(id) {
    if (launcherOpen) {
      closeLauncher()
    } else {
      openLauncher(id)
    }
  }
}
