pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell.Io
import Quickshell
import QtQuick
import qs.services
// import qs.utils

Singleton {
  id: root
  property bool audioIn: PipewireData.audioIn.length > 0
  property bool videoIn: false
  property bool audioOut: PipewireData.audioOut.length > 0
  property bool hasAlerts: audioIn || cpuUsage
  property bool cpuUsage: ResourceUsage.cpuUsage >= 0.8

}
