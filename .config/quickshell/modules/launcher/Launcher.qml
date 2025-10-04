import Quickshell
import QtQuick
import qs.config
import qs
import qs.utils
import qs.components

Item {
  id: root
  required property string monitorId
  visible: height > 0
  anchors.bottom: parent.bottom
  anchors.horizontalCenter: parent.horizontalCenter
  anchors.bottomMargin: Appearance.bar.height + Appearance.spacing.p1
  implicitWidth: Appearance.launcher.width
  implicitHeight: 0

  states: [
    State {
      name: "active"
      when: GlobalState.launcherOpen && GlobalState.activeMonitorId === root.monitorId
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
    gradientAngle: 45
    color: Appearance.srcery.black
    borderWidth: 1
    gradient: Gradient {
      orientation: Gradient.Horizontal
      GradientStop { position: 0; color: Appearance.srcery.magenta }
      GradientStop { position: 1; color: Appearance.srcery.blue }
    }

    MouseArea {
      anchors.fill: parent
      onClicked: {
        // Consume the click event to prevent it from reaching the parent MouseArea
      }
    }

  }
}
