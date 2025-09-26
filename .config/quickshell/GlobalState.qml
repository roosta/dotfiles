pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
  id: root
  property bool launcherOpen: false
  function openLauncher(screen) {
    if (screen) {
      console.log("Handle screen")
    }
    launcherOpen = true
  }
  function closeLauncher() {
    launcherOpen = false
  }
  function toggleLauncher(screen = null) {
    if (launcherOpen) {
      closeLauncher()
    } else {
      openLauncher(screen)
    }

  }
}
