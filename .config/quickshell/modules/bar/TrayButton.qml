// import qs.services
import qs.config
// import qs.utils
import qs.components
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

import QtQuick.Controls
// import Quickshell
// import Quickshell.Hyprland
// import Quickshell.Wayland
// import Quickshell.Widgets

Button {
  id: root
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: parent.height - Appearance.spacing.p3
  implicitHeight: parent.height - Appearance.spacing.p3

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }

  states: [
    State {
      name: "pressed"
      when: root.pressed
      PropertyChanges { bg.borderColor: Appearance.srcery.white }
      PropertyChanges { indicator.color: Appearance.srcery.white }
    },
    State {
      name: "hovered"
      when: root.hovered && !root.pressed
      PropertyChanges { bg.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { indicator.color: Appearance.srcery.white }
    }
  ]
  background: BorderRectangle {
    id: bg
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    Text {
      id: indicator
      anchors.centerIn: parent
      text: "1"
      color: Appearance.srcery.brightBlack
      font {
        family: Appearance.font.light
        pixelSize: Appearance.font.size3
      }

    }
  }
}
