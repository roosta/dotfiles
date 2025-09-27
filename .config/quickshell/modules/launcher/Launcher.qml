import Quickshell
import QtQuick
import qs.config
import qs
import qs.utils

PanelWindow {
  id: root
  visible: GlobalState.launcherOpen
  color: Functions.transparentize("#000", 0.8)
  anchors {
    bottom: true
    left: true
    right: true
    top: true
  }

  Rectangle {
    anchors.centerIn: parent
    implicitHeight: Appearance.launcher.height
    implicitWidth: Appearance.launcher.width
    color: Appearance.srcery.black
    border.width: 1
    border.color: Appearance.srcery.gray3

  }
}
