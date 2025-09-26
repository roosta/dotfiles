import Quickshell
import QtQuick
import qs.config
import qs

PanelWindow {
  id: root
  color: "transparent"
  visible: GlobalState.launcherOpen
  
  implicitHeight: Appearance.launcher.height
  implicitWidth: Appearance.launcher.width
  
  Rectangle {
    anchors.fill: parent
    color: Appearance.srcery.black
    border.width: 1
    border.color: Appearance.srcery.gray3

  }
}
