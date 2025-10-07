pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property bool launcherOpen: false
  property string activeMonitorId: ""
  
  function openLauncher(id) {
    if (id) {
      activeMonitorId = id
    }
    launcherOpen = true
  }
  
  function closeLauncher() {
    launcherOpen = false
    activeMonitorId = ""
  }
  
  function toggleLauncher(id = null) {
    if (launcherOpen) {
      closeLauncher()
    } else {
      openLauncher(id)
    }
  }
}
