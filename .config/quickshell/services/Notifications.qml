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
  property var data: []
  Process {
    id: getNotifications
    command: ["swaync-client", "-s"]
    running: true

    stdout: SplitParser {
      id: collector
      onRead: data => {
        if (data && data.length > 0) {
          root.data = JSON.parse(data)
        }
      }
    }
  }
}
