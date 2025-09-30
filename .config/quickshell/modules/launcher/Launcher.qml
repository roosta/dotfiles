import Quickshell
import QtQuick
import qs.config
import qs
import qs.utils
import qs.components

Item {
  id: root
  visible: GlobalState.launcherOpen

  anchors {
    bottom: parent.bottom
    left: parent.left
    right: parent.right
    top: parent.top
  }

  MouseArea {
    anchors.fill: parent
    onClicked: {
      GlobalState.closeLauncher()
    }
  }

  Rectangle {
    anchors.centerIn: parent
    implicitHeight: Appearance.launcher.height
    implicitWidth: Appearance.launcher.width
    color: Appearance.srcery.black
    border.width: 1
    border.color: Appearance.srcery.gray3

    MouseArea {
      anchors.fill: parent
      onClicked: {
        // Consume the click event to prevent it from reaching the parent MouseArea
      }
    }
  }
}
