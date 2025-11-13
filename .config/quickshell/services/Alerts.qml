pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick
// import Quickshell.Services.Pipewire
// import qs.config
// import qs.utils

Singleton {
  id: root
  property bool hasAlerts: false
}
