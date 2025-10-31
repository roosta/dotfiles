import qs.services
import qs.config
import qs.utils
import qs.components
import QtQuick
// import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets

Button {
  id: root
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: parent.height - Appearance.spacing.p3
  implicitHeight: parent.height - Appearance.spacing.p3

  property bool active: Notifications?.data?.count ?? false

  HoverHandler {
    id: hover
    cursorShape: Qt.PointingHandCursor
  }
  
  onPressed: {
    Notifications.toggleNc()
  }
  states: [
    State {
      name: "open"
      when: Notifications.open && !root.hovered && !root.pressed && !root.active
      PropertyChanges { shape.rotation: 90 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }

    },
    State {
      name: "openActive"
      when: Notifications.open && !root.hovered && !root.pressed && root.active
      PropertyChanges { shape.rotation: 90 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }

    },
    State {
      name: "active"
      when: root.active && !root.hovered && !root.pressed && !Notifications.open
      PropertyChanges { shape.rotation: 180 }
      PropertyChanges { path.strokeColor: Appearance.srcery.white }
      PropertyChanges { rect.borderColor: Appearance.srcery.gray5 }
    },
    State {
      name: "activeHovered"
      when: root.active && root.hovered && !root.pressed && !Notifications.open
      PropertyChanges { shape.rotation: 180 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }
    },
    State {
      name: "hovered"
      when: hover.hovered && !root.pressed && !root.active && !Notifications.open
      PropertyChanges { rect.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightWhite }

    },
    State {
      name: "pressed"
      when: root.pressed && hover.hovered && !root.active && !Notifications.open
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlue }
      PropertyChanges { path.strokeColor: Appearance.srcery.brightBlue }
    }

  ]

  transitions: [
    Transition {
      NumberAnimation { 
        properties: "rotation"
        duration: Appearance.durations.normal
        easing.type: Easing.InOutCubic
      }
      ColorAnimation { 
        duration: Appearance.durations.small
        easing.type: Easing.OutQuad 
      }
    }
  ]
  background: BorderRectangle {
    id: rect
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    anchors.fill: parent

    Shape {
      id: shape
      anchors.centerIn: parent
      width: Appearance.bar.iconSize
      height: Appearance.bar.iconSize
      ShapePath {
        strokeWidth: 1
        id: path
        strokeColor: Appearance.srcery.gray3
        fillColor: Appearance.srcery.black
        PathSvg { 
          id: svg
          path: "M 10 1.7 L 18.3 16.3 L 1.7 16.3 Z"
        }
      }
    }
  }
}
