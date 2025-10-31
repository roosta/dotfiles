// import Quickshell
import Quickshell.Io
pragma Singleton
pragma ComponentBehavior: Bound

// import Quickshell.Io
import Quickshell
import QtQuick
// import qs.config
// import qs.utils

Singleton {
  id: root
  property var data: ({})
  property bool open: data?.visible ?? false
  
  Process {
    id: subProc
    command: ["swaync-client", "-s"]
    Component.onCompleted: running = true

    stdout: SplitParser {
      id: collector
      onRead: data => {
        if (data && data.length > 0) {
          root.data = JSON.parse(data)
        }
      }
    }
  }
  Process {
    id: toggleProc
    command: ["swaync-client", "-t", "-sw"]
    running: false
  }
  function toggleNc() {
    toggleProc.running = true
  }
}
