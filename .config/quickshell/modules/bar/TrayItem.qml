pragma ComponentBehavior: Bound

import qs.config

import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell
import QtQuick

MouseArea {
  id: root
  required property SystemTrayItem modelData
  acceptedButtons: Qt.LeftButton | Qt.RightButton
  implicitWidth: Appearance.font.size3
  implicitHeight: Appearance.font.size3
  
  onClicked: event => {
    if (event.button === Qt.LeftButton)
      modelData.activate();
    else
      modelData.secondaryActivate();
  }
  IconImage {
    id: icon
    anchors.fill: parent
    source: root.modelData.icon
    // Layout.margins: Appearance.spacing.p2
    // implicitWidth: icon.height
  }
}
