import Quickshell
import QtQuick
import qs.config
import qs
import qs.utils
import qs.components

Item {
  id: root
  visible: height > 0
  anchors.bottom: parent.bottom
  anchors.horizontalCenter: parent.horizontalCenter
  anchors.bottomMargin: Appearance.bar.height
  implicitWidth: Appearance.launcher.width
  implicitHeight: 0

  // MouseArea {
  //   anchors.fill: parent
  //   onClicked: {
  //     GlobalState.closeLauncher()
  //   }
  // }

  states: [
    State {
      name: "active"
      when: GlobalState.launcherOpen
      PropertyChanges { root.implicitHeight: Appearance.launcher.height }
    }
  ]
  transitions: [
    Transition {
      NumberAnimation { 
        properties: "implicitHeight"
        duration: 200
        easing.type: Easing.InOutCubic
      }
    }
  ]
  BorderRectangle {
    anchors.fill: parent
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    topBorder: 1
    leftBorder: 1
    rightBorder: 1


    // MouseArea {
    //   anchors.fill: parent
    //   onClicked: {
    //     // Consume the click event to prevent it from reaching the parent MouseArea
    //   }
    // }
  }
}
