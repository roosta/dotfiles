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

  background: BorderRectangle {
    color: Appearance.srcery.black
    borderColor: Appearance.srcery.gray3
    borderWidth: Appearance.bar.borderWidth
    anchors.fill: parent

    Shape {
      anchors.centerIn: parent
      id: shape
      width: Appearance.bar.iconSize
      height: Appearance.bar.iconSize
      ShapePath {
        strokeWidth: 1
        strokeColor: Appearance.srcery.gray3
        fillColor: Appearance.srcery.black
        PathSvg { 
          path: "M 10 1.7 L 18.3 16.3 L 1.7 16.3 Z"
        }
      }
    }
  }

}
