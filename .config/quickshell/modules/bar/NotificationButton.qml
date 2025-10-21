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
      name: "active"
      when: root.active && !root.hovered && !root.pressed
      PropertyChanges { triangle.opacity: 0.0 }
      PropertyChanges { exclamation.opacity: 1.0 }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }
    },
    State {
      name: "activeHovered"
      when: root.active && root.hovered && !root.pressed
      PropertyChanges { triangle.opacity: 0.0 }
      PropertyChanges { exclamation.opacity: 1.0 }
      PropertyChanges { exclamationPath.strokeColor: Appearance.srcery.brightWhite }
      PropertyChanges { rect.borderColor: Appearance.srcery.brightBlack }
    },
    State {
      name: "hovered"
      when: hover.hovered && !root.pressed && !root.active
      PropertyChanges { rect.borderColor: Appearance.srcery.gray6 }
      PropertyChanges { trianglePath.strokeColor: Appearance.srcery.brightWhite }

    }
    // ,
    // State {
    //   name: "pressed"
    //   when: root.pressed && !hover.hovered && !root.active
    //   PropertyChanges { rect.borderColor: Appearance.srcery.white }
    //   PropertyChanges { trianglePath.strokeColor: Appearance.srcery.brightWhite }
    //
    // }

  ]

  transitions: [
    Transition {
      NumberAnimation { 
        properties: "opacity"
        duration: 200
        easing.type: Easing.InOutCubic
      }
      ColorAnimation { 
        duration: 50
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
      id: triangle
      anchors.centerIn: parent
      opacity: 1.0
      width: Appearance.bar.iconSize
      height: Appearance.bar.iconSize
      ShapePath {
        strokeWidth: 1
        id: trianglePath
        strokeColor: Appearance.srcery.gray3
        fillColor: Appearance.srcery.black
        PathSvg { 
          id: svg
          path: "M 10 1.7 L 18.3 16.3 L 1.7 16.3 Z"
        }
      }
    }
    Shape {
      anchors.centerIn: parent
      id: exclamation
      width: Appearance.bar.iconSize
      height: Appearance.bar.iconSize
      opacity: 0.0
      ShapePath {
        strokeWidth: 1
        id: exclamationPath
        strokeColor: Appearance.srcery.white
        fillColor: Appearance.srcery.black
        PathSvg { 
          path: "M 8 2.7 L 12 2.7 L 12 12.7 L 8 12.7 Z M 8 14.7 L 12 14.7 L 12 17.3 L 8 17.3 Z"
        }
      }
    }

  }

}
