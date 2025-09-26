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
  property int size: 20

  // color: Appearance.srcery.brightWhite
  Layout.topMargin: Appearance.bar.borderWidth
  implicitWidth: parent.height - Appearance.spacing.p3
  implicitHeight: parent.height - Appearance.spacing.p3

  background: BorderRectangle {
    id: asd
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    anchors.fill: parent
    Shape {
      anchors.centerIn: parent
      id: shape
      ShapePath {
        strokeWidth: 1
        strokeColor: Appearance.srcery.gray3
        fillColor: Appearance.srcery.black
        PathSvg { 
          // Normalized triangle path (0-1 coordinates)
          // path: "M 0,1 0.5,0 1,1 Z"
          // path: "M 80,73 123,-2 166,73 Z"
          // path: "M 119,123 157,56 196,123 Z"
        }
      }
    }
  }
}
