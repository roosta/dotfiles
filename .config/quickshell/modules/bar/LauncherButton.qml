import qs.services
import qs.config
import qs.utils
import qs.components
import qs
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

Button {
  id: root

  // color: Appearance.srcery.brightWhite
  required property string monitorId
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: Appearance.bar.height - Appearance.spacing.p3
  implicitHeight: Appearance.bar.height - Appearance.bar.borderWidth - Appearance.spacing.p1 * 2

  onPressed: {
    GlobalState.toggleLauncher(root.monitorId)
  }

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  background: BorderRectangle {
    id: outerRect
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    BorderRectangle {
      id: innerRect
      anchors.centerIn: parent
      implicitWidth: parent.width * 0.5
      implicitHeight: parent.height * 0.5
      borderWidth: Appearance.bar.borderWidth
      color: Appearance.srcery.black
      rotation: 45
      borderColor: Appearance.srcery.gray3
    }
  }

  states: [

    State {
      name: "active"
      when: GlobalState.launcherOpen && GlobalState.launcherMonitorId === root.monitorId
      PropertyChanges { innerRect.rotation: 0 }
      PropertyChanges { outerRect.borderColor: Appearance.srcery.brightBlack }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
    },
    State {
      name: "hovered"
      when: hover.hovered
      PropertyChanges { outerRect.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { innerRect.borderColor: Appearance.srcery.brightWhite }
    }
  ]

  transitions: [
    Transition {
      NumberAnimation {
        properties: "rotation"
        duration: Appearance.durations.normal
        easing.type: Easing.OutCubic
      }
      ColorAnimation {
        duration: Appearance.durations.small
        easing.type: Easing.OutQuad
      }
    }
  ]
}
